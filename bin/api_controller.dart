library flight_controller;

import 'package:shelf/shelf.dart';
import 'flight_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dartson/dartson.dart';

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

Future <Response> handleRoutes(Request request) async {
  return _genericJsonHandler(model.getAllRoutes, request);
}

Future <Response> handleTimesCity(Request request) async {
  return _genericJsonHandler(model.getTimesByCity, request);
}

Future <Response> handleTimes(Request request) async {
  return _genericJsonHandler(model.getAllTimes, request);
}

Future <Response> handleTickets(Request request) async {
  return _genericJsonHandler(model.getAllTimes, request);
}

Future <Response> _genericJsonHandler(Function getter, Request request) async {
  return getParams(request)
  .then( ( params ) => getter( params ) )
  .then( ( list ) => _listToJson( list ) )
  .then( makeResponse );
}

Future<Response> makeResponse( json ) async {
  var response = new Response.ok( json );
  return response;
}

String _listToJson(List list) {
  dynamic encodable = converter.serialize(list);
  return JSON.encode(encodable);
}

Future<Map> getParams(Request request) {
  return request.readAsString().then( (String body) {
    return body.isNotEmpty ? JSON.decode(body) : {};
  });
}
