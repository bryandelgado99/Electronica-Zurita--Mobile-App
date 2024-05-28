class Usuario {
  final String correo;
  final String nombre;
  final String clienteId;

  Usuario({required this.correo, required this.nombre, required this.clienteId});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      clienteId: json['clienteId'] ?? '',
      correo: json['correo'] ?? '',
      nombre: json['nombre'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clienteId': clienteId,
      'correo': correo,
      'nombre': nombre,
    };
  }
}
