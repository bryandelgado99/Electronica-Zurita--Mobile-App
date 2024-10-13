import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';

class ArticSwitch extends StatefulWidget {
  const ArticSwitch({super.key});

  @override
  _ArticSwitchState createState() => _ArticSwitchState();
}

class _ArticSwitchState extends State<ArticSwitch> {
  bool isDarkMode = false;

  void toggleSwitch(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: Colors.white,
      ),
      title: Text(
        isDarkMode ? 'Modo Oscuro' : 'Modo Claro',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: toggleSwitch,
        activeColor: AppColors.secondaryColor,
        inactiveThumbColor: AppColors.primaryColor,
      ),
    );
  }
}