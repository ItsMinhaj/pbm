import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  int amount;
  @HiveField(1)
  final String note;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String type;

  addAmount(int amount) {
    this.amount = this.amount + amount;
  }

  TransactionModel(this.amount, this.note, this.date, this.type);
}
