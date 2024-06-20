// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:io';
import 'package:electronica_zurita/app/components/commonButtons.dart';
import 'package:electronica_zurita/app/views/logoutView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/ClienteProvider.dart';
import '../../components/app_colors.dart';
import '../../components/ClienteInfo.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key, required String token});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {

  @override
  Widget build(BuildContext context) {

    final clienteProvider = Provider.of<ClienteProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Column(
                      children: [
                        const Text("Bienvenido/a", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                        Text("${clienteProvider.nombreCliente ?? 'Cargando...'}!", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),)
                      ],
                    )),
                  ],
                ),
              ),
              const Spacer(),
              ClienteInfo(
                nombreCliente: clienteProvider.nombreCliente ?? '',
                cedulaCliente: clienteProvider.cedulaCliente ?? '',
                direccionCliente: clienteProvider.direccionCliente ?? '',
                telefonoCliente: clienteProvider.telefonoCliente ?? '',
                correoCliente: clienteProvider.correoCliente ?? '',
                frecuente: clienteProvider.frecuente ?? false,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: commonButton(
                    icon: Icons.logout_rounded,
                    text: "Cerrar Sesión",
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    color_btn: AppColors.secondaryColor,
                    font_color: AppColors.bgColor,
                    color_icon: AppColors.bgColor
                ),
              ),
              const Text("Version: 1.0.0", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.grey), textAlign: TextAlign.right,),
              const SizedBox(height: 15,),
            ],
          ),
          if (clienteProvider.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

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

                if (!mounted) return;

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

}
