library jit_model;
import 'dart:async';
import 'backend_model.dart';
import 'package:angular_dart_demo/shared/schemas.dart';

class FlightDataModel extends Object with GenericModel {

  Future <List> getAllCities() {
    return readCollectionByType(CitiesVO);
  }

  Future <List> getAllRoutes() {
    return readCollectionByType(RouteVO);
  }

  Future <List> getAllTimes() {
    return readCollectionByType(TimeVO);
  }
}
