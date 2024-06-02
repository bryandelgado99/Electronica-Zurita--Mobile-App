// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final double fontSize;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.onPressed, required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }
}
