class Cliente {
  final String id;

  Cliente({
    required this.id,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['_id'],
    );
  }
}

class Equipo {
  final String id;
  final String numOrden;
  final String equipo;
  final String modelo;
  final String marca;
  final String serie;
  final String color;
  final String ingreso;
  final String razon;
  final String? salida;
  final String servicio;
  late final String estado;
  final Cliente cliente;

  Equipo({
    required this.id,
    required this.numOrden,
    required this.equipo,
    required this.modelo,
    required this.marca,
    required this.serie,
    required this.color,
    required this.ingreso,
    required this.razon,
    this.salida,
    required this.servicio,
    required this.estado,
    required this.cliente,
  });

  factory Equipo.fromJson(Map<String, dynamic> json) {
    return Equipo(
      id: json['_id'],
      numOrden: json['numOrden'],
      equipo: json['equipo'],
      modelo: json['modelo'],
      marca: json['marca'],
      serie: json['serie'],
      color: json['color'],
      ingreso: DateTime.parse(json['ingreso']).toString().substring(0, 10),
      razon: json['razon'],
      salida: json['salida'] != null ? DateTime.parse(json['salida']).toString().substring(0, 10) : null,
      servicio: json['servicio'],
      estado: json['estado'],
      cliente: Cliente.fromJson(json['cliente']),
    );
  }
}
