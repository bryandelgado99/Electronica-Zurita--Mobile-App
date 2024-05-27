import 'package:flutter/material.dart';

class cardComposse extends StatelessWidget {
  const cardComposse({super.key, required this.color, required this.borderRadius, required this.text_data, required this.color_text, required this.fontSize, required this.fontWeight, required this.textAlign});

  final String text_data;
  final Color color;
  final double borderRadius;
  final Color color_text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(text_data, textAlign: textAlign, style: TextStyle(color: color_text, fontSize: fontSize, fontWeight: fontWeight),),
          ),
        ],
      ),
    );
  }
}
