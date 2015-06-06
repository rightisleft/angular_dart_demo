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
  return _genericJsonHandler(model.getAllCities);
}

Future <Response> handleRoutes(Request request) async {
  return _genericJsonHandler(model.getAllRoutes);
}

Future <Response> handleTimes(Request request) async {
  return _genericJsonHandler(model.getAllTimes);
}

Future <Response> handleTickets(Request request) async {
  return _genericJsonHandler(model.getAllTimes);
}

Future <Response> _genericJsonHandler(Function getter) async {
  return getter()
  .then( ( list ) => _listToJson(list) )
  .then( (json) =>  new Response.ok( json, headers: {'content-type': 'text/json', 'Access-Control-Allow-Origin': '*'} ) );
}

String _listToJson(List list) {
  dynamic encodable = converter.serialize(list);
  return JSON.encode(encodable);
}
