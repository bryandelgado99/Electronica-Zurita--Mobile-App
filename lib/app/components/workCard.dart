// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/link.dart';
import '../../models/Equipo.dart';
import '../../models/proforma/Proforma.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

// Definición del widget EquipoCard
class EquipoCard extends StatefulWidget {
  final Equipo equipo;
  final List<Piezas> piezas;

  const EquipoCard({super.key, required this.equipo, required this.piezas});

  @override
  _EquipoCardState createState() => _EquipoCardState();
}

class _EquipoCardState extends State<EquipoCard> {

  @override
  Widget build(BuildContext context) {
    Color textColor;

    // Establecer el color del texto según el estado del servicio
    switch (widget.equipo.estado) {
      case 'Pendiente':
        textColor = AppColors.secondaryColor;
        break;
      case 'En proceso':
        textColor = AppColors.primaryColor;
        break;
      case 'Finalizado':
        textColor = AppColors.accentColor;
        break;
      default:
        textColor = Colors.black; // Color por defecto
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ExpansionTileCard(
        contentPadding: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(25),
        leading: const Icon(Icons.tv_rounded, color: AppColors.primaryColor),
        title: Text(
          'Orden Nro. ${widget.equipo.numOrden}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modelo: ${widget.equipo.modelo}'),
            Row(
              children: [
                const Text(
                  'Estado: ',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.equipo.estado,
                  style: TextStyle(fontSize: 13, color: textColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Número de Serie: ${widget.equipo.serie}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Marca: ${widget.equipo.marca}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fecha de ingreso: ${widget.equipo.ingreso}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Tipo de Servicio: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      widget.equipo.servicio,
                      style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Observaciones: ${widget.equipo.razon}',
                  style: const TextStyle(fontSize: 16),
                ),
                if (widget.equipo.servicio == 'Reparación' && widget.equipo.estado == 'Pendiente') ...[
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.contrastColor,
                      ),
                      onPressed: () {
                        //_mostrarProforma(context, widget.equipo);
                      },
                      child: const Text('Mostrar proforma'),
                    ),
                  ),
                ] else if (widget.equipo.servicio == 'Reparación' && widget.equipo.estado == 'En proceso') ...[
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.check_circle, color: AppColors.accentColor),
                            SizedBox(width: 10),
                            Text(
                              "Proforma Aceptada",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            //_showModalProform(context, widget.equipo, widget.componentes);
                          },
                          child: const Icon(Icons.newspaper_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
