part of jit_frontend;

@Injectable()
class FlightQueryService{
  final String BASE = 'http://localhost:1234/tickets/';
  Http _http;

  FlightQueryService(Http this._http) {}

  Future fetchFlightTimes(FlightPostParamsVO params) async {
    Map post = params.toPostable();
    return _http.post(BASE + 'times', post ).then(handleTimes);
  }

  Future fetchFlightByNumber(num id) async {
    return _http.get(BASE + 'flight/' + id.toString()).then(handleTimes);
  }

  Future fetchCities() async {
    return _http.get(BASE + 'cities').then(handleCities);
  }

  Future purchaseTicket(String json) async {
    return _http.post(BASE + 'purchase', json).then(handlePurchase);
  }

  List<TimeVO> handleTimes(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    var string = JSON.encode(response.data);
    List<TimeVO> vos = converter.decode(string, new TimeVO(), true);
    return vos;
  }

  List<RouteVO> handleRoutes(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    var string = JSON.encode(response.data);
    List<RouteVO> vos = converter.decode(string, new RouteVO(), true);
    return vos;
  }

  List<CitiesVO> handleCities(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    var string = JSON.encode(response.data);
    List<CitiesVO> vos = converter.decode(string, new CitiesVO(), true);
    return vos;
  }

  List<TransactionVO> handlePurchase(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    var string = JSON.encode(response.data);
    List<TransactionVO> vos = converter.decode(string, new TransactionVO(), true);
    return vos;
  }
}



