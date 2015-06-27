part of jit_schemas;

@Injectable()
@Entity()
class TimeVO extends BaseVO {
  String collection_key = "Times";

  int flight;
  String departure;
  String arrival;
  int takeoff;
  RouteVO route;
}
