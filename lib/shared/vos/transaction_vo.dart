part of jit_schemas;

@Injectable()
@Entity()
class TransactionVO extends BaseVO {
  String collection_key = "Transactions";
  int paid;
  String user;
}
