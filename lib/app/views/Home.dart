import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:electronica_zurita/app/views/pages/listPage.dart';
import 'package:electronica_zurita/app/views/pages/profileUser.dart';
import 'package:electronica_zurita/models/dataUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/equiposProvider.dart';
import '../components/app_colors.dart';
import '../components/workCard.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final PageController _pageController = PageController();
  int selectedPage = 0;
  final List<Componente> componentesEjemplo = [
    Componente(nombre: 'Pantalla', precio: 150.0),
    Componente(nombre: 'Batería', precio: 50.0),
    Componente(nombre: 'Cargador', precio: 25.0),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<EquipoProvider>(context, listen: false).fetchEquipos();
  }

  @override
  Widget build(BuildContext context) {
    final equipoProvider = Provider.of<EquipoProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: buildNavBottom(),
      body: Column(
        children: [
          buildPageView(equipoProvider),
        ],
      ),
    );
  }

  Widget buildPageView(EquipoProvider equipoProvider) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90,
      child: PageView(
        controller: _pageController,
        children: [
          const listPage(), // Modificación aquí
          profilePage(token: DataUser.token), // Pasar el token a profilePage
        ],
        onPageChanged: (index) {
          onPageChanged(index);
        },
      ),
    );
  }

  Widget buildNavBottom() {
    return CurvedNavigationBar(
      index: selectedPage,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: AppColors.contrastColor,
      color: AppColors.contrastColor,
      items: const [
        Icon(Icons.list_alt_rounded, color: AppColors.bgColor),
        Icon(Icons.person_rounded, color: AppColors.bgColor),
      ],
      onTap: (int index) {
        _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
    );
  }

  void onPageChanged(int index) {
    setState(() {
      selectedPage = index;
    });
  }
}
