// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:electronica_zurita/app/components/decorations/texts/widgetText.dart';
import 'package:flutter/material.dart';

class titleHome extends StatelessWidget {
  const titleHome({super.key, required this.color_text});

  final Color color_text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/logo.png', width: 80),
        const SizedBox(height: 20,),
        widgetText(text: "Electrónica Zurita", fontSize: 25, fontWeight: FontWeight.w600, color: color_text, textAlign: TextAlign.center,),
      ],
    );
  }
}
