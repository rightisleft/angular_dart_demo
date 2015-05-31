part of jit_schemas;

@Injectable()
@Entity()
class CitiesVO extends BaseVO  {
  String collection_key = "Cities";
  String city;
  String airportcode;
  String gate;
}
