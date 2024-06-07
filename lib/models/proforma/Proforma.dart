class Piezas {
  String pieza;
  double precio;
  String id;

  Piezas({required this.pieza, required this.precio, required this.id});

  factory Piezas.fromJson(Map<String, dynamic> json) {
    return Piezas(
      pieza: json['pieza'],
      precio: json['precio'].toDouble(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pieza': pieza,
      'precio': precio,
      '_id': id,
    };
  }
}

class Proforma {
  String id;
  bool aceptado;
  List<Piezas> piezas;
  double precioTotal;
  DateTime createdAt;
  DateTime updatedAt;

  Proforma({
    required this.id,
    required this.aceptado,
    required this.piezas,
    required this.precioTotal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Proforma.fromJson(Map<String, dynamic> json) {
    var list = json['piezas'] as List;
    List<Piezas> piezasList = list.map((i) => Piezas.fromJson(i)).toList();

    return Proforma(
      id: json['_id'],
      aceptado: json['aceptado'],
      piezas: piezasList,
      precioTotal: json['precioTotal'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'aceptado': aceptado,
      'piezas': piezas.map((v) => v.toJson()).toList(),
      'precioTotal': precioTotal,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}