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

  List<TimeVO> flight_times;
  List<RouteVO> routes;

  FlightDisplay(RouteProvider this.routeProvider, FlightQueryService this.queryService) {
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

    queryService.fetchRoutes(params).then( (List vos) {
      vos.retainWhere( (RouteVO route) => (params.cityDepart + '_' + params.cityArrival) == route.route );
      routes = vos;
    });
  }

  void onOrder(RouteVO route)
  {
    print(route.route);
  }
}

class ViewModel {
  RouteVO rvo;
  TimeVO tvo;
  ViewModel(this.rvo,this.tvo){

  }
}
