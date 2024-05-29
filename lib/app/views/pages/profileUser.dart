import 'dart:convert';
import 'package:electronica_zurita/app/components/commonButtons.dart';
import 'package:electronica_zurita/app/components/decorations/svgImage.dart';
import 'package:electronica_zurita/app/components/headerPartials.dart';
import 'package:electronica_zurita/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/dataUser.dart';
import '../../components/app_colors.dart';
import '../../components/ClienteInfo.dart';
import 'package:http/http.dart' as http;

class profilePage extends StatefulWidget {
  const profilePage({super.key, required String token});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  String nombreCliente = '';
  String cedulaCliente = '';
  String direccionCliente = '';
  String telefonoCliente = '';
  String correoCliente = '';
  bool frecuente = false;

  @override
  void initState() {
    super.initState();

    // Asegúrate de que DataUser.token y DataUser.clienteId están configurados correctamente
    DataUser.token;
    DataUser.clienteId;
    print('Token: ${DataUser.token}');
    print('Cliente ID: ${DataUser.clienteId}');

    // Llama al método fetchClienteInfo para cargar los datos al iniciar
    fetchClienteInfo();
  }

  Future<void> fetchClienteInfo() async {
    // Asegúrate de que la URL esté correcta
    final String url = 'https://electronica-backend.onrender.com/api/cliente/${DataUser.clienteId}';
    final String token = DataUser.token;
    print('Request URL: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        nombreCliente = data['nombre'];
        cedulaCliente = data['cedula'].toString();
        direccionCliente = data['direccion'];
        telefonoCliente = data['telefono'].toString();
        correoCliente = data['correo'];
        frecuente = data['frecuente'];

      });
    } else {
      // Manejo de errores
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const svgImage(asset_url: 'assets/vectors/undraw_male_avatar_g98d.svg', semantic_label: 'User', width: 80),
                const SizedBox(width: 25,),
                Center(child: Column(
                  children: [
                    const Text("Bienvenido/a", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                    Text("$nombreCliente!", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)
                  ],
                )),
              ],
            ),
          ),
          const Spacer(),
          ClienteInfo(
            nombreCliente: nombreCliente,
            cedulaCliente: cedulaCliente,
            direccionCliente: direccionCliente,
            telefonoCliente: telefonoCliente,
            correoCliente: correoCliente,
            frecuente: frecuente,
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
          const Text("Version: 1.0.0", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.grey), textAlign: TextAlign.right,),
          const SizedBox(height: 15,),
        ],
      ),
    );
  }
}
