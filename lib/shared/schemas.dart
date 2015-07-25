library jit_schemas;

import 'package:angular/di/module.dart'; // enables @injectable w/o a dependency on dart:html
import 'package:dartson/dartson.dart';
import 'package:intl/intl.dart';


//Injectables
part 'dtos/base_dto.dart';
part 'dtos/booking_dto.dart';
part 'dtos/cities_dto.dart';
part 'dtos/route_dto.dart';
part 'dtos/purchase_dto.dart';
part 'dtos/time_dto.dart';
part 'dtos/transaction_dto.dart';

//Libraries
part 'dtos/flight_post_params_dto.dart';

const List<Type> schema_classes = const [RouteDTO, BookingDTO, CityDTO, TimeDTO, TransactionDTO, PurchaseDTO];
