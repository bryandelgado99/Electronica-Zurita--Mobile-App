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
    var list = json['piezas'] as List<dynamic>?;
    List<Piezas> piezasList = list != null ? list.map((i) => Piezas.fromJson(i)).toList() : [];

    return Proforma(
      id: json['_id'],
      ordenId: json['ordenId'],
      aceptado: json['aceptado'],
      piezas: piezasList,
      precioTotal: json['precioTotal'].toDouble(),
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
}