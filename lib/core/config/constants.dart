import 'package:expense_tracker/core/config/color.dart';
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
    'Food': {'color': colorBlue, 'icon': Icons.fastfood_outlined},
    'Home': {'color': colorOrange, 'icon': Icons.home_outlined},
    'Health': {'color': colorYellow, 'icon': Icons.local_hospital_outlined},
    'Car': {'color': colorPurple, 'icon': Icons.directions_car_outlined},
    'Transport': {'color': colorTeal, 'icon': Icons.directions_bus_outlined},
    'Shopping': {'color': colorGreen, 'icon': Icons.shopping_cart_outlined},
    'Sport': {'color': colorLightPink, 'icon': Icons.shopping_cart_outlined},
    'Activities': {'color': colorGrey, 'icon': Icons.local_movies_outlined},
    'Utilities': {'color': colorPink, 'icon': Icons.phone_android_outlined},
    'Gifts': {'color': colorBlue, 'icon': Icons.card_giftcard_outlined},
    'Help': {'color': colorOrange, 'icon': Icons.help_outline},
  };
}
