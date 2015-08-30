library jit_model;
import 'dart:async';
import 'api_model.dart';
import 'package:angular_dart_demo/shared/schemas.dart';
import 'package:dartson/dartson.dart';

class FlightDataModel extends Object with BaseMongoModel {

  Future<Map> createPurchase(Map params) async {
    var dson = new Dartson.JSON();
    PurchaseDTO purchaser = dson.map(params, new PurchaseDTO() );
    TransactionDTO tdto = new TransactionDTO();
    tdto.paid = 100; //we're faking a successful creditcard payment
    tdto.user = purchaser.pEmail;
    return createByItem(tdto);
  }

  Future <List> getAllCities(Map params) {
    return readCollectionByType(CityDTO);
  }

  Future <List> getAllTimes(Map params) {
    return readCollectionByType(TimeDTO);
  }

  Future getTimesByCity(Map params) async {
    Map query = {'arrival': params['cityArrival'], 'departure': params['cityDepart']};
    List<TimeDTO> time_dtos = await readCollectionByType(TimeDTO, query);
    query = {'route': time_dtos.first.departure + "_" + time_dtos.first.arrival};
    return readCollectionByType(RouteDTO, query).then((List rdtos) {
      time_dtos.forEach((TimeDTO dto) => dto.route = rdtos.first);
      return time_dtos;
    });
  }

  Future getTimesByNumber(Map params) async {
    print(params);
    List<TimeDTO> time_dtos = await readCollectionByType(TimeDTO, {'flight': int.parse(params['flight'])} );
    var query = {'route': time_dtos.first.departure + "_" + time_dtos.first.arrival};
    return readCollectionByType(RouteDTO, query).then((List rdtos) {
      time_dtos.forEach((TimeDTO dto) => dto.route = rdtos.first);
      return time_dtos;
    });
  }
}
