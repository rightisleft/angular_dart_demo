part of jit_schemas;

@Injectable()
@Entity()
class RouteVO extends BaseVO {
  String collection_key = "Routes";

  String route;
  num duration;
  num price1;
  num price2;
  num price3;
  int seats;

  String getDepartureCity() {
    return route.split('_')[0];
  }

  String getArrivalCity() {
    return route.split('_')[1];
  }
}
