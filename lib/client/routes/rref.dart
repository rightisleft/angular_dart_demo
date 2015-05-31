part of jit_frontend;

//This works better with the web server root

@Decorator(selector: '[rref]')
class Rref {
  final Element _element;
  final Router _router;
  String _target;

  @NgAttr('target')
  set target(String value) {
    _target = value;
    print('target is: ' + _target);
  }

  Rref(Element this._element, Router this._router) {
    _element.onClick.listen( clickHandler );
  }

  void clickHandler(event) {
    _router.go(_target, {});
  }
}

