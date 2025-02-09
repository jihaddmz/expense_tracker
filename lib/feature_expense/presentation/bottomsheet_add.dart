import 'package:expense_tracker/feature_expense/components/keypad.dart';
import 'package:expense_tracker/feature_global/components/custom_button.dart';
import 'package:expense_tracker/feature_global/components/custom_text.dart';
import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:expense_tracker/feature_global/util/constants.dart';
import 'package:flutter/material.dart';

class BottomsheetAdd extends StatefulWidget {
  const BottomsheetAdd({super.key});

  @override
  State<BottomsheetAdd> createState() => _BottomsheetAddState();
}

class _BottomsheetAddState extends State<BottomsheetAdd> {
  String _expense = "\$0.0";
  String _selectedCategory = Constants.categories[0].name;
  String _selectedMonth = Constants.months[0];

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
                  return Constants.months.map((month) {
                    return PopupMenuItem(
                      value: month,
                      child: customCaption(month),
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
                initialValue: _selectedCategory,
                onSelected: (value) => {
                  setState(() {
                    _selectedCategory = value.toString();
                  })
                },
                color: colorWhite,
                itemBuilder: (BuildContext context) {
                  return Constants.categories.map((category) {
                    return PopupMenuItem(
                      value: category.name,
                      child: customCaption(category.name),
                    );
                  }).toList();
                },
                child: customButtonForPopupMenu(
                    text: _selectedCategory,
                    widthFactor: 1,
                    radius: 30,
                    onClick: null,
                    color: Constants.categories[0].color,
                    icon: Constants.categories[0].icon,
                    trailingIcon: Icons.keyboard_arrow_down),
              ),
            ),
          ],
        ),
        customCaption("Expenses"),
        customSubHeader(_expense),
        Expanded(
          child: KeypadScreen(onKeyPressed: (action) {
            if (action == "backspace") {
              setState(() {
                _expense = _expense.substring(0, _expense.length - 1);
              });
            } else if (action == "confirm") {
              // todo
            } else if (action == ".") {
              if (!_expense.contains(".") && _expense.isNotEmpty) {
                setState(() {
                  _expense += action;
                });
              }
            } else if (action == "\$" || action == "LL") {
              if (!_expense.contains("\$") && !_expense.contains("LL")) {
                setState(() {
                  _expense = "$action$_expense";
                });
              }
            } else if (_expense.contains("0.0")) {
              setState(() {
                _expense = action;
              });
            } else {
              setState(() {
                _expense += action;
              });
            }
          }),
        ),
      ],
    );
  }
}
