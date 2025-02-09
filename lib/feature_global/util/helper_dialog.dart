import 'package:expense_tracker/feature_expense/presentation/bottomsheet_add.dart';
import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_text.dart';

class HelperDialog {
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

  static void showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const AlertDialog(
                backgroundColor: Colors.black,
                content: SizedBox(
                  width: 70,
                  height: 70,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colorBlack,
                    ),
                  ),
                ),
              ),
            ));
  }

  static void showPermanentDialog(BuildContext context, String text) {
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

  static void showBottomSheet(
      BuildContext context, String text, VoidCallback onYesClick) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        backgroundColor: colorWhite,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: BottomsheetAdd(),
            ),
          );
        });
  }
}
