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
  static final Map<String, Map<String, dynamic>> categories = {
    'Shopping': {'color': colorGreen, 'icon': Icons.shopping_cart},
    'Food': {'color': colorBlue, 'icon': Icons.fastfood},
    'Health': {'color': colorYellow, 'icon': Icons.local_hospital},
    'Transport': {'color': colorTeal, 'icon': Icons.directions_car},
    'House': {'color': colorOrange, 'icon': Icons.home},
    'Utilities': {'color': colorPink, 'icon': Icons.phone_android},
    'Entertainment': {'color': colorGreyDark, 'icon': Icons.local_movies},
    'Gifts': {'color': colorLightPink, 'icon': Icons.card_giftcard},
    'Car': {'color': colorPurple, 'icon': Icons.local_atm},
  };
}
