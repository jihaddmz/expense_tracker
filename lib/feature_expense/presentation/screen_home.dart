import 'package:expense_tracker/feature_expense/components/barchart.dart';
import 'package:expense_tracker/feature_expense/components/item_analytics_per.dart';
import 'package:expense_tracker/feature_expense/components/item_category.dart';
import 'package:expense_tracker/feature_global/components/custom_button.dart';
import 'package:expense_tracker/feature_global/components/custom_text.dart';
import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:expense_tracker/feature_global/util/constants.dart';
import 'package:expense_tracker/feature_global/util/helper_dialog.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  String _selectedMonth = Constants.months[0];
  int _selectedBottomNavItem = 0;

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
            HelperDialog.showBottomSheet(
                context, "Do you want to delete", () {});
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
                        value: _selectedMonth,
                        items: Constants.months.map((month) {
                          return DropdownMenuItem(
                              value: month, child: customCaption(month));
                        }).toList(),
                        onChanged: (month) {
                          setState(() {
                            _selectedMonth = month.toString();
                          });
                        }),
                  ),
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
                  Expanded(child: itemAnalyticsPer("Day", 23)),
                  Expanded(child: itemAnalyticsPer("Week", 100)),
                  Expanded(child: itemAnalyticsPer("Month", 400)),
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
    return Constants.categories.map((category) {
      return itemCategory(
          category.color, category.name, category.total, 500, category.icon);
    }).toList();
  }
}
