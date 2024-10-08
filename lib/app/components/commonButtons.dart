// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names
import 'package:flutter/material.dart';

class commonButton extends StatelessWidget {
  const commonButton({super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.color_btn,
    required this.font_color,
    required this.color_icon
  });

  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color color_btn;
  final Color font_color;
  final Color color_icon;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double textSize = screenWidth * 0.035;
    double paddingSize = screenWidth * 0.03;

    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(color_btn)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: paddingSize,
            horizontal: paddingSize * 1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon, color: color_icon,),
              const SizedBox(width: 8), // Espacio entre el icono y el texto
              Text(text, style: TextStyle(
                color: font_color,
                fontWeight: FontWeight.w600,
                fontSize: textSize,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
