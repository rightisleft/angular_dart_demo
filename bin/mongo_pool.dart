import 'package:connection_pool/connection_pool.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:async';

class MongoPool extends ConnectionPool<Db> {

  String uri;

  MongoPool(String this.uri, int poolSize) : super(poolSize);

  //overrides ConnectionPool
  void closeConnection(Db conn) {
    conn.close();
  }

  //overrides ConnectionPool
  Future<Db> openNewConnection() {
    var conn = new Db(uri);
    return conn.open().then((_) => conn);
  }
}
