import 'dart:convert';

import 'package:electronica_zurita/models/Equipo.dart';
import 'package:electronica_zurita/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dataUser.dart';

class EquipoProvider with ChangeNotifier {
  List<Equipo> _equipos = [];
  bool isLoading = true;
  int _selectedIndex = 0;

  List<Equipo> get equipos => _equipos;
  int get selectedIndex => _selectedIndex;

  void setEquipos(List<Equipo> nuevosEquipos) {
    _equipos = nuevosEquipos;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void agregarNuevoEquipo(Equipo nuevoEquipo) {
    _equipos.add(nuevoEquipo);
    notifyListeners();
  }

  Future<void> fetchEquipos() async {
    final String token = DataUser.token;

    const String url = '${backend_URL}ordenes/listar';
    print(url);// Reemplaza con tu URL del backend

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Mapear los datos a objetos Equipo
        List<Equipo> equiposFiltrados = data
            .map((e) => Equipo.fromJson(e))
            .where((equipo) => equipo.cliente.id == DataUser.clienteId)
            .toList();

        // Imprimir datos obtenidos
        equiposFiltrados.forEach((equipo) {
          print('ID: ${equipo.id}, Orden: ${equipo.numOrden}, Equipo: ${equipo.equipo}, Modelo: ${equipo.modelo}, Marca: ${equipo.marca}, Serie: ${equipo.serie}, Color: ${equipo.color}, Ingreso: ${equipo.ingreso}, Razon: ${equipo.razon}, Salida: ${equipo.salida}, Servicio: ${equipo.servicio}, Estado: ${equipo.estado}, Cliente: ${equipo.cliente.id}');
        });

        setEquipos(equiposFiltrados);
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
