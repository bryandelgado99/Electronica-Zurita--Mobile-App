import 'package:electronica_zurita/app/views/sidebar/pages/InformesScreen.dart';
import 'package:flutter/material.dart';

import 'pages/HomeScreen.dart';
import 'pages/ListScreen.dart';
import 'pages/ProfileScreen.dart'; // Asegúrate de que el nombre de la clase esté correcto
import '../../components/app_colors.dart';

class Screenview extends StatefulWidget {
  final int selectedIndex;

  const Screenview({super.key, required this.selectedIndex});

  @override
  State<Screenview> createState() => _ScreenviewState();
}

class _ScreenviewState extends State<Screenview> {
  // Controladores para la animación de apertura del menú lateral
  double xOffset = 0;
  double yOffset = 0;
  double borderRound = 0;
  bool isSideMenuOpen = false;

  // Lista de títulos correspondientes a cada índice
  final List<String> titles = [
    "Inicio",
    "Perfil",
    "Ordenes de trabajo",
    "Informes Técnicos",
    "Ajustes"
  ];

  @override
  Widget build(BuildContext context) {
    // Selecciona la pantalla dependiendo del índice seleccionado
    Widget screen;
    switch (widget.selectedIndex) {
      case 0:
        screen = Homescreen(title: titles[0]);
        break;
      case 1:
        screen = Profilescreen(title: titles[1]);
        break;
      case 2:
        screen = Listscreen(title: titles[2]);
        break;
      case 3:
        screen = Informesscreen(title: titles[3]);
        break;
      default:
        screen = Center(child: Text('Selecciona una página'));
    }

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isSideMenuOpen ? 0.85 : 1.00),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRound)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 24.0,
            offset: Offset(-5, 24),
          )
        ],
      ),
      duration: Duration(milliseconds: 300),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: isSideMenuOpen
                ? GestureDetector(
              onTap: () {
                setState(() {
                  xOffset = 0;
                  yOffset = 0;
                  borderRound = 0;
                  isSideMenuOpen = false;
                });
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            )
                : GestureDetector(
              onTap: () {
                setState(() {
                  xOffset = 290;
                  yOffset = 150;
                  borderRound = 20;
                  isSideMenuOpen = true;
                });
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo_bn@2x.png', scale: 25),
                const SizedBox(width: 18),
                Text(
                  titles[widget.selectedIndex],
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          body: screen, // Se muestra la pantalla correspondiente
        ),
      ),
    );
  }
}