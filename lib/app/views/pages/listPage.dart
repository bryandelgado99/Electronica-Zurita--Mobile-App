// ignore_for_file: camel_case_types
import 'package:electronica_zurita/app/components/ClienteInfo.dart';
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:electronica_zurita/models/ClienteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/Equipo.dart';
import '../../../models/equiposProvider.dart';
import '../../components/workCard.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with AutomaticKeepAliveClientMixin<ListPage> {
  final List<String> estados = ['Pendiente', 'En proceso', 'Finalizado'];
  final List<String> tiposServicio = ['Mantenimiento', 'Reparación', 'Revisión'];

  String? selectedTipoServicio;
  String? selectedEstado;

  @override
  void initState() {
    super.initState();
    Provider.of<EquipoProvider>(context, listen: false).fetchEquipos();
    Provider.of<ClienteProvider>(context, listen: false).fetchClienteInfo(); // Asegúrate de que los datos del cliente se obtengan
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Llamar a super.build para mantener el estado

    final equipoProvider = Provider.of<EquipoProvider>(context);
    final clienteProvider = Provider.of<ClienteProvider>(context);
    final List<Equipo> equipos = equipoProvider.equipos;

    // Filtrar equipos según el estado seleccionado
    final equiposFiltrados = equipos.where((equipo) {
      if (selectedEstado == null) return true; // Mostrar todos si no hay estado seleccionado
      return equipo.estado == selectedEstado;
    }).toList();

    // Ordenar equipos por tipo de servicio
    equiposFiltrados.sort((a, b) => a.servicio.compareTo(b.servicio));

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Provider.of<EquipoProvider>(context, listen: false).fetchEquipos();
                await Provider.of<ClienteProvider>(context, listen: false).fetchClienteInfo();
              },
              child: equipoProvider.isLoading || clienteProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : equiposFiltrados.isEmpty
                  ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No tienes ordenes de trabajo para este estado.',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Desliza para actualizar tu lista de equipos.",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : ListView.builder(
                itemCount: equiposFiltrados.length,
                itemBuilder: (context, index) {
                  final equipo = equiposFiltrados[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0 ||
                          equipo.servicio != equiposFiltrados[index - 1].servicio)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            equipo.servicio.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.contrastColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      EquipoCard(
                        equipo: equipo,
                        piezas: const [], // Suponiendo que tienes una lista de piezas, pásala aquí
                        cliente: ClienteInfo(
                          nombreCliente: clienteProvider.nombreCliente ?? 'No disponible',
                          cedulaCliente: clienteProvider.cedulaCliente ?? 'No disponible',
                          direccionCliente: clienteProvider.direccionCliente ?? 'No disponible',
                          telefonoCliente: clienteProvider.telefonoCliente ?? 'No disponible',
                          correoCliente: clienteProvider.correoCliente ?? 'No disponible',
                          frecuente: false,
                          // otros campos del cliente aquí
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 10.0,
                children: estados.map((estado) {
                  return FilterChip(
                    label: Text(estado),
                    selected: selectedEstado == estado,
                    onSelected: (isSelected) {
                      setState(() {
                        selectedEstado = isSelected ? estado : null;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}