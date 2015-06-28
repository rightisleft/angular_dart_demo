library jit_schemas;

import 'package:angular/di/module.dart'; // enables @injectable w/o a dependency on dart:html
import 'package:dartson/dartson.dart';
import 'package:intl/intl.dart';


//Injectables
part 'vos/base_vo.dart';
part 'vos/booking_vo.dart';
part 'vos/cities_vo.dart';
part 'vos/route_vo.dart';
part 'vos/purchase_dto.dart';
part 'vos/time_vo.dart';
part 'vos/transaction_vo.dart';

//Libraries
part 'vos/flight_post_params_vo.dart';

const List<Type> schema_classes = const [RouteVO, BookingVO, CitiesVO, TimeVO, TransactionVO, PurchaseDTO];
