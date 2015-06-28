library flight_controller;

import 'package:shelf/shelf.dart';
import 'package:shelf_path/shelf_path.dart' as path;
import 'flight_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dartson/dartson.dart';
import 'dart:collection';

class Config {
  static const String DATABASE_NAME = 'Airport';
  static const String DATABASE_URL = 'mongodb://127.0.0.1/';
  static const String DATABASE_SEED = 'db/data/seed.json';
}

FlightDataModel model = new FlightDataModel();

var converter = new Dartson.JSON();

Future <Response> handleCitites(Request request) async {
  return _genericJsonHandler(model.getAllCities, request);
}

Future <Response> handleTimesCity(Request request) async {
  return _genericJsonHandler(model.getTimesByCity, request);
}

handleFlightNumber(Request request) async {
  return _genericJsonHandler(model.getTimesByNumber, request);
}

Future <Response> handleTimes(Request request) async {
  return _genericJsonHandler(model.getAllTimes, request);
}

Future <Response> handleTickets(Request request) async {
  return _200Handler(model.createPurchase, request);
}

Future <Response> _200Handler(Function getter, Request request) async {
  return getPostParams(request)
  .then( ( params ) => getPathParams( request , params ) )
  .then( ( json ) => getter( json ) )
  .then( (json ) => new Response.ok('') );
}

Future <Response> _genericJsonHandler(Function getter, Request request) async {
  return getPostParams(request)
  .then( ( params ) => getPathParams( request , params ) )
  .then( ( json ) => getter( json ) )
  .then( ( list ) => _dartsonListToJson( list ) )
  .then( makeResponse );
}

Future<Response> makeResponse( json ) async {
  var response = new Response.ok( json );
  return response;
}

String _dartsonListToJson(List list) {
  dynamic encodable = converter.serialize(list);
  return JSON.encode(encodable);
}

Map getPathParams(Request request, Map json) {
  Map params = path.getPathParameters(request);
  params.forEach( (key, val) {
    json[key] = val;
  });

  return json;
}

Future<Map> getPostParams(Request request) {
  return request.readAsString().then( (String body) {
    return body.isNotEmpty ? JSON.decode(body) : {};
  });
}
