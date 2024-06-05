// ignore_for_file: camel_case_types
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/link.dart';
import '../../../models/equiposProvider.dart';
import '../../components/decorations/svgImage.dart';
import '../../components/headerPartials.dart';
import '../../components/workCard.dart';

class listPage extends StatefulWidget {
  const listPage({super.key});

  @override
  State<listPage> createState() => _listPageState();
}

class _listPageState extends State<listPage> with AutomaticKeepAliveClientMixin<listPage> {
  final GlobalKey<AnimatedFloatingActionButtonState> key =GlobalKey<AnimatedFloatingActionButtonState>();
  final List<String> estados = ['Pendiente', 'En proceso', 'Finalizado'];
  final List<String> tiposServicio = ['Mantenimiento', 'Reparación', 'Revisión'];
  final List<IconData> iconos = [Icons.pending, Icons.work, Icons.check_circle];
  final List<Componente> componentesEjemplo = [
    Componente(nombre: 'Pantalla', precio: 150.0),
    Componente(nombre: 'Batería', precio: 50.0),
    Componente(nombre: 'Cargador', precio: 25.0),
  ];

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
    final equiposFiltrados = equipoProvider.equipos.where((equipo) {
      final matchesEstado = selectedEstado == null || equipo.estado == selectedEstado;
      return matchesEstado;
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          const headerPartials(titleHeader: "Tus Equipos"),
          Expanded(
            child: equipoProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : equiposFiltrados.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const svgImage(
                    asset_url: "assets/vectors/undraw_no_data_re_kwbl.svg",
                    semantic_label: 'Empty List',
                    width: 100,
                  ),
                  const SizedBox(height: 15),
                  Text('No tienes equipos $selectedEstado', textAlign: TextAlign.center),
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
                    if (index == 0 || equipo.servicio != equiposFiltrados[index - 1].servicio) // Mostrar encabezado si es el primer elemento o si el servicio es diferente al anterior
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          equipo.servicio.toUpperCase(), // Mostrar el tipo de servicio como encabezado de la sección
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.contrastColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    EquipoCard(
                      equipo: equipo,
                      componentes: componentesEjemplo,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        //Fab list
          fabButtons: <Widget>[
            filterButton(), whatsAppWork()
          ],
          key : key,
          colorStartAnimation: AppColors.contrastColor,
          colorEndAnimation: AppColors.secondaryColor,
          animatedIconData: AnimatedIcons.menu_close
          //To principal button
      ),
    );
  }

  Widget filterButton(){
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return _buildFilterSheet();
          },
        );
      },
      backgroundColor: AppColors.contrastColor,
      foregroundColor: Colors.white,
      child: const Icon(Icons.filter_list_outlined),
    );
  }

  Widget _buildFilterSheet() {
    // Agregamos "Todos" al principio de la lista de estados
    final List<String> estadosConTodos = ['Todos', ...estados];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Filtrar por', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Estado del Servicio', labelStyle: TextStyle(color: Colors.white70)),
            value: selectedEstado,
            items: estadosConTodos.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: Colors.black),),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                // Si se selecciona "Todos", establecemos selectedEstado en null
                selectedEstado = value == 'Todos' ? null : value;
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Aplicamos el filtro
              Navigator.pop(context);
            },
            child: const Text('Aplicar Filtros'),
          ),
        ],
      ),
    );
  }

  Widget whatsAppWork() {
    const String phoneNumber = '593995603471'; // Reemplaza con el número de teléfono
    const String message = 'Hola, un gusto saludarte! Quisiera solicitar un trabajo, por favor.'; // Reemplaza con tu mensaje
    final whatsappUrl = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';

    return Link(
      uri: Uri.parse(whatsappUrl),
      target: LinkTarget.self,
      builder: (context, followLink) => FloatingActionButton(
        onPressed: followLink,
        backgroundColor: AppColors.accentColor, // Color de fondo del botón
        child: const Icon(
          SocialMediaIcons.whatsapp, // Icono de WhatsApp
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
