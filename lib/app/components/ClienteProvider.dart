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
    final String? clienteId = DataUser.clienteId;
    final String? token = DataUser.token;

    if (clienteId == null || token == null) {
      print('Error: clienteId o token están vacíos');
      isLoading = false;
      notifyListeners();
      return;
    }

    final String url = '$perfilCliente/$clienteId';
    print('Request URL: $url');
    print('Authorization: Bearer $token');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      isLoading = false;
      notifyListeners();
    }
  }
}
