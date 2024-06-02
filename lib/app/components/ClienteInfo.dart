// ignore_for_file: file_names

import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';

class ClienteInfo extends StatelessWidget {
  final String nombreCliente;
  final String cedulaCliente;
  final String direccionCliente;
  final String telefonoCliente;
  final String correoCliente;
  final bool frecuente;

  const ClienteInfo(
    {
      super.key, 
      required this.nombreCliente,
      required this.cedulaCliente,
      required this.direccionCliente,
      required this.telefonoCliente,
      required this.correoCliente,
      required this.frecuente,
    }
  );


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClienteDetail('Nombre:', nombreCliente),
          _buildClienteDetail('Cédula:', cedulaCliente),
          _buildClienteDetail('Dirección:', direccionCliente),
          _buildClienteDetail('Teléfono:', '0$telefonoCliente'),
          _buildClienteDetail('Correo electrónico:', correoCliente),
          _buildClienteDetail('Frecuente:', frecuente ? "Sí" : "No"),
        ],
      ),
    );
  }

  Widget _buildClienteDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.contrastColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
