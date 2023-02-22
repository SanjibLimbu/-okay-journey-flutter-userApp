import 'package:flutter/material.dart';
import 'package:user_app/const/style.dart';

class LabelValue extends StatelessWidget {
  const LabelValue({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: textStyle),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: textStyle,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
