// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:convert';
import 'package:electronica_zurita/app/views/sidebar/HomeCompose.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import '../../models/dataUser.dart';
import '../components/RestaurarPwsd.dart';
import '../components/app_colors.dart';
import '../components/commonButtons.dart';
import '../components/decorations/cardComposse.dart';
import '../components/decorations/svgImage.dart';
import '../components/decorations/textBtn.dart';
import '../components/decorations/titleHome.dart';
import '../../utilities/constants.dart';
import 'package:url_launcher/link.dart';

// Define tus colores y otros widgets personalizados aquí

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode correoFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;
  late bool _isLoggingIn = false;

  @override
  void dispose() {
    correoController.dispose();
    passwordController.dispose();
    correoFocusNode.dispose();
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
                          Expanded(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    titleHome(color_text: Colors.black),
                                    svgImage(asset_url: 'assets/vectors/electrician.svg', semantic_label: 'Pana', width: 320),
                                    cardComposse(
                                        color: AppColors.contrastColor,
                                        borderRadius: 20,
                                        text_data: "Recuerda que debes iniciar sesión con las credenciales enviadas a tu correo electrónico, luego de ingresar la orden de trabajo de tu equipo.",
                                        color_text: AppColors.bgColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        textAlign: TextAlign.center
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                              color: AppColors.contrastColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                              child: Center(
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
                                            focusNode: correoFocusNode,
                                            textInputAction: TextInputAction.next,
                                            enabled: !_isLoggingIn,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context).requestFocus(correoFocusNode);
                                            },
                                            style: const TextStyle(color: Colors.white),
                                            controller: correoController,
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
                                              if(!ruc.contains('@')){
                                                return "Formato de correo inválido";
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
                                                if (kDebugMode) {
                                                  print("Contraseña correcta");
                                                }
                                              }
                                            },
                                            obscureText: !_isPasswordVisible,
                                            obscuringCharacter: "*",
                                            enabled: !_isLoggingIn,
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
                                                setState(() {
                                                  _isLoggingIn = true; // Cambia el estado de inicio de sesión
                                                });
                                                _iniciarSesion(context);
                                              }
                                            },
                                            color_btn: AppColors.secondaryColor,
                                            font_color: AppColors.bgColor,
                                            color_icon: AppColors.bgColor,
                                          ),
                                          const SizedBox(height: 5,),
                                          //Center(child: whatsAppWork()),
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

  Future<void> _iniciarSesion(BuildContext context) async {
    await EasyLoading.show(status: 'Iniciando Sesión...');

    final String correo = correoController.text;
    final String password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse(login), // Reemplaza con la URL correcta
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
        // Usar compute para deserializar JSON en un aislado separado
        final responseBody = await compute(jsonDecode, response.body);
        // Extrae el ID del cliente de la respuesta
        final dynamic idObject = responseBody['_id'];
        final String clienteID = idObject.toString();
        final String token = responseBody['token'];

        print(clienteID);
        print(token);

        // Guarda el token y el ID del cliente en la clase DataUser
        DataUser.token = token;
        DataUser.clienteId = clienteID;

        // Navega a la pantalla principal
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const Homecompose()) //homeScreen()),
        );
      } else {
        // Maneja los errores de inicio de sesión mostrando un AlertDialog
        final responseBody = await compute(jsonDecode, response.body);
        // ignore: use_build_context_synchronously
        _mostrarErrorDialog(context, response.statusCode, responseBody['msg']);
        _isLoggingIn = false;
      }
    } catch (error) {
      EasyLoading.dismiss();
      // Manejar errores de red o deserialización aquí
      _mostrarErrorDialog(context, 500, 'No existe conexión a internet. Verifica tu conexión e intentalo nuevamente.');
    }
  }

  void _mostrarErrorDialog(BuildContext context, int statusCode, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Column(
              children: [
                Icon(Icons.warning_rounded, size: 30, color: AppColors.secondaryColor,),
                SizedBox(height: 8,),
                Text('Error al iniciar sesión', style: TextStyle(color: AppColors.contrastColor, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
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
                    Text(msg, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 12,),
              Text("Código de error: $statusCode", style: const TextStyle(fontSize: 12, color: AppColors.secondaryColor),)
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
                _isLoggingIn = false;
              },
            ),
          ],
        );
      },
    );
  }

 Widget whatsAppWork(){
    const String phoneNumber = '593995603471'; // Reemplaza con el número de teléfono
    const String message = 'Hola, un gusto saludarte! Quisiera solicitar un trabajo, por favor.'; // Reemplaza con tu mensaje
    final whatsappUrl = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';

    return Link(
      uri: Uri.parse(whatsappUrl),
      target: LinkTarget.self,
      builder: (context, followLink) => TextButton(
        onPressed: followLink,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(SocialMediaIcons.whatsapp, color: Colors.white, size: 15,),
            SizedBox(width: 10,),
            Text('¿Necesitas un trabajo?', style: TextStyle(color: Colors.white, fontSize: 12),),
          ],
        )
      ),
    );
  }
}
