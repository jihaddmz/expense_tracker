import 'package:expense_tracker/feature_expense/domain/model/model_paid.dart';
import 'package:floor/floor.dart';

@entity
class EntityPaid {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int day;
  final double paid;
  final String month;
  final String category;
  final String date;

  EntityPaid({
    this.id,
    required this.day,
    required this.paid,
    required this.month,
    required this.category,
    required this.date,
  });

  ModelPaid toModel() {
    return ModelPaid(
      day: day,
      paid: paid,
      month: month,
      category: category,
      date: date
    );
  }
}
