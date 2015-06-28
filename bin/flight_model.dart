library jit_model;
import 'dart:async';
import 'api_model.dart';
import 'package:angular_dart_demo/shared/schemas.dart';
import 'package:dartson/dartson.dart';

class FlightDataModel extends Object with BaseMongoModel {

  createPurchase(Map params) async {
    var dson = new Dartson.JSON();
    PurchaseDTO object = dson.map(params, new PurchaseDTO() );
    TransactionVO tvo = new TransactionVO();
    tvo.amount = 100.00;
    tvo.user = object.pEmail;
    return createByItem(tvo);
  }

  Future <List> getAllCities(Map params) {
    return readCollectionByType(CitiesVO);
  }

  Future <List> getAllTimes(Map params) {
    return readCollectionByType(TimeVO);
  }

  Future getTimesByCity(Map params) async {
    FlightPostParamsVO vo = new FlightPostParamsVO.FromPost(params);
    Map query = {'arrival': vo.cityArrival, 'departure': vo.cityDepart};
    List<TimeVO> time_vos = await readCollectionByType(TimeVO, query);
    query = {'route': time_vos.first.departure + "_" + time_vos.first.arrival};
    return readCollectionByType(RouteVO, query).then((List rvos) {
      time_vos.forEach((TimeVO vo) => vo.route = rvos.first);
      return time_vos;
    });
  }

  Future getTimesByNumber(Map params) async {
    print(params);
    List<TimeVO> time_vos = await readCollectionByType(TimeVO, {'flight': int.parse(params['flight'])} );
    var query = {'route': time_vos.first.departure + "_" + time_vos.first.arrival};
    return readCollectionByType(RouteVO, query).then((List rvos) {
      time_vos.forEach((TimeVO vo) => vo.route = rvos.first);
      return time_vos;
    });
  }
}
