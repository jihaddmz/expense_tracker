import 'package:expense_tracker/feature_expense/components/barchart.dart';
import 'package:expense_tracker/feature_expense/components/item_analytics_per.dart';
import 'package:expense_tracker/feature_expense/components/item_category.dart';
import 'package:expense_tracker/feature_expense/presentation/getx/getx_home.dart';
import 'package:expense_tracker/core/components/custom_button.dart';
import 'package:expense_tracker/core/components/custom_text.dart';
import 'package:expense_tracker/core/config/color.dart';
import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/helpers/helper_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedBottomNavItem = 0;
  final getxController = Get.put(GetxHome());
  final TextEditingController _controllerBudget =
      TextEditingController(text: "70");
  final TextEditingController _controllerDolarRate =
      TextEditingController(text: "0");

  @override
  void initState() {
    super.initState();

    initializeMonthsAndCategories();
  }

  void initializeMonthsAndCategories() async {
    await getxController.addMonth();
    await getxController.refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorWhite,
        selectedItemColor: colorBlack,
        currentIndex: _selectedBottomNavItem,
        onTap: (index) {
          setState(() {
            _selectedBottomNavItem = index;
          });
          if (index == 1) {
            HelperDialog.showBottomSheet(context, () {
              setState(() {
                _selectedBottomNavItem = 0;
                Navigator.pop(context);
              });
            });
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: 'Pay',
          ),
        ],
      ),
      body: Obx(
          () => getxController.isLoading.value ? buildLoader() : buildBody()),
    );
  }

  Widget buildLoader() {
    return const Center(
        child: CircularProgressIndicator(
      color: colorBlack,
    ));
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        spacing: 20,
        children: [
          Column(
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => customSubHeader(
                        "L.L.${getxController.dolarRate.value}")),
                    GestureDetector(
                      onTap: () {
                        HelperDialog.showTypableDialog(
                            context,
                            "Set the dolar rate to convert from L.L. to USD.",
                            _controllerDolarRate, () {
                          getxController.changeDolarRate(
                              int.parse(_controllerDolarRate.text));
                        });
                      },
                      child: const Icon(
                        Icons.edit_outlined,
                        color: colorBlack,
                      ),
                    )
                  ],
                ),
              ),
              customCaption("USD Rate"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              spacing: 5,
              children: [
                Expanded(
                  child: customButton(
                      text: "Expenses",
                      widthFactor: 1,
                      radius: 20,
                      color: colorBlack,
                      onClick: () {}),
                ),
                if (getxController.listOfMonths.length > 1)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton(
                          alignment: Alignment.center,
                          dropdownColor: colorWhite,
                          underline: const SizedBox(),
                          value: getxController.selectedMonth.value,
                          items: getxController.listOfMonths.map((month) {
                            return DropdownMenuItem(
                                value: month.date,
                                child: customCaption(month.date));
                          }).toList(),
                          onChanged: (month) {
                            getxController
                                .changeSelectedMonth(month.toString());
                            getxController.refreshUI();
                          }),
                    ),
                  ),
                if (getxController.listOfMonths.length <= 1)
                  Expanded(
                    child: customButton(
                        text: getxController.selectedMonth.value,
                        widthFactor: 1,
                        radius: 20,
                        color: colorGrey,
                        textColor: colorBlack,
                        onClick: () {}),
                  ),
              ],
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(seconds: 3),
            opacity: getxController.listOfPaidPercentages.isEmpty ? 0 : 1,
            curve: Curves.decelerate,
            child: SizedBox(
              height: 200,
              child: CustomBarChart(
                listOfPercentage: getxController.listOfPaidPercentages,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: itemAnalyticsPer(
                        "Day", getxController.expensesByMonth.value / 30)),
                Expanded(
                    child: itemAnalyticsPer(
                        "Week", getxController.expensesByMonth.value / 4)),
                Expanded(
                    child: itemAnalyticsPer(
                        "Month", getxController.expensesByMonth.value)),
              ],
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(seconds: 3),
            opacity: getxController.listOfCategories.isEmpty ? 0 : 1,
            curve: Curves.bounceIn,
            child: Column(
              children: buildCategories(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildCategories() {
    return getxController.listOfCategories.map((category) {
      MapEntry<String, Map<String, dynamic>> categoryItem = Constants
          .categories.entries
          .firstWhere((element) => element.key == category.category);
      return itemCategory(categoryItem.value["color"], category.category,
          category.paid, category.budget, categoryItem.value["icon"], () {
        HelperDialog.showTypableDialog(
            context,
            "Set the budget for ${category.category}",
            _controllerBudget, () async {
          await getxController.updateCategoryBudget(
              category.category, double.parse(_controllerBudget.text));
          _controllerBudget.text = "70";
        });
      });
    }).toList();
  }
}
