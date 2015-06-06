import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';
import 'flight_controller.dart' as controller;

main() {
  Router airRouter = router();

  Router tickets = airRouter.child('/tickets');
  tickets.add('/cities', ['GET'], controller.handleCitites);
  tickets.add('/times', ['GET'], controller.handleTimes);
  tickets.add('/routes', ['GET'], controller.handleRoutes);
  tickets.add('/{id}/tickets/', ['GET'], controller.handleTickets);
//  tickets.add('/routes/{routes}/times', ['GET'], handleTimes);

  io.serve(airRouter.handler, 'localhost', 1234);

//  AirRouteVO route = new AirRouteVO();
//  route.price1 = 100.05;
//  route.price2 = 200.50;
//  route.price3 = 300.50;
//  route.id = 1000;
//  route.duration = 165;
//  route.route = "LAX_SFO";
//  route.seats = 10;
//
//  var reflection = reflect(route);
//  InstanceMirror field = reflection.getField(new Symbol('price1'));
  ////  InstanceMirror wired = reflection.setField(new Symbol('price1'), 5000);
//
//  print(route.price1);
//  Map target = new Map();
//  reflection.type.declarations.values.forEach((item) {
//    if(item is VariableMirror) {
//      VariableMirror value = item;
//      if( !value.isFinal && !value.isConst && !value.isConst )
//      {
//        print( MirrorSystem.getName(value.simpleName ));
//        print( reflection.getField(value.simpleName).reflectee.runtimeType );
//        print( reflection.getField(value.simpleName).reflectee );
//        target[MirrorSystem.getName(value.simpleName )] = reflection.getField(value.simpleName).reflectee;
//      }
//    };
//  });
//
//  print( target.toString() );
//  print(new JsonEncoder().convert(target));
}
