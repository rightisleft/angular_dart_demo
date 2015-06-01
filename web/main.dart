import 'package:angular/application_factory.dart';
import 'package:angular/angular.dart';
import 'package:logging/logging.dart';

import 'package:bootjack/bootjack.dart';
import 'package:bootjack_datepicker/bootjack_datepicker.dart';

import 'package:angular_dart_demo/client/jit_front_end.dart' as Client;
import 'package:angular_dart_demo/shared/schemas.dart' as Schemas;


class JitAppModule extends Module
{
  JitAppModule() {
    Schemas.schema_classes.forEach((Type type) => bind(type) );
    Client.client_classes.forEach((Type type) => bind(type) );
    bind(RouteInitializerFn, toValue: Client.flightRoutes);
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
  }
}

void main() {
  //globals
  Logger.root..level = Level.FINEST
    ..onRecord.listen((LogRecord r) { print(r.message); });

  Bootjack.useDefault(); // use all
  Calendar.use();

  applicationFactory()
  .addModule( new JitAppModule() )
  .run();
}
