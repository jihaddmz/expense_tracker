import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:flutter/material.dart';

Widget customButton(
    {required String text,
    required double widthFactor,
    required VoidCallback onClick,
    double radius = 20,
    Color color = colorGrey,
    Color textColor = colorWhite}) {
  return FractionallySizedBox(
    widthFactor: widthFactor,
    child: ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(text),
      ),
    ),
  );
}

Widget customButtonForPopupMenu(
    {required String text,
    required double widthFactor,
    required VoidCallback? onClick,
    required IconData icon,
    required IconData trailingIcon,
    double radius = 12,
    Color color = colorGrey}) {
  return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
            disabledBackgroundColor: color,
            backgroundColor: color,
            disabledForegroundColor: colorBlack,
            foregroundColor: colorBlack,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                icon,
                color: colorBlack,
              ),
              Flexible(
                  child: Text(
                text,
              )),
              Icon(
                trailingIcon,
                color: colorBlack,
              ),
            ],
          ),
        ),
      ));
}

Widget customButtonWithTrailingIcon(
    {required String text,
    required double widthFactor,
    required VoidCallback onClick,
    required IconData icon,
    double radius = 12,
    Color color = colorGrey}) {
  return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
              const SizedBox(
                width: 20,
              ),
              Icon(icon),
            ],
          ),
        ),
      ));
}

Widget customButtonWithIcon(
    {required String text,
    required double widthFactor,
    required VoidCallback onClick,
    required IconData icon,
    Color color = colorGrey}) {
  return FractionallySizedBox(
    widthFactor: widthFactor,
    child: ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(
              width: 20,
            ),
            Text(text)
          ],
        ),
      ),
    ),
  );
}
