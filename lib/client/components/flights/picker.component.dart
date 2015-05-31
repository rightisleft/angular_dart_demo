part of jit_frontend;

@Component(
    selector: 'picker',
    templateUrl: 'packages/angular_dart_demo/client/components/flights/picker.html',
    cssUrl: 'packages/angular_dart_demo/client/components/flights/picker.css',
    useShadowDom: false
)
class Picker extends Object {
  Picker(RouteProvider routeProvider, FlightQueryService ticketQuery) {
    ticketQuery.fetchRoutes().then((_) => print('searchbox call is complete'));
  }
}