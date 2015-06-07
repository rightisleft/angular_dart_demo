part of jit_frontend;

@Component(
    selector: 'flight-display',
    templateUrl: 'packages/angular_dart_demo/client/components/flight_display/flight_display.html',
    cssUrl: 'packages/angular_dart_demo/client/components/flight_display/flight_display.css',
    useShadowDom: false
)
class FlightDisplay extends Object {

  RouteProvider routeProvider;

  NgForm flight_display_form;

  FlightQueryService queryService;
  FlightPostParamsVO params;

  List<RouteVO> routes;

  FlightDisplay(RouteProvider this.routeProvider, FlightQueryService this.queryService) {
    if(routeProvider.parameters.isEmpty == false)
    {
      params = new FlightPostParamsVO.FromPost(routeProvider.parameters);
      fetchData(params);
    }
  }

  void fetchData(FlightPostParamsVO params) {
    queryService.fetchRoutes(params).then( (List<RouteVO> vos) {
      routes = vos;
    });
  }

  void onOrder(RouteVO route)
  {
    print(route.route);
  }
}
