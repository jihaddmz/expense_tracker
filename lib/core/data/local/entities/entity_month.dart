import 'package:expense_tracker/feature_expense/domain/model/model_month.dart';
import 'package:floor/floor.dart';

@entity
class EntityMonth {
  @primaryKey
  final String date;

  final double savings;

  EntityMonth({required this.date, this.savings = 0});

ModelMonth toModel() {
    return ModelMonth(date: date, savings: savings);
  }
} 