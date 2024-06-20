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

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        List<Equipo> equiposFiltrados = data
            .map((e) => Equipo.fromJson(e))
            .where((equipo) => equipo.cliente.id == DataUser.clienteId)
            .toList();

        setEquipos(equiposFiltrados);
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
