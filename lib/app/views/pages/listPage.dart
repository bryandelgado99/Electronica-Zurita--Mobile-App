// ignore_for_file: camel_case_types
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/Equipo.dart';
import '../../../models/equiposProvider.dart';
import '../../components/workCard.dart';

class listPage extends StatefulWidget {
  const listPage({super.key});

  @override
  State<listPage> createState() => _listPageState();
}

class _listPageState extends State<listPage>
    with AutomaticKeepAliveClientMixin<listPage> {
  final List<String> estados = ['Pendiente', 'En proceso', 'Finalizado'];
  final List<String> tiposServicio = ['Mantenimiento', 'Reparación', 'Revisión'];

  String? selectedTipoServicio;
  String? selectedEstado;

  @override
  void initState() {
    super.initState();
    Provider.of<EquipoProvider>(context, listen: false).fetchEquipos();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Llamar a super.build para mantener el estado

    final equipoProvider = Provider.of<EquipoProvider>(context);
    final List<Equipo> equipos = equipoProvider.equipos;

    // Filtrar equipos según el estado seleccionado
    final equiposFiltrados = equipos.where((equipo) {
      if (selectedEstado == null) return true; // Mostrar todos si no hay estado seleccionado
      return equipo.estado == selectedEstado;
    }).toList();

    // Verificar si no hay equipos en el estado seleccionado
    final bool noHayEquipos = equipos.isEmpty;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Provider.of<EquipoProvider>(context, listen: false)
                    .fetchEquipos();
              },
              child: equipoProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : equiposFiltrados.isEmpty
                  ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      'No tienes ordenes de trabajo para este estado',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: equiposFiltrados.length,
                itemBuilder: (context, index) {
                  final equipo = equiposFiltrados[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0 ||
                          equipo.servicio !=
                              equiposFiltrados[index - 1].servicio)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
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
                        piezas: const [],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
        ],
      ),
      floatingActionButton: noHayEquipos
          ? FloatingActionButton(
        onPressed: () async {
          await Provider.of<EquipoProvider>(context, listen: false)
              .fetchEquipos();
        },
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.refresh),
      )
          : null,
    );
  }

  @override
  bool get wantKeepAlive => true;
}