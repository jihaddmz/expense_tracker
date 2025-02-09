import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:flutter/material.dart';

class KeypadScreen extends StatelessWidget {
  KeypadScreen({super.key, required this.onKeyPressed});

  final Function(String) onKeyPressed;

  final List<Map<String, dynamic>> buttons = [
    {"label": "1", "color": colorGrey},
    {"label": "2", "color": colorGrey},
    {"label": "3", "color": colorGrey},
    {"label": Icons.backspace, "color": colorLightPink}, // Backspace
    {"label": "4", "color": colorGrey},
    {"label": "5", "color": colorGrey},
    {"label": "6", "color": colorGrey},
    {"label": "LL", "color": colorBlue}, // Calendar
    {"label": "7", "color": colorGrey},
    {"label": "8", "color": colorGrey},
    {"label": "9", "color": colorGrey},
    {"label": "", "color": Colors.transparent}, // Empty slot
    {"label": "\$", "color": colorYellow}, // Dollar sign
    {"label": "0", "color": colorGrey},
    {"label": ".", "color": colorGrey},
    {
      "label": Icons.check,
      "color": Colors.black,
      "textColor": colorGrey
    }, // Confirm
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.1, // Adjust cell size
          ),
          itemCount: buttons.length,
          itemBuilder: (context, index) {
            final button = buttons[index];
            return GestureDetector(
              onTap: () {
                if (button["label"] != "") {
                  if (button["label"] == Icons.backspace) {
                    onKeyPressed("backspace");
                  } else if (button["label"] == Icons.check) {
                    onKeyPressed("confirm");
                  }
                  else {
                    onKeyPressed(button["label"].toString());
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: button["color"] ?? colorGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: button["label"] is IconData
                      ? Icon(button["label"],
                          color: button["textColor"] ?? Colors.black)
                      : Text(
                          button["label"],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: button["textColor"] ?? Colors.black,
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
