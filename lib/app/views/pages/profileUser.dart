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
            child: Center(
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
                        Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Icon(Icons.person_rounded, size: 50,),
                            )
                        ),
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
                  const socialButtons(),
                  const SizedBox(height: 6,),
                  // Botones de términos y condiciones
                  TextButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const TermsConditions();
                          },
                        );
                      },
                      child: const Text("Términos y Condiciones")
                  ),
                  TextButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Privacypolit();
                          },
                        );
                      },
                      child: const Text("Políticas de Privacidad")
                  ),
                ],
              ),
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
