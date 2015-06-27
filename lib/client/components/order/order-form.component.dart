part of jit_frontend;

@Component(
  selector: 'order-form',
  publishAs: 'scopeOrder',
  templateUrl: 'packages/angular_dart_demo/client/components/order/form.html',
  cssUrl: 'packages/angular_dart_demo/client/components/order/order.css',
  useShadowDom: false
)
class OrderForm extends Object {

  Router _router;
  RouteProvider _routeProvider;
  FlightQueryService queryService;

  OrderForm(Router this._router, RouteProvider this._routeProvider, FlightQueryService this.queryService) {
   fetch();
  }

  void fetch() {
    if(_routeProvider.parameters.isEmpty == false)
    {

    }
  }

  onSubmit(NgForm form)
  {

  }
}