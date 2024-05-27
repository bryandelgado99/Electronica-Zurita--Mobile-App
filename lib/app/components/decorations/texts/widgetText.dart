import 'package:flutter/material.dart';

class widgetText extends StatelessWidget {
  const widgetText({super.key, required this.text, required this.fontSize, required this.fontWeight, required this.color, required this.textAlign});

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text, textAlign: textAlign, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color,),
    );
  }
}
