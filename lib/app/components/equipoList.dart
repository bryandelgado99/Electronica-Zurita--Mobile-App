import 'package:flutter/material.dart';
import '../../models/Equipo.dart';
import 'app_colors.dart';

class EquipoListWidget extends StatelessWidget {
  final List<Equipo> equipos;

  const EquipoListWidget({super.key, required this.equipos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: equipos.length,
      itemBuilder: (context, index) {
        final equipo = equipos[index];
        // return ListTile(
        //   title: Text('ID: ${equipo.id}'),
        //   subtitle: Text('Orden: ${equipo.numOrden}\nEquipo: ${equipo.equipo}\nModelo: ${equipo.modelo}\nMarca: ${equipo.marca}\nSerie: ${equipo.serie}\nColor: ${equipo.color}\nIngreso: ${equipo.ingreso}\nRazon: ${equipo.razon}\nSalida: ${equipo.salida}\nServicio: ${equipo.servicio}\nEstado: ${equipo.estado}\nCliente: ${equipo.cliente.id}'),
        // );

        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Orden Nro. ${equipo.numOrden}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Modelo: ${equipo.modelo}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  'Número de Serie: ${equipo.serie}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Marca: ${equipo.marca}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fecha de ingreso: ${equipo.ingreso}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Tipo de Servicio: ',
                      style: TextStyle(fontSize: 16), // Estilo de la etiqueta
                    ),
                    Text(
                      equipo.servicio,
                      style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600), // Solo el texto del estado cambia de color
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Estado del Servicio: ',
                      style: TextStyle(fontSize: 16), // Estilo de la etiqueta
                    ),
                    Text(
                      equipo.estado,
                      style: const TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.w600), // Solo el texto del estado cambia de color
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Observaciones: ${equipo.razon}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
