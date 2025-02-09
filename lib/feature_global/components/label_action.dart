import 'package:expense_tracker/feature_global/util/color.dart';
import 'package:flutter/material.dart';


class LabelAction extends StatefulWidget {
  const LabelAction(this.color, this.label, this.icon, this.list, {super.key});

  final Color color;
  final String label;
  final IconData? icon; // if we want to show an icon before the label
  final List<String>? list; // if we want to show a drop down

  @override
  State<LabelAction> createState() => _LabelActionState();
}

class _LabelActionState extends State<LabelAction> {
  String? _selectedLabel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: WidgetStateProperty.all(widget.color)),
      onPressed: () {},
      child: Row(
        children: [
          if (widget.icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                widget.icon,
                color: colorBlack,
              ),
            ),
          if (widget.list == null)
            Text(
              widget.label,
              style: const TextStyle(color: colorBlack),
            ),
          if (widget.list != null)
            DropdownButton<String>(
                underline: const SizedBox(),
                value: _selectedLabel,
                icon: const Icon(Icons.arrow_drop_down),
                items: widget.list!.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (item) {
                  setState(() {
                    _selectedLabel = item;
                  });
                })
        ],
      ),
    );
  }
}
