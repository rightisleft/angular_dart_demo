import 'package:guinness/guinness.dart';
import 'package:angular_dart_demo/shared/schemas.dart';
import 'package:logging/logging.dart';

import '../bin/api_model.dart';

main() {
  BaseMongoModel model = new BaseMongoModel();
  RouteDTO routeDTO = new RouteDTO()..duration=120..price1=90.00..price2=91.00..price3=95.00..seats=7;

  Map stub = { "bAddress": "Consequatur amet possimus nulla et consectetur et",
  "bCity": "Ad aliqua Possimus dolor est iusto sequi quis officia laboris eos",
"bCountry": "Est numquam nostrum est alias voluptatum corporis numquam voluptas exercitationem consequatur voluptas irure quas commodi est blanditiis",
"bFirstName": "Dean",
"bLastName": "Woodard",
"bMiddleName": "Xaviera Henson",
"bState": "Az",
"bZip": 12,
"ccExpiration": "Sint enim architecto commodi perferendis expedita quisquam quam cupidatat",
"ccType": "visa",
"ccn": 8,
"ccv": 38,
"flightID": 1006,
"flightLevel": 3,
"pEmail": "mohezizova@gmail.com",
"pFirstName": "Mara",
"pLastName": "Zimmerman",
"pMiddleName": "Keegan Lee" };

  it("should create a record DTO and write to the db", () {
    return  model.createByItem(routeDTO).then(( dto ) {
      expect(dto.id).toEqual(routeDTO.id);
    });
  });
}
