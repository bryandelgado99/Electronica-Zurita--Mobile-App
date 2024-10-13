import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:electronica_zurita/app/components/articRow.dart';
import 'package:electronica_zurita/app/components/articSwitch.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../../../models/ClienteProvider.dart';

class Sidebarcompose extends StatefulWidget {
  final Function(int) onItemSelected;

  const Sidebarcompose({super.key, required this.onItemSelected});

  @override
  State<Sidebarcompose> createState() => _SidebarcomposeState();
}

class _SidebarcomposeState extends State<Sidebarcompose> {
  // Mantener el índice seleccionado como parte del estado del Sidebar
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.contrastColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Row(
          children: [
            Expanded(
              flex: 7, // 60% del espacio total
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  headerComponent(),
                  redirectsCompose(), // No se necesita pasar onItemSelected aquí
                  actionsCompose(),
                ],
              ),
            ),
            Expanded(
              flex: 3, // 40% del espacio total
              child: Container(
                child: const Center(
                  child: Text(""),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerComponent() {
    final clienteProvider = Provider.of<ClienteProvider>(context);
    DateTime today = DateTime.now();
    initializeDateFormatting('es');
    String timestamp = DateFormat.yMMMMd('es').format(today);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            width: 120,
            fit: BoxFit.contain,
            image: AssetImage('assets/images/logo_bn@2x.png'),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Bienvenido/a, ${clienteProvider.nombreCliente ?? '...'}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 12),
        Text(
          "Fecha: $timestamp",
          style: TextStyle(color: Colors.white, fontSize: 12),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  // Elimina la necesidad de pasar una función como parámetro aquí
  Widget redirectsCompose() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        articRow(
          icon: Icons.home_rounded,
          text: "Inicio",
          trail_icon: Icons.arrow_forward_ios_rounded,
          isSelected: selectedIndex == 0, // Comprobar si está seleccionado
          onPressed: () {
            setState(() {
              selectedIndex = 0; // Actualizar el índice seleccionado
            });
            widget.onItemSelected(0); // Llamar a la función callback para notificar al padre
          },
        ),
        articRow(
          icon: Icons.supervised_user_circle_rounded,
          text: "Perfil",
          trail_icon: Icons.arrow_forward_ios_rounded,
          isSelected: selectedIndex == 1,
          onPressed: () {
            setState(() {
              selectedIndex = 1;
            });
            widget.onItemSelected(1);
          },
        ),
        articRow(
          icon: Icons.featured_play_list_rounded,
          text: "Ordenes de trabajo",
          trail_icon: Icons.arrow_forward_ios_rounded,
          isSelected: selectedIndex == 2,
          onPressed: () {
            setState(() {
              selectedIndex = 2;
            });
            widget.onItemSelected(2);
          },
        ),
        articRow(
          icon: Icons.newspaper_rounded,
          text: "Informes Técnicos",
          trail_icon: Icons.arrow_forward_ios_rounded,
          isSelected: selectedIndex == 3,
          onPressed: () {
            setState(() {
              selectedIndex = 3;
            });
            widget.onItemSelected(3);
          },
        ),
        articRow(
          icon: Icons.settings,
          text: "Ajustes",
          trail_icon: Icons.arrow_forward_ios_rounded,
          isSelected: selectedIndex == 4,
          onPressed: () {
            setState(() {
              selectedIndex = 4;
            });
            widget.onItemSelected(4);
          },
        ),
        ArticSwitch(),
      ],
    );
  }

  Widget actionsCompose() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.logout_rounded),
                  const SizedBox(width: 8),
                  Text("Cerrar Sesión"),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Text(
          "V 1.3.0",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}