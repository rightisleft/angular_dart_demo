part of jit_frontend;

@Component(
  selector: 'order-form',
  templateUrl: 'packages/angular_dart_demo/client/components/order/form.html',
  cssUrl: 'packages/angular_dart_demo/client/components/order/order.css',
  useShadowDom: false
)
class OrderForm extends Object implements ScopeAware {

  Router _router;
  RouteProvider _routeProvider;
  FlightQueryService queryService;
  TimeVO flightVO;
  Recap recap;
  Scope _scope;

  OrderForm(Router this._router, RouteProvider this._routeProvider, FlightQueryService this.queryService) {
   fetch();
  }

  void fetch() {
    if(_routeProvider != null && _routeProvider.parameters.isEmpty == false)
    {
      queryService.fetchFlightByNumber(1001).then((List<TimeVO> vos){
        flightVO = vos.first;
        _scope.rootScope.emit('flight', flightVO);
      });
    }
  }

  void set scope(Scope scope) {
    // with this scope you should be able to use emit
    // This setter gets called to initialize the scope
    this._scope = scope;
  }

  onSubmit(NgForm form)
  {

  }
}