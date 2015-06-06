part of jit_schemas;

@Injectable()
@Entity()
class TransactionVO extends BaseVO {
  String collection_key = "Transactions";
  double amount;
  String user;
}
