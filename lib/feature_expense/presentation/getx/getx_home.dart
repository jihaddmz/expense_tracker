import 'package:expense_tracker/core/injection_container.dart';
import 'package:expense_tracker/feature_expense/domain/repository/repo_expense.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_category.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_month.dart';
import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/helpers/helper_sharedpref.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import '../../domain/model/model_paid.dart';

class GetxHome extends GetxController {
  late RepositoryExpense repositoryExpense;

  var listOfMonths = <ModelMonth>[].obs;
  var listOfCategories = <ModelCategory>[].obs;
  var listOfPaidPercentages = <double>[].obs;
  var selectedMonth = "".obs;
  var expensesByMonth = 0.0.obs;
  var isLoading = false.obs;
  var dolarRate = 0.obs;

  void getDolarRate() async {
    dolarRate.value = HelperSharedPref.getDolarRate();
  }

  Future<void> changeDolarRate(int rate) async {
    await HelperSharedPref.setDolarRate(rate);
    getDolarRate();
  }

  double convertFromLLToUSD(double paid) {
    return paid / dolarRate.value;
  }

  GetxHome() {
    repositoryExpense = getIt();
  }

  Future<void> refreshUI() async {
    getDolarRate();
    await getAllMonths();
    await getAllCategories();
    await getAllExpensesByMonth();
    await getAllPaid();
  }

  void changeSelectedMonth(String month) {
    selectedMonth.value = month;
  }

  Future<void> addMonth() async {
    isLoading.value = true;

    DateTime dateTime = DateTime.now();
    var formattedDate = DateFormat.yMMMM().format(dateTime);
    var shrinkedDate =
        "${formattedDate.split(" ")[0].substring(0, 3)} ${formattedDate.split(" ")[1]}";
    changeSelectedMonth(shrinkedDate);

    await repositoryExpense
        .getModelMonthByDate(shrinkedDate)
        .then((value) async {
      if (value == null) {
        // this month hasn't been added before, so add it to the database
        await repositoryExpense.insertMonth(ModelMonth(date: shrinkedDate));
        for (var item in Constants.categories.entries) {
          await insertCategory(ModelCategory(
              category: item.key,
              date: shrinkedDate,
              budget: HelperSharedPref.getCategoryBudget(item.key),
              paid: 0));
        }
      }
    });

    isLoading.value = false;
  }

  Future<void> getAllMonths() async {
    listOfMonths.value = await repositoryExpense.getAllMonths();
  }

  Future<void> getAllCategories() async {
    listOfCategories.value =
        await repositoryExpense.getAllCategories(selectedMonth.value);
    listOfCategories.sort((a, b) => b.paid.compareTo(a.paid));
  }

  Future<void> getAllPaid() async {
    var paid5 = await repositoryExpense.getSumOfPaidByMonthAndDay(
        selectedMonth.value, 5);
    var paid10 = await repositoryExpense.getSumOfPaidByMonthAndDay(
        selectedMonth.value, 10);
    var paid15 = await repositoryExpense.getSumOfPaidByMonthAndDay(
        selectedMonth.value, 15);
    var paid20 = await repositoryExpense.getSumOfPaidByMonthAndDay(
        selectedMonth.value, 20);
    var paid25 = await repositoryExpense.getSumOfPaidByMonthAndDay(
        selectedMonth.value, 25);
    var paid30 = await repositoryExpense.getSumOfPaidByMonthAndDay(
        selectedMonth.value, 30);

    expensesByMonth.value == 0.0
        ? listOfPaidPercentages.value = [0, 0, 0, 0, 0, 0]
        : listOfPaidPercentages.value = [
            paid5 * 100 / expensesByMonth.value,
            paid10 * 100 / expensesByMonth.value,
            paid15 * 100 / expensesByMonth.value,
            paid20 * 100 / expensesByMonth.value,
            paid25 * 100 / expensesByMonth.value,
            paid30 * 100 / expensesByMonth.value
          ];
  }

  Future<void> insertCategory(ModelCategory modelCategory) async {
    await repositoryExpense.insertCategory(modelCategory);
  }

  Future<void> updateCategoryPaid(
      String date, String categoryName, double paid) async {
    ModelCategory? category = await repositoryExpense
        .getCategoryByDateAndCategory(date, categoryName);
    if (category == null) {
      return;
    }
    await repositoryExpense.updateCategoryPaid(category, category.paid + paid);
  }

  Future<void> getAllExpensesByMonth() async {
    expensesByMonth.value =
        await repositoryExpense.getSumOfPaidByMonth(selectedMonth.value);
  }

  Future<void> updateCategoryBudget(String category, double budget) async {
    ModelCategory? modelCategory =
        listOfCategories.firstWhere((element) => element.category == category);
    await repositoryExpense.updateCategoryBudget(modelCategory, budget);
    await HelperSharedPref.setCategoryBudget(category, budget);
    await getAllCategories();
  }

  Future<void> insertPaid(String month, String category, double paid) async {
    int day = DateTime.now().day;
    await repositoryExpense.insertPaid(
        ModelPaid(month: month, day: day, paid: paid, category: category));
  }
}
