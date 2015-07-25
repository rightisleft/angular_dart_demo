library jit_model;
import 'dart:async';
import 'api_model.dart';
import 'package:angular_dart_demo/shared/schemas.dart';
import 'package:dartson/dartson.dart';

class FlightDataModel extends Object with BaseMongoModel {

  createPurchase(Map params) async {
    var dson = new Dartson.JSON();
    PurchaseDTO object = dson.map(params, new PurchaseDTO() );
    TransactionDTO tvo = new TransactionDTO();
    tvo.paid = 100;
    tvo.user = object.pEmail;
    return createByItem(tvo);
  }

  Future <List> getAllCities(Map params) {
    return readCollectionByType(CityDTO);
  }

  Future <List> getAllTimes(Map params) {
    return readCollectionByType(TimeDTO);
  }

  Future getTimesByCity(Map params) async {
    FlightPostParamsDTO vo = new FlightPostParamsDTO.FromPost(params);
    Map query = {'arrival': vo.cityArrival, 'departure': vo.cityDepart};
    List<TimeDTO> time_vos = await readCollectionByType(TimeDTO, query);
    query = {'route': time_vos.first.departure + "_" + time_vos.first.arrival};
    return readCollectionByType(RouteDTO, query).then((List rvos) {
      time_vos.forEach((TimeDTO vo) => vo.route = rvos.first);
      return time_vos;
    });
  }

  Future getTimesByNumber(Map params) async {
    print(params);
    List<TimeDTO> time_vos = await readCollectionByType(TimeDTO, {'flight': int.parse(params['flight'])} );
    var query = {'route': time_vos.first.departure + "_" + time_vos.first.arrival};
    return readCollectionByType(RouteDTO, query).then((List rvos) {
      time_vos.forEach((TimeDTO vo) => vo.route = rvos.first);
      return time_vos;
    });
  }
}
