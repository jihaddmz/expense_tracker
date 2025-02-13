import 'package:expense_tracker/core/data/local/daos/dao_expense.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_category.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_month.dart';

class RepositoryExpense {
  final DaoExpense daoExpense;

  RepositoryExpense(this.daoExpense);

  Future<void> insertMonth(ModelMonth modelMonth) async {
    await daoExpense.insertMonth(modelMonth.toEntity());
  }

  Future<List<ModelMonth>> getAllMonths() async {
    return await daoExpense
        .getAllMonths()
        .then((value) => List.generate(value.length, (index) {
              return value[index].toModel();
            }));
  }

  Future<ModelMonth?> getModelMonthByDate(String date) async {
    return await daoExpense.getMonthByDate(date).then((value) {
      if (value == null) {
        return null;
      } else {
        return value.toModel();
      }
    });
  }

  Future<List<ModelCategory>> getAllCategories(String date) async {
    return await daoExpense
        .getAllCategories(date)
        .then((value) => List.generate(value.length, (index) {
              return value[index].toModel();
            }));
  }

  Future<void> insertCategory(ModelCategory modelCategory) async {
    await daoExpense.insertCategory(modelCategory.toEntity());
  }

  Future<void> updateCategoryPaid(ModelCategory modelCategory, double paid) async {
    modelCategory.paid = paid;
    await daoExpense.updateCategory(modelCategory.toEntity());
  }

  Future<ModelCategory?> getCategoryByDateAndCategory(
      String date, String category) async {
    return await daoExpense.getCategoryByDate(date, category).then((value) {
      if (value == null) {
        return null;
      } else {
        return value.toModel();
      }
    });
  }

  Future<void> updateCategoryBudget(
      ModelCategory modelCategory, double budget) async {
    modelCategory.budget = budget;
    await daoExpense.updateCategory(modelCategory.toEntity());
  }
}
