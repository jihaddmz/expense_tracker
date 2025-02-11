import 'package:expense_tracker/feature_expense/components/barchart.dart';
import 'package:expense_tracker/feature_expense/components/item_analytics_per.dart';
import 'package:expense_tracker/feature_expense/components/item_category.dart';
import 'package:expense_tracker/feature_expense/state/provider_expense.dart';
import 'package:expense_tracker/feature_global/components/custom_button.dart';
import 'package:expense_tracker/feature_global/components/custom_text.dart';
import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:expense_tracker/feature_global/util/constants.dart';
import 'package:expense_tracker/feature_global/util/helper_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedBottomNavItem = 0;

  @override
  void initState() {
    super.initState();

    initializeMonthsAndCategories();
  }

  void initializeMonthsAndCategories() async {
    await context.read<ProviderExpense>().addMonth();
    await context.read<ProviderExpense>().getAllMonths();
    await context
        .read<ProviderExpense>()
        .getAllCategories(context.read<ProviderExpense>().selectedMonth);
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
            HelperDialog.showBottomSheet(context, "Do you want to delete", () {
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
      body: SingleChildScrollView(
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
            Row(
              children: [
                Expanded(
                  child: customButton(
                      text: "Expenses",
                      widthFactor: 1,
                      radius: 20,
                      color: colorBlack,
                      onClick: () {}),
                ),
                if (context.watch<ProviderExpense>().listOfMonths.length > 1)
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
                          value: context.watch<ProviderExpense>().selectedMonth,
                          items: context
                              .read<ProviderExpense>()
                              .listOfMonths
                              .map((month) {
                            return DropdownMenuItem(
                                value: month.date,
                                child: customCaption(month.date));
                          }).toList(),
                          onChanged: (month) {
                            context
                                .read<ProviderExpense>()
                                .changeSelectedMonth(month.toString());
                            context
                                .read<ProviderExpense>()
                                .getAllCategories(month.toString());
                          }),
                    ),
                  ),
                if (context.watch<ProviderExpense>().listOfMonths.length <= 1)
                  Expanded(
                    child: customButton(
                        text: context.watch<ProviderExpense>().selectedMonth,
                        widthFactor: 1,
                        radius: 20,
                        color: colorGrey,
                        textColor: colorBlack,
                        onClick: () {}),
                  ),
              ],
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
                          "Day",
                          context.read<ProviderExpense>().expensesByMonth /
                              30)),
                  Expanded(
                      child: itemAnalyticsPer("Week",
                          context.read<ProviderExpense>().expensesByMonth / 4)),
                  Expanded(
                      child: itemAnalyticsPer("Month",
                          context.read<ProviderExpense>().expensesByMonth)),
                ],
              ),
            ),
            Column(
              children: categories(),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> categories() {
    return context.watch<ProviderExpense>().listOfCategories.map((category) {
      MapEntry<String, Map<String, dynamic>> categoryItem = Constants
          .categories.entries
          .firstWhere((element) => element.key == category.category);
      return itemCategory(categoryItem.value["color"], category.category,
          category.paid, category.budget, categoryItem.value["icon"]);
    }).toList();
  }
}
