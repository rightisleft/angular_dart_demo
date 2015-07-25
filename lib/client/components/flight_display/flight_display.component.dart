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
  FlightPostParamsDTO params;

  List<TimeDTO> flight_times;
  List<RouteDTO> routes;

  FlightDisplay(Router this.router, RouteProvider this.routeProvider, FlightQueryService this.queryService) {
    if(routeProvider.parameters.isEmpty == false)
    {
      params = new FlightPostParamsDTO.FromPost(routeProvider.parameters);
      fetchData(params);
    }
  }

  void fetchData(FlightPostParamsDTO params) {
    queryService.fetchFlightTimes(params).then( (List<TimeDTO> dtos) {
      flight_times = dtos;
    });
  }

  void onsubmit(TimeDTO time)
  {
    var post = params.toPostable();
    post['id'] = time.flight;
    post['level'] = service_level;
    router.go('order', post);
  }
}
