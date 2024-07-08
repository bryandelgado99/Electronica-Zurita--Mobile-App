// ignore_for_file: file_names

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../utilities/constants.dart';

class ClienteInfo extends StatelessWidget {
  final String nombreCliente;
  final String cedulaCliente;
  final String direccionCliente;
  final String telefonoCliente;
  final String correoCliente;
  final bool frecuente;

  const ClienteInfo(
    {
      super.key, 
      required this.nombreCliente,
      required this.cedulaCliente,
      required this.direccionCliente,
      required this.telefonoCliente,
      required this.correoCliente,
      required this.frecuente,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClienteDetail('Nombre:', nombreCliente),
          _buildClienteDetail('Cédula:', cedulaCliente),
          _buildClienteDetail('Dirección:', direccionCliente),
          _buildClienteDetail('Teléfono:', '0$telefonoCliente'),
          _buildCorreoElectronicoDetail('Correo electrónico:', correoCliente, context), // Modificado para incluir el botón de diálogo
          _buildClienteDetail('Frecuente:', frecuente ? "Sí" : "No"),
        ],
      ),
    );
  }

  Widget _buildClienteDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCorreoElectronicoDetail(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.key_rounded),
                    tooltip: "Cambiar contraseña",
                    onPressed: () {
                      _showCorreoDialog(context, value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCorreoDialog(BuildContext context, String correo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            ModalBarrier(
              color: Colors.black.withOpacity(0.3),
              dismissible: false,
            ),
            AlertDialog(
              title: Column(
                children: [
                  Icon(Icons.lock_clock_rounded, size: 25,),
                  const SizedBox(height: 8,),
                  Text('Cambiar contraseña'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Se te enviará un correo electrónico con un enlace para que puedas cambiar tu contraseña. \n\n Recuerda que el correo es válido por 5 minutos.', textAlign: TextAlign.justify,),
                ],
              ),
              actions: <Widget>[
                FilledButton(
                  onPressed: () {
                    // Lógica para enviar el correo electrónico
                    _recuperarContrasena(correo);
                    Navigator.of(context).pop();
                  },
                  child: Text('Enviar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _recuperarContrasena(String correo) async {
    Fluttertoast.showToast(
      msg: "Enviando correo...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
    );

    try {
      final response = await http.post(
        Uri.parse(reset_pwsd),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'correo': correo,
        }),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Correo enviado correctamente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        final responseBody = jsonDecode(response.body);
        String errorMessage = 'Error desconocido al enviar correo';

        if (responseBody.containsKey('msg')) {
          errorMessage = responseBody['msg'];
        }

        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error de red, por favor intenta de nuevo",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}