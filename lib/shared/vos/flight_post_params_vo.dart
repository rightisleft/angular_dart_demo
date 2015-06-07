part of jit_schemas;

class FlightPostParamsVO {
  String cityDepart;
  String cityArrival;
  DateTime dateDepart;
  DateTime dateArrival;

  FlightPostParamsVO();

  Map toPostable() {
    var f = new DateFormat('yyyy-MM-dd');
    return {'cityDepart': cityDepart, 'cityArrival': cityArrival, 'dateDepart': f.format( dateDepart ) , 'dateArrival': f.format( dateArrival ) };
  }

  factory FlightPostParamsVO.FromPost(Map aMap) {
    FlightPostParamsVO instance = new FlightPostParamsVO();
    instance.setup(aMap, instance);
    return instance;
  }

  FlightPostParamsVO setup(Map aMap, FlightPostParamsVO instance)
  {
    instance.cityArrival = aMap['cityArrival'];
    instance.cityDepart = aMap['cityDepart'];
    instance.dateDepart= DateTime.parse(aMap['dateDepart']);
    instance.dateArrival= DateTime.parse(aMap['dateArrival']);
    return instance;
  }
}