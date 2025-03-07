import 'package:expense_tracker/core/components/custom_text.dart';
import 'package:expense_tracker/core/config/color.dart';
import 'package:flutter/material.dart';

Widget itemAnalyticsPer(String type, double paid) {
  return Card(
    color: colorGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        children: [
          customCaption(type),
          customSubHeader("\$${paid.toStringAsFixed(2)}")
        ],
      ),
    ),
  );
}
