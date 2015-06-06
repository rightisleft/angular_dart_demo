import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';
import 'api_controller.dart' as controller;

main() {
  Router airRouter = router();

  Router tickets = airRouter.child('/tickets');
  tickets.add('/cities', ['GET'], controller.handleCitites);
  tickets.add('/times', ['GET'], controller.handleTimes);
  tickets.add('/routes', ['GET'], controller.handleRoutes);
  tickets.add('/{id}/tickets/', ['GET'], controller.handleTickets);

  io.serve(airRouter.handler, 'localhost', 1234);
}
