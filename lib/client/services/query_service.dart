part of jit_frontend;

@Injectable()
class FlightQueryService{
  Http _http;
  FlightQueryService(Http this._http);

  Future fetchRoutes() async {
    return _http.get('http://localhost:8888/tickets/routes').then(handle);
  }

  List<RouteVO> handle(HttpResponse response) {
    Dartson converter = new Dartson.JSON();

    // Todo: Jack Murphy until i modify the http to not transform the response data
    // http://stackoverflow.com/questions/19913222/configuring-angulardart-modules
    var string = JSON.encode(response.data);

    List<RouteVO> vos = converter.decode(string, new RouteVO(), true);
    return vos;
  }
}



