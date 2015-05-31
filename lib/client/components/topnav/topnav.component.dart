part of jit_frontend;

@Component(
    selector: "topnav",
    templateUrl: "packages/angular_dart_demo/client/components/topnav/topnav.html",
    cssUrl: "packages/angular_dart_demo/client/components/topnav/topnav.css",
    useShadowDom: false
)

class Topnav extends Object {
  List<NavButtonVO> buttons;
  Router _router;

  Topnav(Router router, RouteProvider provider) {
    _router = router;
    buttons = initbuttons();
    buttons.forEach((NavButtonVO vo) => vo.isActive = vo.route == provider.route.name);
  }

  List<NavButtonVO> initbuttons() {
    List<NavButtonVO> buttons = new List<NavButtonVO>();
    buttons.add( new NavButtonVO()..route = "landing"..content="Home");
    buttons.add( new NavButtonVO()..route = "flights"..content="Flights" );
    buttons.add( new NavButtonVO()..route = "contact"..content="Contact" );
    return buttons;
  }
}

class NavButtonVO {
  String route;
  String content;
  bool isActive;
}