import 'package:expense_tracker/core/data/local/daos/dao_expense.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_category.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_month.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_paid.dart';

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

  Future<void> updateCategoryPaid(
      ModelCategory modelCategory, double paid) async {
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

  Future<void> insertPaid(ModelPaid modelPaid) async {
    switch (modelPaid.day) {
      case <= 5:
        modelPaid.day = 5;
        break;
      case <= 10:
        modelPaid.day = 10;
        break;
      case <= 15:
        modelPaid.day = 15;
        break;
      case <= 20:
        modelPaid.day = 20;
        break;
      case <= 25:
        modelPaid.day = 25;
        break;
      case <= 30:
        modelPaid.day = 30;
        break;
    }
    await daoExpense.insertPaid(modelPaid.toEntity());
  }

  Future<List<ModelPaid>> getAllPaidByMonth(String month) async {
    return await daoExpense
        .getAllPaidByMonth(month)
        .then((value) => List.generate(value.length, (index) {
              return value[index].toModel();
            }));
  }

  Future<double> getSumOfPaidByMonth(String month) async {
    return (await daoExpense.getAllPaidsByMonth(month))
        .fold(0.0, (prev, element) => (prev as double) + element);
  }

  Future<double> getSumOfPaidByMonthAndDay(String month, int day) async {
    return (await daoExpense.getAllPaidsByMonthAndDay(month, day))
        .fold(0.0, (prev, element) => (prev as double) + element);
  }
}
