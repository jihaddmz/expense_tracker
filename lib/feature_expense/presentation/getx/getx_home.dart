import 'package:expense_tracker/core/injection_container.dart';
import 'package:expense_tracker/feature_expense/domain/repository/repo_expense.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_category.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_month.dart';
import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/helpers/helper_sharedpref.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

class GetxHome extends GetxController {
  late RepositoryExpense repositoryExpense;

  var listOfMonths = <ModelMonth>[].obs;
  var listOfCategories = <ModelCategory>[].obs;
  var selectedMonth = "".obs;
  var expensesByMonth = 0.0.obs;
  var isLoading = false.obs;

  GetxHome() {
    repositoryExpense = getIt();
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

    await repositoryExpense.getModelMonthByDate(shrinkedDate)
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
    expensesByMonth.value = getAllExpensesByMonth();
  }

  Future<void> insertCategory(ModelCategory modelCategory) async {
    await repositoryExpense.insertCategory(modelCategory);
  }

  Future<void> updateCategoryPaid(
      String date, String categoryName, double paid) async {
    ModelCategory? category =
        await repositoryExpense.getCategoryByDateAndCategory(
            date, categoryName);
    if (category == null) {
      return;
    }
    await repositoryExpense.updateCategoryPaid(category, category.paid + paid);
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
    await repositoryExpense.updateCategoryBudget(modelCategory, budget);
    await HelperSharedPref.setCategoryBudget(category, budget);
    await getAllCategories();
  }
}
