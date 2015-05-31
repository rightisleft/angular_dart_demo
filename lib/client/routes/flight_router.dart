part of jit_frontend;

flightRoutes(Router router, RouteViewFactory views) {
  var rLanding    = ngRoute(path: '/', view: 'views/landing.html');
  var routeTiger    = ngRoute(path: '/tiger/', view: 'packages/angular_dart_demo/client/components/search/tiger.html');
  var routeTigerType    = ngRoute(path: '/tiger/:type/', view: 'packages/angular_dart_demo/client/components/search/tiger.html');
  var routeLion     = ngRoute(path: '/lion/:cub/', view: 'packages/angular_dart_demo/client/components/search/lion.html');
  var routeDefault  = ngRoute(  defaultRoute: true, enter: (RouteEnterEvent e) => router.go('landing', {}));
  Map routes = {'tiger': routeTiger,
                'lion': routeLion,
                'landing': rLanding,
                'view_default': routeDefault,
                'tiger_type': routeTigerType};
  views.configure(routes);
}