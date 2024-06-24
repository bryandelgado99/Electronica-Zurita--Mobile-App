// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:io';

import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/logoutView.dart';

class headerPartials extends StatelessWidget implements PreferredSizeWidget {
  const headerPartials({super.key});

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.contrastColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
      child: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/logo_bn@2x.png', width: 60),
                const Spacer(),
                FilledButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.secondaryColor)
                  ),
                    onPressed: (){
                      _showLogoutDialog(context);
                      },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.logout_rounded, size: 15, color: Colors.white,),
                      SizedBox(width: 10,),
                      Text("Salir", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),)
                    ],
                  ),
                )
              ],
          ),
        ],
      ),
  );

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Icon(Icons.crisis_alert_rounded, size: 35,),
              SizedBox(height: 10,),
              Text('Confirmación', style: TextStyle(fontSize: 25),),
            ],
          ),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LogoutView()),
                      (Route<dynamic> route) => false,
                );

                // Espera 5 segundos y cierra la aplicación
                Timer(const Duration(milliseconds: 300), () {
                  exit(0);
                });
              },
              child: const Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32); // Altura del AppBar más el padding
}
