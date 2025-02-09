import 'package:expense_tracker/feature_expense/model/model_category.dart';
import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  static final DateFormat dateTimeFormat = DateFormat("MMM dd, yyyy HH:mm");
  static final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  static final List<ModelCategory> categories = [
    ModelCategory(colorGreen, Icons.shopping_cart, 'Shopping', 0, 0),
    ModelCategory(colorBlue, Icons.fastfood, 'Food', 0, 0),
    ModelCategory(colorYellow, Icons.local_hospital, 'Health', 0, 0),
    ModelCategory(colorTeal, Icons.directions_car, 'Transport', 0, 0),
    ModelCategory(colorOrange, Icons.home, 'House', 0, 0),
    ModelCategory(colorPink, Icons.phone_android, 'Utilities', 0, 0),
    ModelCategory(colorGreyDark, Icons.local_movies, 'Entertainment', 0, 0),
    ModelCategory(colorLightPink, Icons.card_giftcard, 'Gifts', 0, 0),
    ModelCategory(colorPurple, Icons.local_atm, 'Car', 0, 0),
  ];
}
