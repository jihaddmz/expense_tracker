import 'package:expense_tracker/core/components/custom_text.dart';
import 'package:expense_tracker/core/config/color.dart';
import 'package:flutter/material.dart';

Widget itemCategory(Color backgroundColor, String categoryName, double amount,
    double totalAmount, IconData icon, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: backgroundColor,
            child: Icon(
              icon,
              color: colorBlack,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          customSubHeader(categoryName),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  customSubHeader("\$${amount.toStringAsFixed(2)}",
                      textColor:
                          amount > totalAmount ? Colors.red : colorBlack),
                  const SizedBox(
                    height: 5,
                  ),
                  customCaption("\$$totalAmount"),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
