// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../../models/Equipo.dart';
import '../../models/proforma/Proforma.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

// Definición de la clase Componente
class Componente {
  final String nombre;
  final double precio;
  final bool estado_proforma = false;

  Componente({required this.nombre, required this.precio});
}

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
        leading: const Icon(Icons.miscellaneous_services, color: AppColors.primaryColor),
        title: Text(
          'Orden Nro. ${widget.equipo.numOrden}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        subtitle: Text('Modelo: ${widget.equipo.modelo}'),
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
                Row(
                  children: [
                    const Text(
                      'Estado del Servicio: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      widget.equipo.estado,
                      style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w600),
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

  /*void _aceptarProforma() {
    setState(() {
      widget.equipo.estado = 'En proceso';
    });
  }*/

  void _rechazarProforma(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rechazar Proforma'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('¿Estás seguro de que quieres rechazar esta proforma?'),
              SizedBox(height: 20),
              Text(
                'Para más información o inconvenientes sobre esta proforma, contáctese con el técnico a través de WhatsApp.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Builder(
              builder: (BuildContext context) {
                return Link(
                  uri: Uri.parse('https://wa.me/593995603471?text=${Uri.encodeComponent('Buenas tardes, tengo una consulta sobre la proforma.')}'),
                  target: LinkTarget.blank,
                  builder: (BuildContext ctx, FollowLink? openLink) {
                    return TextButton(
                      onPressed: openLink,
                      child: const Text('Contactar vía WhatsApp'),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _mostrarProforma(BuildContext context, Equipo equipo, List<Piezas> piezas) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        double totalPrecio = piezas.fold(0, (sum, item) => sum + item.precio);

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
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
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Modelo: ${equipo.modelo}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Observaciones: ${equipo.razon}',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Repuestos:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
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
                      rows: piezas.map((pieza) {
                        return DataRow(cells: [
                          DataCell(Text(pieza.pieza)),
                          DataCell(Text('\$${pieza.precio.toStringAsFixed(2)}')),
                        ]);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Precio Total: \$${totalPrecio.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '¿Estás de acuerdo con esta proforma?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          // Aceptar proforma
                          Navigator.of(context).pop();
                        },
                        child: const Text("Sí"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          // Rechazar proforma
                          Navigator.of(context).pop();
                        },
                        child: const Text("No"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showModalProform(BuildContext context, Equipo equipo, List<Piezas> piezas) {
    double totalPrecio = piezas.fold(0, (sum, item) => sum + item.precio);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Orden Nro. ${equipo.numOrden}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Modelo: ${equipo.modelo}'),
                const SizedBox(height: 10),
                Text('Observaciones: ${equipo.razon}'),
                const SizedBox(height: 20),
                const Text('Repuestos:', style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.maxFinite, // Ajusta el ancho al máximo posible
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Precio')),
                    ],
                    rows: piezas.map((componente) {
                      return DataRow(cells: [
                        DataCell(Text(piezas as String)),
                        DataCell(Text('\$${componente.precio.toStringAsFixed(2)}')),
                      ]);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Precio Total: \$${totalPrecio.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cerrar"),
            ),
          ],
        );
      }
    );
  }


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
