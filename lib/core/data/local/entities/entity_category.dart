import 'package:expense_tracker/feature_expense/domain/model/model_category.dart';
import 'package:floor/floor.dart';

@Entity(primaryKeys: ['category', 'date'])
class EntityCategory {
  final String category;
  final String date;
  final double budget;
  final double paid;

  const EntityCategory(
      {required this.category,
      required this.date,
      required this.budget,
      required this.paid});

  ModelCategory toModel() {
    return ModelCategory(
      category: category,
      date: date,
      budget: budget,
      paid: paid,
    );
  }
}
