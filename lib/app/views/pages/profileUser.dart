// ignore_for_file: camel_case_types

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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
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
