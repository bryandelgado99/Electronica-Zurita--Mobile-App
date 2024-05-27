import 'dart:math';
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:electronica_zurita/services/notification.services.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/link.dart';
import '../../components/emptyView.dart';
import '../../components/headerPartials.dart';
import '../../components/workCard.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

// Definición del widget listPage
class listPage extends StatefulWidget {
  const listPage({super.key});

  @override
  State<listPage> createState() => _listPageState();
}

class _listPageState extends State<listPage> with AutomaticKeepAliveClientMixin<listPage> {
  // Lista de equipos
  List<Equipo> equipos = [

  ];

  final componentesEjemplo = [
    Componente(nombre: 'Pantalla', precio: 150.0),
    Componente(nombre: 'Batería', precio: 50.0),
    Componente(nombre: 'Cargador', precio: 25.0),
  ];

  // Lista de marcas, tipos de servicio y estados del servicio
  final List<String> marcas = ['Marca A', 'Marca B', 'Marca C'];
  final List<String> tiposServicio = ['Reparación', 'Mantenimiento', 'Revisión'];
  final List<String> estados = ['Pendiente', 'En proceso', 'Finalizado'];
  final List<IconData> iconos = [Icons.pending, Icons.work, Icons.check_circle];
  int selectedIndex = 0;


  void agregarNuevoEquipo() {
    final random = Random();
    var now = DateTime.now();
    final nuevoEquipo = Equipo(
      orden_trabajo: 'XXXXXXXX',
      modelo: 'Modelo ${equipos.length + 1}',
      numeroSerie: (random.nextInt(1000000) + 100000).toString(),
      marca: marcas[random.nextInt(marcas.length)],
      fechaIngreso: DateFormat().format(now).toString(),
      tipoServicio: tiposServicio[random.nextInt(tiposServicio.length)],
      estadoServicio: estados[random.nextInt(estados.length)],
      observaciones: 'Observación ${equipos.length + 1}',
    );

    setState(() {
      equipos.add(nuevoEquipo);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Llamar a super.build para mantener el estado
    List<Equipo> equiposFiltrados = equipos.where((equipo) => equipo.estadoServicio == estados[selectedIndex]).toList();

    return Scaffold(
      body: Column(
        children: [
          const headerPartials(titleHeader: "Tus Equipos"),
          buildSegmentedControl(),
          Expanded(
            child: equiposFiltrados.isEmpty
                ? const emptyView()
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GroupedListView<Equipo, String>(
                                elements: equiposFiltrados,
                                groupBy: (equipo) => equipo.tipoServicio,
                                groupSeparatorBuilder: (String groupByValue) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(groupByValue, textAlign: TextAlign.right, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                ),
                                itemBuilder: (context, equipo) => EquipoCard(equipo: equipo, componentes: componentesEjemplo,),
                                order: GroupedListOrder.ASC,
                              ),
                ),
          ),
        ],
      ),
      floatingActionButton: _testNotificationbtn()
      // (selectedIndex == 0 && equiposFiltrados.isEmpty)
      //     ? buildWhatsAppButton()
      //     : null,
    );
  }

  Widget _testNotificationbtn(){
    return FloatingActionButton(
        onPressed: (){
          agregarNuevoEquipo();
          showNotification();
        },
        child: const Icon(Icons.tv_rounded)
    );
  }

  Widget buildWhatsAppButton() {
    return Link(
      uri: Uri.parse('https://wa.me/593995603471'),
      builder: (BuildContext context, FollowLink? followLink) {
        return FloatingActionButton(
            onPressed: followLink ?? _showErrorDialog,
            backgroundColor: AppColors.accentColor,
            child: const Icon(SocialMediaIcons.whatsapp, color: Colors.white,)
        );
      },
    );
  }

  // Método para mostrar el diálogo de error
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Sin conexión a internet'),
          actions: <Widget>[
            TextButton(
              child: const Text('Entendido'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Método para construir el botón segmentado
  Widget buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double buttonWidth = (constraints.maxWidth / estados.length) - 4;

          return ToggleButtons(
            isSelected: List.generate(estados.length, (index) => index == selectedIndex),
            onPressed: (index) {
              setState(() {
                selectedIndex = index;
              });
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