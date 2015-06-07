import 'package:guinness/guinness.dart';
import 'package:angular_dart_demo/shared/schemas.dart';
import 'package:logging/logging.dart';

import '../bin/api_model.dart';

main() {
  BaseMongoModel model = new BaseMongoModel();
  RouteVO routeVO = new RouteVO()..duration=120..price1=90.00..price2=91.00..price3=95.00..seats=7;

  Logger.root..level = Level.FINE
    ..onRecord.listen((LogRecord r) { print(r.message); });

  it("should create a record VO and write to the db", () {
    return  model.createByItem(routeVO).then(( Map status ) {
      expect(status['ok']).toEqual(1.0);
    });
  });

    it("update an item in the database, retrieve again to make sure its updated", () {
    routeVO.price1=10000;
    return  model.updateItem(routeVO).then((Map status){
      return  model.readItemByItem(routeVO).then((RouteVO vo){
        expect(status['ok']).toEqual(1.0);
        expect(vo.price1).toEqual(routeVO.price1);
      });
    });
  });

  it("will retrieive the item created in the first step", () {
    return  model.readItemByItem(routeVO).then((BaseVO vo){
      expect(vo.id).toEqual(routeVO.id);
    });
  });

  it("should retrieve a list of items by the VO", () {
    return  model.readCollectionByType( RouteVO ).then(( List<BaseVO> aList ) {
      expect(aList.first).toBeAnInstanceOf(RouteVO);
      expect(aList.length).toBeGreaterThan(0);
    });
  });

  it("should delete the route VO from the DB", () {
    return model.deleteByItem(routeVO).then( (status) {
      expect(status['ok']).toEqual(1.0);
    });
  });
}
