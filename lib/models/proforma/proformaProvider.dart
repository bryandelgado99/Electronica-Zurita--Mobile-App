import 'dart:convert';
import 'package:electronica_zurita/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'Proforma.dart';

class ProformaProvider {
  Future<Proforma?> fetchProformaByEquipoId(String equipoId) async {
    final response = await http.get(Uri.parse('$backend_URL/proformas/orden/$equipoId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (kDebugMode) {
        print(Proforma.fromJson(data));
      }
      return Proforma.fromJson(data);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load proforma');
    }
  }
}
