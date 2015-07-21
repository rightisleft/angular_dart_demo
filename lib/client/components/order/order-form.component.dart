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
  PurchaseDTO dto= new PurchaseDTO();
  NgForm orderForm;
  SharedData sharedVO;


  OrderForm(Router this._router, RouteProvider this._routeProvider, FlightQueryService this.queryService, SharedData this.sharedVO) {
   fetch();
  }

  void fetch() {
    if(_routeProvider != null && _routeProvider.parameters.isEmpty == false)
    {
      queryService.fetchFlightByNumber(int.parse(_routeProvider.parameters['id'])).then((List<TimeVO> vos){
        flightVO = vos.first;
        dto.flightID = flightVO.flight;
        dto.flightLevel = int.parse(_routeProvider.parameters['level']);
        _scope.rootScope.emit('flight', flightVO);
      });
    }
  }

  void set scope(Scope scope) {
    // with this scope you should be able to use emit
    // This setter gets called to initialize the scope
    this._scope = scope;
  }

  onSubmit()
  {
    print(orderForm);
    print(dto);
    print('--complete--');
    var dson = new Dartson.JSON();
    String jsonString = dson.encode(dto);
    print(jsonString);
    queryService.purchaseTicket(jsonString).then((TransactionVO response){
      sharedVO.transaction = response;
      _router.go('success', {});
    });
  }
}