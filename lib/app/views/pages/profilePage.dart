import 'package:electronica_zurita/app/components/commonButtons.dart';
import 'package:electronica_zurita/app/components/decorations/svgImage.dart';
import 'package:electronica_zurita/app/components/headerPartials.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../components/app_colors.dart';
import '../../components/ClienteInfo.dart';

class profilePage extends StatefulWidget {
  final token;
  const profilePage({super.key, this.token});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {

  late int cedula;
  late String password;
  late String nombre;
  late int telefono;
  late String direccion;
  late String correo;

  @override
  void initState(){
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    cedula = jwtDecodedToken['cedula'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const headerPartials(titleHeader: "Perfil"),
          const SizedBox(height: 30,),
          // User profile
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const svgImage(asset_url: 'assets/vectors/undraw_male_avatar_g98d.svg', semantic_label: 'User', width: 100),
                const SizedBox(width: 50,),
                Center(child: Column(
                  children: [
                    const Text("Bienvenido/a", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                    Text("$nombre!", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                  ],
                )),
              ],
            ),
          ),
          const Spacer(),
         ClienteInfo(
              nombreCliente: nombre,
              cedulaCliente: cedula.toString(),
              direccionCliente: direccion,
              telefonoCliente: telefono.toString(),
              correoCliente: correo
          ),
          const Spacer(),
          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: commonButton(
                icon: Icons.logout_rounded,
                text: "Cerrar Sesión",
                onPressed: (){
                  SystemNavigator.pop();
                },
                color_btn: AppColors.secondaryColor,
                font_color: AppColors.bgColor,
                color_icon: AppColors.bgColor
            ),
          ),
          const SizedBox(height: 10,),
          const Text("Version: 1.0.0", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.grey), textAlign: TextAlign.right,),
          const SizedBox(height: 35,),
        ],
      ),
    );
  }
}
