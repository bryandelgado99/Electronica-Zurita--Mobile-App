// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/link.dart';
import '../../models/Equipo.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import '../../models/proformaProvider.dart';

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
        textColor = Colors.black;
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
          style: const TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modelo: ${widget.equipo.modelo}'),
            Row(
              children: [
                const Text(
                  'Equipo: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.equipo.equipo,
                  style: const TextStyle(fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Estado: ',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.equipo.estado,
                  style: TextStyle(fontSize: 13,
                      color: textColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
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
                      style: const TextStyle(fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Observaciones: ${widget.equipo.razon}',
                  style: const TextStyle(fontSize: 16),
                ),
                if (widget.equipo.servicio == 'Reparación' &&
                    widget.equipo.estado == 'Pendiente') ...[
                  const SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.dangerous_rounded, color: AppColors.secondaryColor),
                          SizedBox(width: 10),
                          Text(
                            "Proforma pendiente",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else
                  if (widget.equipo.servicio == 'Reparación' &&
                      widget.equipo.estado == 'En proceso') ...[
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: AppColors.accentColor),
                              SizedBox(width: 10),
                              Text(
                                "Proforma Adjunta",
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
                              _mostrarProforma(context, widget.equipo);
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

  void _mostrarProforma(BuildContext context, Equipo equipo) async {
    // Hacer la petición para obtener la proforma
    ProformaProvider proformaProvider = ProformaProvider();
    Proforma? proforma = await proformaProvider.fetchProformaByEquipoId(
        equipo.id);

    if (proforma == null) {
      // Mostrar un mensaje de que no hay proforma disponible
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No existe proforma para este equipo',
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      );
      return;
    }

    // Mostrar la proforma en el modal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Orden Nro. ${equipo.numOrden}',
                      style: const TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Modelo: ${equipo.modelo}',
                    style: const TextStyle(fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Observaciones: ${equipo.razon}',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Repuestos:',
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Precio')),
                      ],
                      rows: proforma.piezas.map((pieza) {
                        return DataRow(cells: [
                          DataCell(Text(pieza.pieza)),
                          DataCell(
                              Text('\$${pieza.precio.toStringAsFixed(2)}')),
                        ]);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Precio Total: \$${proforma.precioTotal.toStringAsFixed(
                        2)}',
                    style: const TextStyle(fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                 ]
              ),
            ),
          ),
        );
      },
    );
  }
}
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
