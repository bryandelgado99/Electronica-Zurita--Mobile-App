import 'dart:math';
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:electronica_zurita/models/dataUser.dart';
//import 'package:electronica_zurita/services/notification.services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/link.dart';
import '../../../models/Equipo.dart';
import '../../../models/equiposProvider.dart';
import '../../components/emptyView.dart';
import '../../components/headerPartials.dart';
import '../../components/workCard.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class listPage extends StatefulWidget {
  const listPage({super.key});

  @override
  State<listPage> createState() => _listPageState();
}

class _listPageState extends State<listPage> with AutomaticKeepAliveClientMixin<listPage> {
  final componentesEjemplo = [
    Componente(nombre: 'Pantalla', precio: 150.0),
    Componente(nombre: 'Batería', precio: 50.0),
    Componente(nombre: 'Cargador', precio: 25.0),
  ];

  final List<String> marcas = ['Marca A', 'Marca B', 'Marca C'];
  final List<String> tiposServicio = ['Reparación', 'Mantenimiento', 'Revisión'];
  final List<String> estados = ['Pendiente', 'En proceso', 'Finalizado'];
  final List<IconData> iconos = [Icons.pending, Icons.work, Icons.check_circle];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<EquipoProvider>(context, listen: false).fetchEquipos();
  }

@override
Widget build(BuildContext context) {
  super.build(context); // Llamar a super.build para mantener el estado

  final equipoProvider = Provider.of<EquipoProvider>(context);
  List<Equipo> equiposFiltrados = equipoProvider.equipos.where((equipo) => equipo.estado == estados[selectedIndex]).toList();

  return Scaffold(
    body: Column(
      children: [
        const headerPartials(titleHeader: "Tus Equipos"),
        buildSegmentedControl(equipoProvider),
        Expanded(
          child: equipoProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : equiposFiltrados.isEmpty
              ? const emptyView()
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GroupedListView<Equipo, String>(
              elements: equiposFiltrados,
              groupBy: (equipo) => equipo.servicio,
              groupSeparatorBuilder: (String groupByValue) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  groupByValue,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              itemBuilder: (context, equipo) => EquipoCard(equipo: equipo, componentes: componentesEjemplo),
              order: GroupedListOrder.ASC,
            ),
          ),
        ),
      ],
    ),
    //floatingActionButton: _testNotificationbtn(),
  );
}

  Widget buildSegmentedControl(EquipoProvider equipoProvider) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double buttonWidth = (constraints.maxWidth / estados.length) - 4;

          return ToggleButtons(
            isSelected: List.generate(estados.length, (index) => index == equipoProvider.selectedIndex),
            onPressed: (index) {
              equipoProvider.setSelectedIndex(index);
            },
            borderRadius: BorderRadius.circular(25),
            constraints: BoxConstraints.tightFor(width: buttonWidth),
            children: List.generate(estados.length, (index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(iconos[index], size: 18),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      estados[index],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
