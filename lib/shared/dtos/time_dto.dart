part of jit_schemas;

@Injectable()
@Entity()
class TimeDTO extends BaseDTO {
  String collection_key = "Times";

  int flight;
  String departure;
  String arrival;
  int takeoff;
  RouteDTO route;
}
