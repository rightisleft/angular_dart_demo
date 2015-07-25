library jit_model;
import 'dart:async';
import 'api_model.dart';
import 'package:angular_dart_demo/shared/schemas.dart';
import 'package:dartson/dartson.dart';

class FlightDataModel extends Object with BaseMongoModel {

  createPurchase(Map params) async {
    var dson = new Dartson.JSON();
    PurchaseDTO object = dson.map(params, new PurchaseDTO() );
    TransactionDTO tdto = new TransactionDTO();
    tdto.paid = 100;
    tdto.user = object.pEmail;
    return createByItem(tdto);
  }

  Future <List> getAllCities(Map params) {
    return readCollectionByType(CityDTO);
  }

  Future <List> getAllTimes(Map params) {
    return readCollectionByType(TimeDTO);
  }

  Future getTimesByCity(Map params) async {
    FlightPostParamsDTO dto = new FlightPostParamsDTO.FromPost(params);
    Map query = {'arrival': dto.cityArrival, 'departure': dto.cityDepart};
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
