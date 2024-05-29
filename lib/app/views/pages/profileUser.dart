import 'package:electronica_zurita/app/components/commonButtons.dart';
import 'package:electronica_zurita/app/components/decorations/svgImage.dart';
import 'package:electronica_zurita/app/components/headerPartials.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
              const headerPartials(titleHeader: "Perfil"),
              const SizedBox(height: 30,),
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
                        Text("${clienteProvider.nombreCliente ?? 'Cargando...'}!", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)
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
          if (clienteProvider.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

