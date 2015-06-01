part of jit_frontend;

@Injectable()
class FlightQueryService{
  final String BASE = 'http://localhost:8888/tickets/';
  Http _http;

  FlightQueryService(Http this._http);

  Future fetchRoutes() async {
    return _http.get(Base + 'routes').then(handleRoutes);
  }

  Future fetchCities() async {
    return _http.get(BASE + 'cities').then(handleCities);
  }

  List<RouteVO> handleRoutes(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    // Todo: Jack Murphy until i modify the http to not transform the response data
    // http://stackoverflow.com/questions/19913222/configuring-angulardart-modules
    var string = JSON.encode(response.data);
    List<RouteVO> vos = converter.decode(string, new RouteVO(), true);
    return vos;
  }

  List<CitiesVO> handleCities(HttpResponse response) {
    Dartson converter = new Dartson.JSON();
    // Todo: Jack Murphy until i modify the http to not transform the response data
    // http://stackoverflow.com/questions/19913222/configuring-angulardart-modules
    var string = JSON.encode(response.data);
    List<CitiesVO> vos = converter.decode(string, new CitiesVO(), true);
    return vos;
  }
}



