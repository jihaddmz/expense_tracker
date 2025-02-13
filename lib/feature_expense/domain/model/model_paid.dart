import 'package:expense_tracker/core/data/local/entities/entity_paid.dart';

class ModelPaid {
  int day;
  final double paid;
  final String month;
  final String category;

  ModelPaid({
    required this.day,
    required this.paid,
    required this.month,
    required this.category,
  });

  EntityPaid toEntity() {
    return EntityPaid(
      day: day,
      paid: paid,
      month: month,
      category: category,
    );
  }
}