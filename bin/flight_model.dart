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

  getTimesByCity(Map params) async {
    FlightPostParamsVO vo = new FlightPostParamsVO.FromPost(params);

    Map query = {'arrival': vo.cityArrival, 'departure': vo.cityDepart};
    List<TimeVO> time_vos = await readCollectionByType(TimeVO, query);

    query = {'route': time_vos.first.departure + "_" + time_vos.first.arrival};
    return readCollectionByType(RouteVO, query).then((List rvos) {
      time_vos.forEach((TimeVO vo) => vo.rvo = rvos.first);
      return time_vos;
    });
  }
}
