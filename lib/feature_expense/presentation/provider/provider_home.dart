import 'package:expense_tracker/feature_expense/data/local/repo.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_category.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_month.dart';
import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/helpers/helper_sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderHome extends ChangeNotifier {
  List<ModelMonth> listOfMonths = [];
  List<ModelCategory> listOfCategories = [];
  late String selectedMonth;
  double expensesByMonth = 0;
  bool isLoading = false;

  void changeSelectedMonth(String month) {
    selectedMonth = month;
    notifyListeners();
  }

  Future<void> addMonth() async {
    isLoading = true;
    notifyListeners();

    DateTime dateTime = DateTime.now();
    var formattedDate = DateFormat.yMMMM().format(dateTime);
    var shrinkedDate =
        "${formattedDate.split(" ")[0].substring(0, 3)} ${formattedDate.split(" ")[1]}";
    changeSelectedMonth(shrinkedDate);

    await RepositoryExpense.getModelMonthByDate(shrinkedDate)
        .then((value) async {
      if (value == null) {
        // this month hasn't been added before, so add it to the database
        await RepositoryExpense.insertMonth(ModelMonth(date: shrinkedDate));
        for (var item in Constants.categories.entries) {
          await insertCategory(ModelCategory(
              category: item.key,
              date: shrinkedDate,
              budget: HelperSharedPref.getCategoryBudget(item.key),
              paid: 0));
        }
      }
    });

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllMonths() async {
    listOfMonths = await RepositoryExpense.getAllMonths();
    notifyListeners();
  }

  Future<void> getAllCategories(String date) async {
    listOfCategories = await RepositoryExpense.getAllCategories(date);
    listOfCategories.sort((a, b) => b.paid.compareTo(a.paid));
    expensesByMonth = getAllExpensesByMonth();
    notifyListeners();
  }

  Future<void> insertCategory(ModelCategory modelCategory) async {
    await RepositoryExpense.insertCategory(modelCategory);
  }

  Future<void> updateCategoryPaid(
      String date, String categoryName, double paid) async {
    ModelCategory? category =
        await RepositoryExpense.getCategoryByDateAndCategory(
            date, categoryName);
    if (category == null) {
      return;
    }
    await RepositoryExpense.updateCategoryPaid(category, category.paid + paid);
  }

  double getAllExpensesByMonth() {
    double total = 0;
    for (var item in listOfCategories) {
      total += item.paid;
    }
    return total;
  }

  Future<void> updateCategoryBudget(String category, double budget) async {
    ModelCategory? modelCategory =
        listOfCategories.firstWhere((element) => element.category == category);
    await RepositoryExpense.updateCategoryBudget(modelCategory, budget);
    await HelperSharedPref.setCategoryBudget(category, budget);
    await getAllCategories(selectedMonth);
  }
}
