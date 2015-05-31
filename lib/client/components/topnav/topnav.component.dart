part of jit_frontend;

@Component(
    selector: 'topnav',
    templateUrl: 'packages/angular_dart_demo/client/components/topnav/topnav.html',
    cssUrl: 'packages/angular_dart_demo/client/components/topnav/topnav.css',
    useShadowDom: false
)

class Topnav extends Object {
  List<NavButtonVO> buttons;
  Router _router;

  Topnav(Router router, RouteProvider routeProvider) {
    _router = router;

    print('TopNav Initialized');
    buttons = initbuttons();
  }

  List<NavButtonVO> initbuttons() {
    List<NavButtonVO> buttons = new List<NavButtonVO>();
    buttons.add( new NavButtonVO()..route = "landing"..content='Home'..isActive=true );
    buttons.add( new NavButtonVO()..route = "flights"..content='Flights' );
    buttons.add( new NavButtonVO()..route = "contact"..content='Contact' );
    return buttons;
  }

  void doClick() {
    _router.go('contact', {});
  }
}

class NavButtonVO {
  String route;
  String content;
  bool isActive;
}