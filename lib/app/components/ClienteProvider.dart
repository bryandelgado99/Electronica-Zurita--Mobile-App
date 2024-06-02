// ignore_for_file: file_names
import 'dart:convert';
import 'package:electronica_zurita/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:electronica_zurita/models/dataUser.dart';
import 'package:flutter/material.dart';

class ClienteProvider with ChangeNotifier {
  String? nombreCliente;
  String? cedulaCliente;
  String? direccionCliente;
  String? telefonoCliente;
  String? correoCliente;
  bool? frecuente;
  bool isLoading = true;

  Future<void> fetchClienteInfo() async {
    final String clienteId = DataUser.clienteId;
    final String token = DataUser.token;

    final String url = '$perfilCliente/$clienteId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        nombreCliente = data['cliente']['nombre'] ?? 'No disponible';
        cedulaCliente = data['cliente']['cedula']?.toString() ?? 'No disponible';
        direccionCliente = data['cliente']['direccion'] ?? 'No disponible';
        telefonoCliente = data['cliente']['telefono']?.toString() ?? 'No disponible';
        correoCliente = data['cliente']['correo'] ?? 'No disponible';
        frecuente = data['cliente']['frecuente'] ?? false;
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}
