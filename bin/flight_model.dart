library jit_model;
import 'dart:async';
import 'api_model.dart';
import 'package:angular_dart_demo/shared/schemas.dart';

class FlightDataModel extends Object with BaseMongoModel {

  Future <List> getAllCities(Map params) {
    return readCollectionByType(CitiesVO);
  }

  Future <List> getAllRoutes(Map params) {
//    Map query = {'route': vo.cityDepart + "_" + vo.cityArrival};
    return readCollectionByType(RouteVO);
  }

  Future <List> getAllTimes(Map params) {
    return readCollectionByType(TimeVO);
  }

  Future <List> getTimesByCity(Map params) {
    FlightPostParamsVO vo = new FlightPostParamsVO.FromPost(params);
    Map query = {'arrival': vo.cityArrival, 'departure': vo.cityDepart};
    return readCollectionByType(TimeVO, query);
  }
}