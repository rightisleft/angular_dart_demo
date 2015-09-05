part of jit_schemas;

// Add Enum

@Injectable()
@Entity()
class PurchaseDTO extends Object
{
  num flightID;
  num flightLevel;

  String ccn;
  String ccv;
  String ccType;
  String ccExpiration;

  String pFirstName;
  String pMiddleName;
  String pLastName;
  String pEmail;

  String bFirstName;
  String bMiddleName;
  String bLastName;
  String bAddress;
  String bCity;
  String bState;
  String bZip;
  String bCountry;
}
