// ignore_for_file: camel_case_types

import 'package:electronica_zurita/app/components/social_Buttons.dart';
import 'package:electronica_zurita/app/views/pages/privacy-polit.dart';
import 'package:electronica_zurita/app/views/pages/terms-conditions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/ClienteProvider.dart';
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
          SingleChildScrollView(
            child: Column(
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
                const SizedBox(height: 25,),
                ClienteInfo(
                  nombreCliente: clienteProvider.nombreCliente ?? '',
                  cedulaCliente: clienteProvider.cedulaCliente ?? '',
                  direccionCliente: clienteProvider.direccionCliente ?? '',
                  telefonoCliente: clienteProvider.telefonoCliente ?? '',
                  correoCliente: clienteProvider.correoCliente ?? '',
                  frecuente: clienteProvider.frecuente ?? false,
                ),
                const SizedBox(height: 25,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                ),
                socialButtons(),
                const SizedBox(height: 6,),
                // Botones de términos y condiciones
                TextButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return TermsConditions();
                        },
                      );
                    },
                    child: Text("Términos y Condiciones")
                ),
                TextButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Privacypolit();
                        },
                      );
                    },
                    child: Text("Políticas de Privacidad")
                ),
                const SizedBox(height: 15,),
                const Text("Version: 1.0.1 + 1", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.grey), textAlign: TextAlign.right,),
              ],
            ),
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
