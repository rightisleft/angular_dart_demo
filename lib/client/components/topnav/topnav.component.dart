part of jit_frontend;

@Component(
    selector: 'topnav',
    templateUrl: 'packages/angular_dart_demo/client/components/topnav/topnav.html',
    cssUrl: 'packages/angular_dart_demo/client/components/topnav/topnav.css',
    useShadowDom: false
)

class Topnav extends Object {
  List<NavButtonVO> buttons;

  Topnav(RouteProvider routeProvider) {
    print('TopNav Initialized');
    buttons = initbuttons();
  }

  List<NavButtonVO> initbuttons() {

    List<NavButtonVO> buttons = new List<NavButtonVO>();
    buttons.add( new NavButtonVO()..route = "/landing"..content='Home'..isActive=true );
    buttons.add( new NavButtonVO()..route = "/flights"..content='Flights' );
    buttons.add( new NavButtonVO()..route = "/contacts"..content='Contacts' );
    return buttons;
  }
}

class NavButtonVO {
  String route;
  String content;
  bool isActive;
}