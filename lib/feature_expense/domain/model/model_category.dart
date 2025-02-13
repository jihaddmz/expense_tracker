import 'package:expense_tracker/core/data/local/entities/entity_category.dart';

class ModelCategory {
  final String category;
  final String date;
  double budget;
  double paid;
  
   ModelCategory(
      {required this.category,
      required this.date,
      required this.budget,
      required this.paid});

  Map<String, dynamic> toMap() {
    return {'category': category, 'date': date, 'budget': budget, 'paid': paid};
  }

  EntityCategory toEntity() {
    return EntityCategory(category: category, date: date, budget: budget, paid: paid);
  }
}
