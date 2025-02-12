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
    'Shopping': {'color': colorGreen, 'icon': Icons.shopping_cart_outlined},
    'Food': {'color': colorBlue, 'icon': Icons.fastfood_outlined},
    'Health': {'color': colorYellow, 'icon': Icons.local_hospital_outlined},
    'Transport': {'color': colorTeal, 'icon': Icons.directions_bus_outlined},
    'Home': {'color': colorOrange, 'icon': Icons.home_outlined},
    'Utilities': {'color': colorPink, 'icon': Icons.phone_android_outlined},
    'Activities': {'color': colorGrey, 'icon': Icons.local_movies_outlined},
    'Gifts': {'color': colorLightPink, 'icon': Icons.card_giftcard_outlined},
    'Help': {'color': colorGreen, 'icon': Icons.help_outline},
    'Car': {'color': colorPurple, 'icon': Icons.directions_car_outlined},
  };
}
