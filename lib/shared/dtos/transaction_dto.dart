part of jit_schemas;

@Injectable()
@Entity()
class TransactionDTO extends BaseDTO {
  String collection_key = "Transactions";
  int paid;
  String user;
}
