part of jit_frontend;

@Component(
    selector: 'flight-display',
    templateUrl: 'packages/angular_dart_demo/client/components/flight_display/flight_display.html',
    cssUrl: 'packages/angular_dart_demo/client/components/flight_display/flight_display.css',
    useShadowDom: false
)
class FlightDisplay extends Object {

  NgForm flight_display_form;
  List<RouteVO> routes;

  FlightDisplay(RouteProvider routeProvider, FlightQueryService ticketQuery) {
    ticketQuery.fetchRoutes().then( (List<RouteVO> vos) {
      print('--fetched route--');
      print(vos.toString());
      routes = vos;
    });
  }

  onsubmit(NgForm form)
  {
    print(form);
  }
}