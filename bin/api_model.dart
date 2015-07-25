library jit_models;

import 'dart:async';
import 'package:angular_dart_demo/shared/schemas.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:connection_pool/connection_pool.dart';
import 'mongo_pool.dart';
import "dart:mirrors";

class Config {
  static const String DATABASE_NAME = 'Airport';
  static const String DATABASE_URL = 'mongodb://127.0.0.1/';
  static const String DATABASE_SEED = 'db/data/seed.json';
}

class BaseMongoModel {

  static final MongoPool _dbPool = new MongoPool(Config.DATABASE_URL + Config.DATABASE_NAME, 10);

  Future<Map> createByItem(BaseDTO item) async {
    assert(item.id == null);
    item.id = new ObjectId();
    return _dbPool.getConnection().then((ManagedConnection mc) {
      Db db = mc.conn;
      DbCollection collection = db.collection(item.collection_key);
      Map aMap = voToMongoMap(item);
      return collection.insert(aMap).then((status) {
        _dbPool.releaseConnection(mc);
        return (status['ok'] == 1) ? item : _;
      });
    });
  }

  Future<Map> deleteByItem(BaseDTO item) async {
    assert(item.id != null);
    return _dbPool.getConnection().then((ManagedConnection mc) {
      Db database = mc.conn;
      DbCollection collection = database.collection(item.collection_key);
      Map aMap = voToMongoMap(item);
      return collection.remove(aMap).then((status) {
        _dbPool.releaseConnection(mc);
        return status;
      });
    });
  }

  Future<BaseDTO> readItemByItem(BaseDTO matcher) async {
    assert(matcher.id != null);
    Map query = {'_id': matcher.id};
    BaseDTO bvo;
    return _getCollection(matcher.collection_key, query).then((items) {
      bvo = mapToVO(getInstance(matcher.runtimeType), items.first);
      return bvo;
    });
  }

  Future<List> readCollectionByTypeWhere(t, fieldName, values) async {
    List list = new List();
    BaseDTO freshInstance = getInstance(t);
    return _getCollectionWhere(freshInstance.collection_key, fieldName, values).then((items) {
      items.forEach((item) {
        list.add(mapToVO(getInstance(t), item));
      });
      return list;
    });
  }

  Future<List> readCollectionByType(t, [Map query = null]) async {
    List list = new List();
    BaseDTO freshInstance = getInstance(t);
    return _getCollection(freshInstance.collection_key, query).then((items) {
      items.forEach((item) {
        list.add(mapToVO(getInstance(t), item));
      });
      return list;
    });
  }

  Future<Map> updateItem(BaseDTO item) async {
    assert(item.id != null);
    return _dbPool.getConnection().then((ManagedConnection mc) async {
      Db database = mc.conn;
      DbCollection collection = new DbCollection(database, item.collection_key);
      Map selector = {'_id': item.id};
      Map newItem = voToMongoMap(item);
      return await collection.update(selector, newItem).then((_) {
        _dbPool.releaseConnection(mc);
        return _;
      });
    });
  }

  // Some Abstractions

  Future<List> _getCollectionWhere(String collectionName, fieldName, values) {
    return _dbPool.getConnection().then((ManagedConnection mc) async {
      Db database = mc.conn;
      DbCollection collection = new DbCollection(database, collectionName);
      SelectorBuilder builder = where.oneFrom(fieldName, values);
      return await collection.find( builder ).toList().then((map) {
        _dbPool.releaseConnection(mc);
        return map;
      });
    });
  }

  Future<List> _getCollection(String collectionName, [Map query = null]) {
    return _dbPool.getConnection().then((ManagedConnection mc) async {
      DbCollection collection = new DbCollection(mc.conn, collectionName);
      return await collection.find(query).toList().then((List<map> maps){
        _dbPool.releaseConnection(mc);
        return maps;
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

  dynamic mapToVO(cleanObject, Map document) {
    var reflection = reflect(cleanObject);
    document['id'] = document['_id'];
    document.remove('_id');
    document.forEach((k, v) {
      reflection.setField(new Symbol(k), v);
    });
    return cleanObject;
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
      type = type.superclass;
      // get properties from superclass too!
    }

    return target;
  }

  Map voToMongoMap(object) {
    Map item = voToMap(object);

    // mongo uses an underscore prefix which would act as a private field in dart
    // convert only on write to mongo

    item['_id'] = item['id'];
    item.remove('id');
    return item;
  }
}


