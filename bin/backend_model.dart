library jit_models;

import 'dart:async';
import 'package:angular_dart_demo/shared/schemas.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'mongo_pool.dart';
import "dart:mirrors";

class Config {
  static const String DATABASE_NAME = 'Airport';
  static const String DATABASE_URL = 'mongodb://127.0.0.1/';
  static const String DATABASE_SEED = 'db/data/seed.json';
}

class GenericModel {

  static final Db database = new Db(Config.DATABASE_URL + Config.DATABASE_NAME);
  final MongoDbPool _dbPool = new MongoDbPool(Config.DATABASE_URL + Config.DATABASE_NAME, 10);

// Todo: database.open needs pooling
  Future<Map> createByItem(BaseVO item) async {
    assert(item.id == null);
    item.id = new ObjectId();
    return database.open().then((bool isOpen) async {
      DbCollection collection = new DbCollection(database, item.collection_key);
      return await collection.insert(_voToMap( item ));
    });
  }

  Future<List> readCollectionByType(t, [Map query = null]) async {
    BaseVO vo = _getInstance(t);
    List list = new List();
    return _getCollection(vo.collection_key, query).then((items) {
      items.forEach((item) {
        list.add(_mapToVO(_getInstance(t), item));
      });
      return list;
    });
  }

  Future<BaseVO> readItemByItem(BaseVO matcher) async {
    assert(matcher.id != null);
    Map query = {'_id': matcher.id};
    return _getCollection(matcher.collection_key, query).then( (Cursor cursor) {
      return _mapToVO(
          _getInstance(matcher.runtimeType), cursor.items.elementAt(0));
    });
  }

  Future<Map> updateItem(BaseVO item) async {
    assert(item.id != null);
    return database.open().then((bool isOpen) async {
      DbCollection collection = new DbCollection(database, item.collection_key);
      Map selector = {'_id': item.id};
      Map newItem = _voToMap( item );
      return await collection.update(selector, newItem);
    });
  }

// Todo: database.open needs pooling
  Future<Map> deleteByItem(BaseVO item) async {
    assert(item.id != null);
    return database.open().then((bool isOpen) async {
      DbCollection collection = new DbCollection(database, item.collection_key);
      return await collection.remove(_voToMap( item ));
    });
  }

  //Abstractions

  //
  //
  //
  //
  //
  //


  Future<Cursor> _getCollection(String collectionName, [Map query = null]) {
    return _dbPool.openNewConnection().then( (Db conn) {
      return conn.open().then( (bool isOpen) async {
        DbCollection collection = new DbCollection(conn, collectionName);
        return await collection.find(query).toList().then( (map) {
          _dbPool.closeConnection(conn);
          return map;
        });
      });
    });
  }

  dynamic _getInstance(Type t) {
    MirrorSystem mirrors = currentMirrorSystem();
    LibraryMirror lm = mirrors.libraries.values.firstWhere(
            (LibraryMirror lm) => lm.qualifiedName == new Symbol('jit_schemas'));
    ClassMirror cm = lm.declarations[new Symbol(t.toString())];
    InstanceMirror im = cm.newInstance(new Symbol(''), []);
    return im.reflectee;
  }

  dynamic _mapToVO(object, Map json) {
    var reflection = reflect(object);
    json['id'] = json['_id'];
    json.remove('_id');
    json.forEach((k, v) {
      reflection.setField(new Symbol(k), v);
    });
    return object;
  }

  Map _voToMap(Object object)
  {
    InstanceMirror im = reflect(object);
    Map aMap = new Map();

    for (var declaration in im.type.declarations.values)
    {
      // We only want the variables
      if (declaration is VariableMirror)
      {
        String aName = MirrorSystem.getName(declaration.simpleName);
        String aValue = im.getField(declaration.simpleName).reflectee;

        aMap[aName] = aValue;
      }
    }
    return aMap;
  }
}


