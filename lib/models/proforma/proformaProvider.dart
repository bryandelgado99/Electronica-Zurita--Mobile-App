import 'dart:convert';
import 'package:electronica_zurita/utilities/constants.dart';
import 'package:http/http.dart' as http;

import 'Proforma.dart';

class ProformaProvider {
  final String apiUrl = proforma;

  Future<Proforma?> fetchProformaByEquipoId(String equipoId) async {
    final response = await http.get(Uri.parse('$apiUrl/$equipoId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Proforma.fromJson(data);
    } else if (response.statusCode == 404) {
      return null;  // No se encontró la proforma
    } else {
      throw Exception('Failed to load proforma');
    }
  }
}