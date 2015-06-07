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

class BaseMongoModel {

  final MongoDbPool _dbPool = new MongoDbPool(Config.DATABASE_URL + Config.DATABASE_NAME, 10);

  Future<Map> createByItem(BaseVO item) async {
    assert(item.id == null);
    item.id = new ObjectId();
    return _dbPool.openNewConnection().then((Db database) {
      DbCollection collection = database.collection(item.collection_key);
      Map aMap = voToMongoMap(item);
      return collection.insert(aMap).then((_) {
        _dbPool.closeConnection(database);
        return _;
      });
    });
  }

  Future<Map> deleteByItem(BaseVO item) async {
    assert(item.id != null);
    return _dbPool.openNewConnection().then((Db database) {
      DbCollection collection = database.collection(item.collection_key);
      Map aMap = voToMongoMap(item);
      return collection.remove(aMap).then((_) {
        _dbPool.closeConnection(database);
        return _;
      });
    });
  }

  Future<BaseVO> readItemByItem(BaseVO matcher) async {
    assert(matcher.id != null);
    Map query = {'_id': matcher.id};
    BaseVO bvo;
    return _getCollection(matcher.collection_key, query).then((items) {
      bvo = mapToVO( getInstance(matcher.runtimeType), items.first);
      return bvo;
    });
  }

  Future<List> readCollectionByType(t, [Map query = null]) async {
    BaseVO vo = getInstance(t);
    List list = new List();
    return _getCollection(vo.collection_key, query).then((items) {
      items.forEach((item) {
        list.add(mapToVO(getInstance(t), item));
      });
      return list;
    });
  }

  Future<Map> updateItem(BaseVO item) async {
    assert(item.id != null);
    _dbPool.openNewConnection().then((Db database) {
      return database.open().then((bool isOpen) async {
        DbCollection collection = new DbCollection(database, item.collection_key);
        Map selector = {'_id': item.id};
        Map newItem = voToMongoMap(item);
        return await collection.update(selector, newItem);
      });
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
    return _dbPool.openNewConnection().then((Db conn) {
      return conn.open().then((bool isOpen) async {
        DbCollection collection = new DbCollection(conn, collectionName);
        return await collection.find(query).toList().then((map) {
          _dbPool.closeConnection(conn);
          return map;
        });
      });
    });
  }

  dynamic getInstance(Type t) {
    MirrorSystem mirrors = currentMirrorSystem();
    LibraryMirror lm = mirrors.libraries.values.firstWhere(
            (LibraryMirror lm) => lm.qualifiedName == new Symbol('jit_schemas'));
    ClassMirror cm = lm.declarations[new Symbol(t.toString())];
    InstanceMirror im = cm.newInstance(new Symbol(''), []);
    return im.reflectee;
  }

  dynamic mapToVO(object, Map json) {
    var reflection = reflect(object);
    json['id'] = json['_id'];
    json.remove('_id');
    json.forEach((k, v) {
      reflection.setField(new Symbol(k), v);
    });
    return object;
  }

  Map voToMap(Object object) {
    var reflection = reflect(object);
    Map target = new Map();
    var type = reflection.type;

    while (type != null) {
      type.declarations.values.forEach((item) {
        if (item is VariableMirror) {
          VariableMirror value = item;
          if (!value.isFinal) {
            target[MirrorSystem.getName(value.simpleName)] = reflection.getField(value.simpleName).reflectee;
          }
        };
      });
      type = type.superclass; // get properties from superclass too!
    }

    return target;
  }

  Map voToMongoMap(object) {
    Map item = voToMap(object);

    // mongo uses a underscore prefix which would act as a private field in dart
    // convert only on write to mongo
    item['_id'] = item['id'];
    item.remove('id');
    return item;
  }
}


