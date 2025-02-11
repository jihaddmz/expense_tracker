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
  final TextEditingController _controllerBudget = TextEditingController();
  final getxController = Get.put(GetxHome());

  @override
  void initState() {
    super.initState();

    initializeMonthsAndCategories();
  }

  void initializeMonthsAndCategories() async {
    await getxController.addMonth();
    await getxController.getAllMonths();
    await getxController
        .getAllCategories();
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add',
          ),
        ],
      ),
      body: Obx(() => getxController.isLoading.value ? buildLoader() : buildBody()) ,
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
                child: customSubHeader("\$32,000"),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // todo : implement onTap
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customCaption("Total Balance"),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: colorGreyDark,
                      )
                    ],
                  ),
                ),
              ),
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
                          items: getxController
                              .listOfMonths
                              .map((month) {
                            return DropdownMenuItem(
                                value: month.date,
                                child: customCaption(month.date));
                          }).toList(),
                          onChanged: (month) {
                            getxController
                                .changeSelectedMonth(month.toString());
                            getxController
                                .getAllCategories();
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
          const SizedBox(
            height: 200,
            child: CustomBarChart(
              listOfPercentage: [8, 22, 4, 20, 56, 100, 70],
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
          Column(
            children: buildCategories(),
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
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: colorWhite,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Set the budget for ${category.category}"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        controller: _controllerBudget,
                        decoration:
                            const InputDecoration(label: Text("Budget")),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    customButton(
                        onClick: () async {
                          await getxController.updateCategoryBudget(
                              category.category,
                              double.parse(_controllerBudget.text));
                          _controllerBudget.clear();
                          Navigator.pop(context);
                        },
                        text: "Set",
                        textColor: colorBlack,
                        widthFactor: 1)
                  ],
                ),
              );
            });
      });
    }).toList();
  }
}
