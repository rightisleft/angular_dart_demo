part of jit_frontend;

flightRoutes(Router router, RouteViewFactory views) {

  errorHandler(RouteEnterEvent e ) {
    print('ERROR');
    router.go('landing', {}, replace: true);
  }

  var rLanding    = ngRoute(path: '/landing', view: 'views/landing.html');
  var rLandingId  = ngRoute(path: '/landing/:id', view: 'views/landing.html');
  var rFlights    = ngRoute(path: '/flights', view: 'views/flights.html');
  var rFlightsId  = ngRoute(path: '/flights/:cityDepart/:cityArrival/:dateDepart/:dateArrival/', view: 'views/flights.html');
  var rContact    = ngRoute(path: '/contact', view: 'views/contact.html');
  var rOrder      = ngRoute(path: '/order', view: 'views/order.html');
  var rDefault    = ngRoute(defaultRoute: true, enter: errorHandler );


//  var routeTiger    = ngRoute(path: '/tiger/', view: 'packages/angular_dart_demo/client/components/search/tiger.html');
//  var routeTigerType    = ngRoute(path: '/tiger/:type/', view: 'packages/angular_dart_demo/client/components/search/tiger.html');
//  var routeLion     = ngRoute(path: '/lion/:cub/', view: 'packages/angular_dart_demo/client/components/search/lion.html');

  Map routes = {'landing': rLanding, 'landing_type': rLandingId,
                'contact': rContact,
                'order': rOrder,
                'flights': rFlights,
                'flightsId': rFlightsId,
                'view_default': rDefault };

  views.configure(routes);
}

