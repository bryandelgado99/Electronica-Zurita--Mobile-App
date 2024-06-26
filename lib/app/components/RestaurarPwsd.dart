// ignore_for_file: file_names
import 'dart:convert';
import 'package:electronica_zurita/app/components/decorations/texts/widgetText.dart';
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RestaurarPwsd extends StatefulWidget {
  const RestaurarPwsd({super.key});

  @override
  State<RestaurarPwsd> createState() => _RestaurarPwsdState();
}

class _RestaurarPwsdState extends State<RestaurarPwsd> {
  TextEditingController recpassController = TextEditingController();
  final _recpass = GlobalKey<FormState>();
  //final String _recuperarcredenciales = 'https://backendtesis.onrender.com/api/cliente/recuperar-contra';  // URL actualizada

  Future<void> _recuperarContrasena() async {
    final String correo = recpassController.text;
    const String uri = "https://backendtesis.onrender.com/api/cliente/recuperar-contra";
    if (kDebugMode) {
      print('Correo ingresado: $correo');
    }
    EasyLoading.show(status: 'Enviando correo...');

    try {
      final response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'correo': correo,
        }),
      );

      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Correo enviado correctamente');
      } else {
        final responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('msg')) {
          EasyLoading.showError('Error: ${responseBody['msg']}');
        } else {
          EasyLoading.showError('Error desconocido al enviar correo');
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error de red, por favor intenta de nuevo');
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const widgetText(
                text: "Recuperar Contraseña",
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20,),
              const widgetText(
                text: "Por favor ingresa tu correo electrónico, si te encuentras registrado, para recibir un correo con tus credenciales.",
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28,),
              Form(
                key: _recpass,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: recpassController,
                  decoration: const InputDecoration(
                    labelText: "Correo electrónico",
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, width: 3.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, width: 3.0,
                      ),
                    ),
                  ),
                  validator: (correo) {
                    if (correo!.isEmpty) {
                      return "Campo obligatorio";
                    }
                    if (!correo.contains('@')) {
                      return "Formato de correo no válido";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor, backgroundColor: AppColors.bgColor,
                ),
                onPressed: () async{
                  if (_recpass.currentState!.validate()) {
                    _recuperarContrasena();
                  }
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.mail_rounded,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Obtener correo",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}