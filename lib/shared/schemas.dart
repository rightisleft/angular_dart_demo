library jit_schemas;

import 'package:angular/di/module.dart';
import 'package:dartson/dartson.dart';

part 'vos/base_vo.dart';
part 'vos/booking_vo.dart';
part 'vos/cities_vo.dart';
part 'vos/route_vo.dart';
part 'vos/time_vo.dart';
part 'vos/transaction_vo.dart';

const List<Type> schema_classes = const [RouteVO, BookingVO, CitiesVO, TimeVO, TransactionVO];



