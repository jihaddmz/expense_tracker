import 'package:expense_tracker/feature_expense/data/repo.dart';
import 'package:expense_tracker/feature_expense/model/model_category.dart';
import 'package:expense_tracker/feature_expense/model/model_month.dart';
import 'package:expense_tracker/feature_global/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderExpense extends ChangeNotifier {
  List<ModelMonth> listOfMonths = [];
  List<ModelCategory> listOfCategories = [];
  String selectedMonth = Constants.months[0];

  void changeSelectedMonth(String month) {
    selectedMonth = month;
    notifyListeners();
  }

  Future<void> addMonth() async {
    DateTime dateTime = DateTime.now();
    var formattedDate = DateFormat.yMMMM().format(dateTime);
    changeSelectedMonth(formattedDate);

    await RepositoryExpense.getModelMonthByDate(formattedDate)
        .then((value) async {
      if (value == null) {
        // this month hasn't been added before, so add it to the database
        await RepositoryExpense.insertMonth(ModelMonth(date: formattedDate));
        for (var item in Constants.categories.entries) {
          await insertCategory(ModelCategory(
              category: item.key, date: formattedDate, budget: 100, paid: 0));
        }
      }
    });
  }

  Future<void> getAllMonths() async {
    listOfMonths = await RepositoryExpense.getAllMonths();
    notifyListeners();
  }

  Future<void> getAllCategories(String date) async {
    listOfCategories = await RepositoryExpense.getAllCategories(date);
    notifyListeners();
  }

  Future<void> insertCategory(ModelCategory modelCategory) async {
    await RepositoryExpense.insertCategory(modelCategory);
  }

  Future<void> updateCategoryPaid(
      String date, String categoryName, double paid) async {
    ModelCategory? category =
        await RepositoryExpense.getCategoryByDateAndCategory(date, categoryName);
        if (category == null) {
          return;
        }
    await RepositoryExpense.updateCategoryPaid(category, category.paid + paid);
  }
}
