import 'dart:io';
import 'dart:async';
import 'package:json_object/json_object.dart';
import 'package:mongo_dart/mongo_dart.dart';


main() {
  var importer = new DataImporterJIT('Airport', 'mongodb://127.0.0.1/', 'bin/db/seed.json');
  importer._readFile();
}

class DataImporterJIT {
  final String _dbURI;
  final String _dbName;
  final String _dbSeedFile;

  DataImporterJIT(String this._dbName, String this._dbURI, String this._dbSeedFile);

  void _readFile() {
    File aFile = new File(_dbSeedFile);
    aFile.readAsString()
    .then((String item) => new JsonObject.fromJsonString(item))
    .then(_printJson)
    .then(_insertJsonToMongo)
    .then(_mapTimeToRoute)
    .then(_closeDatabase);
  }

  Future<Db> _insertJsonToMongo(JsonObject json) async
  {
    Db database = new Db(_dbURI + _dbName);
    await database.open();
    json.keys.forEach((String collectionName) {
      DbCollection collection = new DbCollection(database, collectionName); //grabs the collection instance
      collection.insertAll(json[collectionName]); //takes a list of maps and writes to a collection
    });
    return database;
  }


  Future _mapTimeToRoute(Db database) {

    DbCollection timeCollection = database.collection('Times');
    DbCollection routesCollection = database.collection('Routes');

    //return initial future
    return timeCollection.find().toList().then( ( List times) {

      // each 'time' value has an async process to read and write
      // we want the transaction to complete prior to finishing the Future
      return Future.forEach(times, (time) async {

        //create a key
        var routeKey = time['departure'] + '_' + time['arrival'];

        //retrieve the route
        List routes = await routesCollection.find({'route': routeKey}).toList();

        // this is the core goal
        time['route_id'] = routes.first['_id'];

        // only complete the future when the sav is finished
        await timeCollection.save(time);
      }).then((_){
        return database;
      });
    });
  }

  JsonObject _printJson(JsonObject json) {
    json.keys.forEach((String collection) {
      print('Collections: ' + collection);
      var documents = json[collection];
      print('Document: ' + documents.toString());
      documents.forEach((row) {
        print('Row: ' + row.toString());
      });
    });
    return json;
  }

  void _closeDatabase(Db database) {
    database.close().then( (_) {
      exit(0);
    });
  }
}
