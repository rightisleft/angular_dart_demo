part of jit_frontend;

@Component(
    selector: 'picker',
    templateUrl: 'packages/angular_dart_demo/client/components/flights/picker.html',
    cssUrl: 'packages/angular_dart_demo/client/components/flights/picker.css',
    useShadowDom: false
)
class Picker extends Object {

  Router _router;
  NgForm flightForm;
  Map info = new Map();
  List<CitiesVO> cities;

  Picker(Router this._router, RouteProvider routeProvider, FlightQueryService ticketQuery) {
    ticketQuery.fetchCities().then( (List<CitiesVO> vos) {
        print('--fetched cities--');
        print(routeProvider.parameters);
        cities = vos;
    });
  }

  onsubmit(NgForm form)
  {
    print(form);
    this._router.go('flightsId', info);
  }
}

//
//class FlightFormParams{
//  String cityDepart;
//  String cityArrival;
//  DateTime dateDepart;
//  DateTime dateArrival;
//}