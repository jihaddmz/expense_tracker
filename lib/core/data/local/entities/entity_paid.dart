import 'package:expense_tracker/feature_expense/domain/model/model_paid.dart';
import 'package:floor/floor.dart';

@entity
class EntityPaid {
  @PrimaryKey(autoGenerate: true)
  final int id = 0;
  final int day;
  final double paid;
  final String month;
  final String category;

  EntityPaid({
    required this.day,
    required this.paid,
    required this.month,
    required this.category,
  });

  ModelPaid toModel() {
    return ModelPaid(
      day: day,
      paid: paid,
      month: month,
      category: category,
    );
  }
}