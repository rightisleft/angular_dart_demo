part of jit_frontend;

@Component(
  selector: 'recap',
  templateUrl: 'packages/angular_dart_demo/client/components/order/recap.html',
  cssUrl: 'packages/angular_dart_demo/client/components/order/order.css',
  useShadowDom: false
)
class Recap extends Object implements ScopeAware {

  Router _router;
  RouteProvider _routeProvider;
  FlightQueryService queryService;
  Scope _scope;
  FlightPostParamsDTO params;

  @NgTwoWay('timeDTO')
  TimeDTO timeDTO;

  Recap(Router this._router, RouteProvider this._routeProvider, FlightQueryService this.queryService)
  {
    params = new FlightPostParamsDTO.FromPost(_routeProvider.parameters);
  }

  void set scope(Scope scope) {
    // with this scope you should be able to use emit
    // This setter gets called to initialize the scope
    this._scope = scope;
    Stream mystream = _scope.rootScope.on('flight');
    mystream.listen((event){
      timeDTO = event.data;
    });
  }

  String format(DateTime value)
  {
    return params.format(value);
  }

}