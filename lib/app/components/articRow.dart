import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';

class articRow extends StatefulWidget {
  const articRow({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.trail_icon,
    required this.isSelected, // Recibe si está seleccionado o no
  });

  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final IconData trail_icon;
  final bool isSelected; // Nuevo parámetro para manejar la selección

  @override
  State<articRow> createState() => _articRowState();
}

class _articRowState extends State<articRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon, color: widget.isSelected ? AppColors.secondaryColor : Colors.white),
      title: Text(
        widget.text,
        style: TextStyle(color: widget.isSelected ? AppColors.secondaryColor : Colors.white),
      ),
      trailing: Icon(widget.trail_icon, color: widget.isSelected ? AppColors.secondaryColor : Colors.white),
      onTap: widget.onPressed, // Ejecuta la función que se pasó desde el widget padre
    );
  }
}
