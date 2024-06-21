import 'dart:convert';
import 'package:electronica_zurita/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProformaProvider {

  Future<Proforma?> fetchProformaByEquipoId(String equipoId) async {
    final response = await http.get(Uri.parse('$backend_URL/proformas/orden/$equipoId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      try {
        final proforma = Proforma.fromJson(data);
        if (kDebugMode) {
          print('Datos recibidos: $data');
          print('Objeto Proforma: $proforma');
        }
        return proforma;
      } catch (e) {
        if (kDebugMode) {
          print('Error parsing Proforma: $e');
        }
        return null;
      }
    } else if (response.statusCode == 404) {
      if (kDebugMode) {
        print('No existe proforma para este equipo');
      }
      return null;
    } else {
      throw Exception('Failed to load proforma');
    }
  }
}

/*Clases: Proforma y piezas*/
class Piezas {
  String pieza;
  double precio;

  Piezas({required this.pieza, required this.precio});

  factory Piezas.fromJson(Map<String, dynamic> json) {
    return Piezas(
      pieza: json['pieza'] ?? '',
      precio: (json['precio'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pieza': pieza,
      'precio': precio,
    };
  }

  @override
  String toString() {
    return 'Pieza: $pieza, Precio: $precio';
  }
}

class Proforma {
  String id;
  String ordenId;
  bool aceptado;
  List<Piezas> piezas;
  double precioTotal;

  Proforma({
    required this.id,
    required this.ordenId,
    required this.aceptado,
    required this.piezas,
    required this.precioTotal,
  });

  factory Proforma.fromJson(Map<String, dynamic> json) {
    var list = json['proformas'][0]['piezas'] as List<dynamic>?;
    List<Piezas> piezasList = list != null ? list.map((i) => Piezas.fromJson(i)).toList() : [];

    return Proforma(
      id: json['proformas'][0]['_id'] ?? '',
      ordenId: json['proformas'][0]['ordenId'] ?? '',
      aceptado: json['proformas'][0]['aceptado'] ?? false,
      piezas: piezasList,
      precioTotal: (json['proformas'][0]['precioTotal'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'ordenId': ordenId,
      'aceptado': aceptado,
      'piezas': piezas.map((v) => v.toJson()).toList(),
      'precioTotal': precioTotal,
    };
  }

  @override
  String toString() {
    return 'Proforma(id: $id, ordenId: $ordenId, aceptado: $aceptado, piezas: $piezas, precioTotal: $precioTotal)';
  }
}