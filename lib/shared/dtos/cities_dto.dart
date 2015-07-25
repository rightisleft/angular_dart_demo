part of jit_schemas;

@Injectable()
@Entity()
class CityDTO extends BaseDTO  {
  String collection_key = "Cities";
  String city;
  String airportcode;
  String gate;
}
