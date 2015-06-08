import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';
import 'api_controller.dart' as controller;


main() {
  Router airRouter = router();
  Router tickets = airRouter.child('/tickets');
  tickets.add('/cities', ['GET'], controller.handleCitites);
  tickets.add('/times', ['POST'], controller.handleTimesCity);
  tickets.add('/routes', ['POST'], controller.handleRoutes);
  tickets.add('/{id}/tickets/', ['GET'], controller.handleTickets);

  var handler = const shelf.Pipeline()
  .addMiddleware( shelf.logRequests() )
  .addMiddleware( corsMiddleWare )
  .addHandler(airRouter.handler);

  io.serve(handler, 'localhost', 1234);
}

Map CORSHeader = {'content-type': 'text/json',
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': "Origin, X-Requested-With, Content-Type, Accept",
  'Access-Control-Allow-Methods': "POST, GET, OPTIONS"};

shelf.Middleware corsMiddleWare = shelf.createMiddleware(requestHandler: reqHandler, responseHandler: respHandler);

shelf.Response reqHandler(shelf.Request request){
  if(request.method == "OPTIONS")
  {
    return new shelf.Response.ok(null, headers: CORSHeader);
  }
  return null; // move along
}

shelf.Response respHandler(shelf.Response response) {
  return response.change(headers: CORSHeader);
}
