library jit_frontend;

//pub
import 'package:angular/angular.dart';
import 'package:dartson/dartson.dart';

//dart
import 'dart:convert';
import 'dart:html';
import 'dart:async';

//shared
import 'package:angular_dart_demo/shared/schemas.dart';

//lib
part 'services/query_service.dart';
part 'routes/flight_router.dart';
part 'routes/rref.dart';
part 'components/search/search_component.dart';
part 'components/topnav/topnav.component.dart';

const List<Type> client_classes = const [ Rref, Topnav, SearchBox, FlightQueryService, Tooltip];
