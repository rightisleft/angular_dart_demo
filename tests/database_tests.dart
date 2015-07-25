import 'package:guinness/guinness.dart';
import 'package:angular_dart_demo/shared/schemas.dart';
import 'package:logging/logging.dart';

import '../bin/api_model.dart';

main() {
  BaseMongoModel model = new BaseMongoModel();
  RouteDTO routeDTO = new RouteDTO()..duration=120..price1=90.00..price2=91.00..price3=95.00..seats=7;


  it("should create a record DTO and write to the db", () {
    return  model.createByItem(routeDTO).then(( dto ) {
      expect(dto.id).toEqual(routeDTO.id);
    });
  });

    it("update an item in the database, retrieve again to make sure its updated", () {
    routeDTO.price1=10000;
    return  model.updateItem(routeDTO).then((Map status){
      return  model.readItemByItem(routeDTO).then((RouteDTO dto){
        expect(status['ok']).toEqual(1.0);
        expect(dto.price1).toEqual(routeDTO.price1);
      });
    });
  });

  it("will retrieive the item created in the first step", () {
    return  model.readItemByItem(routeDTO).then((BaseDTO dto){
      expect(dto.id).toEqual(routeDTO.id);
    });
  });

  it("should retrieve a list of items by the DTO", () {
    return  model.readCollectionByType( RouteDTO ).then(( List<BaseDTO> aList ) {
      expect(aList.first).toBeAnInstanceOf(RouteDTO);
      expect(aList.length).toBeGreaterThan(0);
    });
  });

  it("should delete the route DTO from the DB", () {
    return model.deleteByItem(routeDTO).then( (status) {
      expect(status['ok']).toEqual(1.0);
    });
  });
}
