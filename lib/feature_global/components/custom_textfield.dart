import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:flutter/material.dart';

Widget customTextFieldWithController(BuildContext context,
    TextEditingController controller,
    Function(String) onValueChange, {
      int maxLines = 1,
      int minLines = 1,
      Color color = Colors.black,
      Widget? suffixIcon,
      bool enabled = true,
      String? labelText,
      bool obscureText = false,
      String hintText = "",
      TextInputType inputType = TextInputType.text,
    }) {
  return TextFormField(
    controller: controller,
    onChanged: (value) {
      onValueChange(value);
    },
    enabled: enabled,
    keyboardType: inputType,
    minLines: minLines,
    maxLines: maxLines,
    cursorColor: Colors.black,
    obscureText: obscureText,
    style: TextStyle(color: color),
    decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: colorGrey,
        filled: true,
        hintStyle: const TextStyle(color: colorGrey),
        labelText: labelText,
        labelStyle: const TextStyle(color: colorGrey),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorGrey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorGrey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: colorGrey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        )),
  );
}
