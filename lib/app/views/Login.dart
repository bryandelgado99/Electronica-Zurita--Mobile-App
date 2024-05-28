import 'dart:convert';
import 'dart:math';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Usuario.dart';
import '../../models/dataUser.dart';
import '../components/RestaurarPwsd.dart';
import '../components/app_colors.dart';
import '../components/commonButtons.dart';
import 'package:electronica_zurita/app/views/Home.dart';
import '../components/decorations/cardComposse.dart';
import '../components/decorations/svgImage.dart';
import '../components/decorations/textBtn.dart';
import '../components/decorations/titleHome.dart';
import '../../utilities/constants.dart';

// Define tus colores y otros widgets personalizados aquí

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode rucFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    rucController.dispose();
    passwordController.dispose();
    rucFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.contrastColor, // Cambia el color aquí
        statusBarIconBrightness: Brightness.light, // Cambia el color de los iconos (Brightness.dark para iconos oscuros)
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                            child: Column(
                              children: [
                                titleHome(color_text: Colors.black),
                                SizedBox(height: 10,),
                                svgImage(asset_url: 'assets/vectors/electrician.svg', semantic_label: 'Pana', width: 300),
                                SizedBox(height: 10,),
                                cardComposse(
                                    color: AppColors.contrastColor,
                                    borderRadius: 20,
                                    text_data: "Recuerda que debes iniciar sesión con las credenciales enviadas a tu correo electrónico, luego de ingresar la orden de trabajo de tu equipo.",
                                    color_text: AppColors.bgColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                                color: AppColors.contrastColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Form(
                                      key: _loginKey,
                                      child: Column(
                                        children: [
                                          // Cédula o RUC
                                          TextFormField(
                                            keyboardType: TextInputType.emailAddress,
                                            focusNode: rucFocusNode,
                                            textInputAction: TextInputAction.next,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context).requestFocus(passwordFocusNode);
                                            },
                                            style: const TextStyle(color: Colors.white),
                                            controller: rucController,
                                            decoration: const InputDecoration(
                                              labelText: "Correo electrónico",
                                              hintStyle: TextStyle(color: Colors.white),
                                              labelStyle: TextStyle(color: Colors.white),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white, width: 3.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white, width: 3.0),
                                              ),
                                            ),
                                            validator: (ruc) {
                                              if (ruc!.isEmpty) {
                                                return "Campo obligatorio";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20,),
                                          // Contraseña
                                          TextFormField(
                                            focusNode: passwordFocusNode,
                                            textInputAction: TextInputAction.done,
                                            onFieldSubmitted: (value) {
                                              if (_loginKey.currentState!.validate()) {
                                                print("Contraseña correcta");
                                              }
                                            },
                                            obscureText: !_isPasswordVisible,
                                            obscuringCharacter: "*",
                                            style: const TextStyle(color: Colors.white),
                                            controller: passwordController,
                                            decoration: InputDecoration(
                                              labelText: "Contraseña",
                                              hintStyle: const TextStyle(color: Colors.white),
                                              labelStyle: const TextStyle(color: Colors.white),
                                              enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white, width: 3.0),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white, width: 3.0),
                                              ),
                                              suffixIcon: IconButton(
                                                color: Colors.white,
                                                icon: Icon(
                                                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isPasswordVisible = !_isPasswordVisible;
                                                  });
                                                },
                                              ),
                                            ),
                                            validator: (password) {
                                              if (password!.isEmpty) {
                                                return "Campo obligatorio";
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 5),
                                          CustomTextButton(
                                            text: "¿Olvidaste tu contraseña?",
                                            textColor: AppColors.bgColor,
                                            fontSize: 12,
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) {
                                                  return const RestaurarPwsd();
                                                },
                                              );
                                            },
                                          ),
                                          // Botón de Validación
                                          commonButton(
                                            icon: Icons.login_rounded,
                                            text: 'Ingresar',
                                            onPressed: () async {
                                              if (_loginKey.currentState!.validate()) {
                                                _iniciarSesion();
                                              }
                                            },
                                            color_btn: AppColors.secondaryColor,
                                            font_color: AppColors.bgColor,
                                            color_icon: AppColors.bgColor,
                                          ),
                                          const SizedBox(height: 10,),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _iniciarSesion() async {
    await EasyLoading.show(status: 'Iniciando Sesión...');

    final String correo = rucController.text;
    final String password = passwordController.text;

    final response = await http.post(
      Uri.parse(login),  // Reemplaza con la URL correcta
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'correo': correo,
        'password': password,
      }),
    );

    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      //Extrae el ID del cliente de la respuesta
      final String name = responseBody['nombre'];
      //final String clienteID = idObject.toString();
      print(name);

      if (kDebugMode) {
        print("Sesión iniciada");
      }

      // Genera un nuevo JWT siempre
      final jwt = JWT(
        {
          'correo': correo, // Puedes agregar más datos aquí según sea necesario
          'rol': 'cliente',
        },
      );

      // Firma y genera el token
      final token = jwt.sign(SecretKey('secret_key')); // Usa tu clave secreta aquí
      print(token);
      // Guarda el token y el ID del cliente en la clase DataUser
      //DataUser.token = token;
      //DataUser.clienteId = clienteID;

      // Guarda el token o cualquier otro dato necesario
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // Navega a la pantalla principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homeScreen()),
      );
    } else {
      // Maneja los errores de inicio de sesión mostrando un AlertDialog
      final responseBody = jsonDecode(response.body);
      _mostrarErrorDialog(context, response.statusCode, responseBody['msg']);
    }
  }

  void _mostrarErrorDialog(BuildContext context, int statusCode, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error al iniciar sesión', style: TextStyle(color: AppColors.contrastColor, fontWeight: FontWeight.w600)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Posibles errores:", style: TextStyle(fontSize: 16,)),
              const SizedBox(height: 8,),
              ListTile(
                title: Column(
                  children: [
                    Text("${msg}", style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 8,),
                    const Text("EL usuario y/o contraseña son incorrectos.", style: TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              const SizedBox(height: 12,),
              Text("Código de error: $statusCode", style: const TextStyle(fontSize: 12, color: AppColors.secondaryColor),)
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
