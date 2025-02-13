import 'package:expense_tracker/core/data/local/entities/entity_month.dart';

class ModelMonth {
  final String date;
  double savings;

  ModelMonth({required this.date, this.savings = 0});

  Map<String, dynamic> toMap() {
    return {'date': date, 'savings': savings};
  }

  EntityMonth toEntity() {
    return EntityMonth(date: date, savings: savings);
  }
}
