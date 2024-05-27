// ignore_for_file: file_names
import 'package:electronica_zurita/app/components/commonButtons.dart';
import 'package:electronica_zurita/app/components/decorations/texts/widgetText.dart';
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';

class RestaurarPwsd extends StatefulWidget {
  const RestaurarPwsd({super.key});

  @override
  State<RestaurarPwsd> createState() => _RestaurarPwsdState();
}

class _RestaurarPwsdState extends State<RestaurarPwsd> {

  TextEditingController recpassController= TextEditingController();
  final _recpass = GlobalKey<FormState>();

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
              const widgetText(text: "Recuperar Contraseña", fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white, textAlign: TextAlign.start),
              const SizedBox(height: 20,),
              const widgetText(
                  text: "Por favor ingresa tu número de cédula, si te encuentras registrado, para poder recibir un correo con el enlace de recuperación.",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  textAlign: TextAlign.center),
              const SizedBox(height: 28,),
              Form(
                key: _recpass,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: recpassController,
                  decoration: const InputDecoration(
                    labelText: "Cédula o RUC",
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white, width: 3.0),
                    ),
                  ),
                  validator: (ruc){
                    if(ruc!.isEmpty){
                      return "Campo obligatorio";
                    }
                    if(ruc != '1750629980'){
                      return "Cédula/RUC incorrectos";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
              commonButton(
                icon: Icons.mail_rounded,
                color_icon: AppColors.primaryColor,
                text:"Obtener correo",
                onPressed: (){
                  if (_recpass.currentState!.validate()) {
                   print("Correo Enviado");
                  }
                },
                color_btn: AppColors.bgColor,
                font_color: AppColors.primaryColor,)
            ],
           ),
         ),
     ),
   );
  }
}
