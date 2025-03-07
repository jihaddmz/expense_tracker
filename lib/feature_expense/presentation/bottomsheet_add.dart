import 'package:expense_tracker/feature_expense/components/keypad.dart';
import 'package:expense_tracker/feature_expense/presentation/getx/getx_home.dart';
import 'package:expense_tracker/core/components/custom_button.dart';
import 'package:expense_tracker/core/components/custom_text.dart';
import 'package:expense_tracker/core/config/color.dart';
import 'package:expense_tracker/core/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final getxController = Get.find<GetxHome>();

  @override
  void initState() {
    super.initState();

    _selectedMonth = getxController.selectedMonth.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        Row(
          spacing: 5,
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
                  return getxController.listOfMonths.map((month) {
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
                initialValue: getxController.listOfCategories[0].category,
                onSelected: (value) => {
                  setState(() {
                    _selectedCategory = value.toString();
                  })
                },
                color: colorWhite,
                itemBuilder: (BuildContext context) {
                  return getxController.listOfCategories.map((category) {
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
            onActionPress(action);
          }),
        ),
      ],
    );
  }

  void onActionPress(String action) async {
    if (action == "close") {
      widget.onConfirm();
    } else if (action == "backspace") {
      setState(() {
        _paid = _paid.substring(0, _paid.length - 1);
      });
    } else if (action == "confirm") {
      if (!isTextPaidValid()) return;
      bool isItLLPrice = _paid.contains("LL"); // if the price paid is in LL
      _paid = _paid.replaceAll("\$", "").replaceAll("LL", "");
      if (isItLLPrice) {
        // convert this amount from LL to usd
        _paid = getxController.convertFromLLToUSD(double.parse(_paid) ).toString();
      }

      await getxController.updateCategoryPaid(
          _selectedMonth, _selectedCategory, double.parse(_paid));
      await getxController.insertPaid(
          _selectedMonth, _selectedCategory, double.parse(_paid));
      await getxController.refreshUI();
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
  }

  bool isTextPaidValid() {
    return _paid.isNotEmpty && _paid != "\$0.0";
  }
}
