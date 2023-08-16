import 'package:hive/hive.dart';
part 'expense_data.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String category;

  @HiveField(3)
  String notes;

  ExpenseModel({
    required this.date,
    required this.amount,
    required this.category,
    required this.notes,
  });
}