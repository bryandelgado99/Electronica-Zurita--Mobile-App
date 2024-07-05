// navigation_helpers.dart

import 'package:electronica_zurita/app/views/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';// Asegúrate de importar el archivo donde tienes tu LoginScreen

Future<void> finishOnBoarding(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('showOnBoardScreen', false);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}