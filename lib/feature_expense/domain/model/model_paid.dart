import 'package:expense_tracker/core/data/local/entities/entity_paid.dart';

class ModelPaid {
  int day;
  final double paid;
  final String month;
  final String category;
  final String date;

  ModelPaid({
    required this.day,
    required this.paid,
    required this.month,
    required this.category,
    this.date = ""
  });

  EntityPaid toEntity() {
    return EntityPaid(
      day: day,
      paid: paid,
      month: month,
      category: category,
      date: "${month.split(" ")[0]} $day, ${month.split(" ")[1]}",
    );
  }
}