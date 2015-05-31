part of jit_frontend;

@Component(
  selector: 'searchbox',
  templateUrl: 'packages/angular_dart_demo/client/components/search/search.html',
  cssUrl: 'packages/angular_dart_demo/client/components/search/search.css',
  useShadowDom: false
)
class SearchBox extends Object
{
  SearchBox(RouteProvider routeProvider, FlightQueryService ticketQuery){
    ticketQuery.fetchRoutes().then( (_) => print('searchbox call is complete') );
  }
}

@Genre("techno")

@Decorator(selector: '[tooltip]')
class Tooltip {
  final Element element;
  Tooltip(this.element) {
    element.text = "Set From Inside";
  }

  @NgAttr('paco')
  String paco;
}



class Genre {
  final String value;
  const Genre(String this.value);
}
