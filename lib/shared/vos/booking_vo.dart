part of jit_schemas;

@Injectable()
@Entity()
class BookingVO extends BaseVO
{
  String collection_key = "Bookings";

  String firstname;
  String lastname;
  String email;
  int phone;
  String address;
  String flight;
  String transaction;
}
