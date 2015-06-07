part of jit_frontend;

@Component(
    selector: 'picker',
    templateUrl: 'packages/angular_dart_demo/client/components/picker/picker.html',
    cssUrl: 'packages/angular_dart_demo/client/components/picker/picker.css',
    useShadowDom: false
)
class Picker extends Object {

  Router _router;
  RouteProvider _routeProvider;
  NgForm flightForm;
  FlightPostParamsVO info = new FlightPostParamsVO();
  List<CitiesVO> cities;
  FlightQueryService queryService;

  Picker(Router this._router, RouteProvider this._routeProvider, FlightQueryService this.queryService) {
    populateCitites();
    populateState();
  }

  void populateCitites() {
    queryService.fetchCities().then( (List<CitiesVO> vos) {
      cities = vos;
    });
  }

  void populateState() {
    if(_routeProvider.parameters.isEmpty == false)
    {
      info = info.setup(_routeProvider.parameters, info);
    }
  }

  onSubmit(NgForm form)
  {
    print(form);
    var postItem =  info.toPostable();
    this._router.go('flightsId', postItem );
  }
}