import 'package:expense_tracker/feature_expense/components/keypad.dart';
import 'package:expense_tracker/feature_expense/state/provider_expense.dart';
import 'package:expense_tracker/feature_global/components/custom_button.dart';
import 'package:expense_tracker/feature_global/components/custom_text.dart';
import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:expense_tracker/feature_global/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomsheetAdd extends StatefulWidget {
  const BottomsheetAdd(this.onConfirm, {super.key});

  final Function() onConfirm;

  @override
  State<BottomsheetAdd> createState() => _BottomsheetAddState();
}

class _BottomsheetAddState extends State<BottomsheetAdd> {
  String _paid = "\$0.0";
  String _selectedCategory = Constants.categories.entries.first.key;
  late String _selectedMonth;

  @override
  void initState() {
    super.initState();

    _selectedMonth = context.read<ProviderExpense>().selectedMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: PopupMenuButton(
                initialValue: _selectedMonth,
                onSelected: (value) {
                  setState(() {
                    _selectedMonth = value;
                  });
                },
                color: colorWhite,
                itemBuilder: (BuildContext context) {
                  return context
                      .read<ProviderExpense>()
                      .listOfMonths
                      .map((month) {
                    return PopupMenuItem(
                      value: month.date,
                      child: customCaption(month.date),
                    );
                  }).toList();
                },
                child: customButtonForPopupMenu(
                    text: _selectedMonth,
                    widthFactor: 1,
                    radius: 30,
                    onClick: null,
                    icon: Icons.calendar_month,
                    trailingIcon: Icons.keyboard_arrow_down),
              ),
            ),
            Expanded(
              child: PopupMenuButton(
                initialValue: context
                    .read<ProviderExpense>()
                    .listOfCategories[0]
                    .category,
                onSelected: (value) => {
                  setState(() {
                    _selectedCategory = value.toString();
                  })
                },
                color: colorWhite,
                itemBuilder: (BuildContext context) {
                  return context
                      .read<ProviderExpense>()
                      .listOfCategories
                      .map((category) {
                    return PopupMenuItem(
                      value: category.category,
                      child: customCaption(category.category),
                    );
                  }).toList();
                },
                child: customButtonForPopupMenu(
                    text: _selectedCategory,
                    widthFactor: 1,
                    radius: 30,
                    onClick: null,
                    color: Constants.categories.entries
                        .firstWhere(
                            (element) => element.key == _selectedCategory)
                        .value["color"],
                    icon: Constants.categories.entries
                        .firstWhere(
                            (element) => element.key == _selectedCategory)
                        .value["icon"],
                    trailingIcon: Icons.keyboard_arrow_down),
              ),
            ),
          ],
        ),
        customCaption("Paid"),
        customSubHeader(_paid),
        Expanded(
          child: KeypadScreen(onKeyPressed: (action) async {
            if (action == "close") {
              widget.onConfirm();
            } else if (action == "backspace") {
              setState(() {
                _paid = _paid.substring(0, _paid.length - 1);
              });
            } else if (action == "confirm") {
              if (!isTextPaidValid()) return;
              await context.read<ProviderExpense>().updateCategoryPaid(
                  _selectedMonth,
                  _selectedCategory,
                  double.parse(_paid.replaceAll("\$", "")));
              await context
                  .read<ProviderExpense>()
                  .getAllCategories(_selectedMonth);
              setState(() {
                _paid = "\$0.0";
              });
            } else if (action == ".") {
              if (!_paid.contains(".") && _paid.isNotEmpty) {
                setState(() {
                  _paid += action;
                });
              }
            } else if (action == "\$" || action == "LL") {
              if (!_paid.contains("\$") && !_paid.contains("LL")) {
                setState(() {
                  _paid = "$action$_paid";
                });
              }
            } else if (_paid.contains("0.0")) {
              setState(() {
                _paid = action;
              });
            } else {
              setState(() {
                _paid += action;
              });
            }
          }),
        ),
      ],
    );
  }

  bool isTextPaidValid() {
    return _paid.isNotEmpty && _paid != "\$0.0";
  }
}
