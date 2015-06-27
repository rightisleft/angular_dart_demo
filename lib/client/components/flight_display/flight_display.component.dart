part of jit_frontend;

@Component(
    selector: 'flight-display',
    templateUrl: 'packages/angular_dart_demo/client/components/flight_display/flight_display.html',
    cssUrl: 'packages/angular_dart_demo/client/components/flight_display/flight_display.css',
    useShadowDom: false
)
class FlightDisplay extends Object {

  RouteProvider routeProvider;
  Router router;

  NgForm flight_display_form;
  num service_level;

  FlightQueryService queryService;
  FlightPostParamsVO params;

  List<TimeVO> flight_times;
  List<RouteVO> routes;

  FlightDisplay(Router this.router, RouteProvider this.routeProvider, FlightQueryService this.queryService) {
    if(routeProvider.parameters.isEmpty == false)
    {
      params = new FlightPostParamsVO.FromPost(routeProvider.parameters);
      fetchData(params);
    }
  }

  void fetchData(FlightPostParamsVO params) {
    queryService.fetchFlightTimes(params).then( (List<TimeVO> vos) {
      flight_times = vos;
    });
  }

  void onsubmit(TimeVO time)
  {
    print(service_level);
    print(time);
    router.go('order', {'id': time.flight, 'level': service_level});
  }
}
