import 'dart:io';
import 'dart:async';
import 'package:json_object/json_object.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:angular_dart_demo/shared/schemas.dart';


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
      .then( (String item) => new JsonObject.fromJsonString(item) )
      .then( _printJson )
      .then( _insertJsonToMongo )
      .then( _mapTimeToRoute );
  }

  Future<Db> _insertJsonToMongo(JsonObject json) async
  {
    Db database = new Db(_dbURI + _dbName);
    await database.open();
    json.keys.forEach((String collectionName)
    {
      DbCollection collection = new DbCollection(database, collectionName);
      print(' json[collectionName]');
      print(json[collectionName]);
      collection.insertAll( json[collectionName] );
    });
    return database;
  }

  Future _mapTimeToRoute(Db database) async{
    DbCollection timeCollection = database.collection('Times');
    DbCollection routes = database.collection('Routes');

    timeCollection.find().toList().then((List times){
      times.forEach((time){
        var route = time['departure'] + '_' + time['arrival'];
        routes.find({'route': route}).nextObject().then((Map item){
          time['route_id'] = item['_id'];
          timeCollection.save(time);
        });
      });
    });
    return null;
  }

  JsonObject _printJson(JsonObject json)
  {
    json.keys.forEach((String collection)
    {
      print('Collections: ' + collection);
      var documents = json[collection];
      print('Document: '+ documents.toString() );
      documents.forEach((row){
        print('Row: ' + row.toString() );
      });
    });
    return json;
  }
}
