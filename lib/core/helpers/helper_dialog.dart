import 'package:expense_tracker/core/components/custom_textfield.dart';
import 'package:expense_tracker/feature_expense/presentation/bottomsheet_add.dart';
import 'package:expense_tracker/core/config/color.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_text.dart';

class HelperDialog {
  static void showTypableDialog(BuildContext context, String title,
      TextEditingController controller, Function() onSaveClick) {
    showDialog(
        context: context,
        builder: (context) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AlertDialog(
                backgroundColor: colorWhite,
                title: customSubHeader(title, align: TextAlign.center),
                content: customTextFieldWithController(
                    context,
                    controller,
                    inputType: TextInputType.number,
                    (value) {}),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  customButton(
                      text: "Save",
                      widthFactor: 0.9,
                      color: colorBlack,
                      onClick: () {
                        Navigator.pop(context);
                        onSaveClick();
                      })
                ],
              ),
            ));
  }

  static void showWarningDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AlertDialog(
                backgroundColor: Colors.black,
                title: customHeader("Warning!", align: TextAlign.center),
                content: customParagraph(text, align: TextAlign.center),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  customButton(
                      text: "OK",
                      widthFactor: 0.9,
                      onClick: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ));
  }

  static Future<void> showAutoDismissableDialog(BuildContext context,
      String text, VoidCallback afterDialogDismissed) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AlertDialog(
                backgroundColor: Colors.black,
                title: customHeader("Warning!", align: TextAlign.center),
                content: customParagraph(text, align: TextAlign.center),
              ),
            ));

    // Dismiss after 3 seconds
    await Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop(); // Close the dialog
    });

    afterDialogDismissed();
  }

  static void showBottomSheet(BuildContext context, Function() onConfirm) {
    showModalBottomSheet<Widget>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: colorWhite,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BottomsheetAdd(
                  onConfirm), // Replace 'someArgument' with the actual argument needed
            ),
          );
        });
  }
}
