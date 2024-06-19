// ignore_for_file: camel_case_types
import 'package:electronica_zurita/app/components/headerPartials.dart';
import 'package:electronica_zurita/app/views/pages/listPage.dart';
import 'package:electronica_zurita/app/views/pages/profileUser.dart';
import 'package:electronica_zurita/models/dataUser.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../models/equiposProvider.dart';
import '../components/app_colors.dart';
import '../components/workCard.dart';

class homeScreen extends StatefulWidget{
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();

}

class _homeScreenState extends State<homeScreen>{
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
      extendBody: false,
      appBar: const headerPartials(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: googleNavBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: buildPageView(equipoProvider),
            ),
          ),
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

  Widget googleNavBar(){
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.contrastColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
        child: GNav(
          selectedIndex: selectedPage,
          gap: 10,
          backgroundColor: AppColors.contrastColor,
          color: Colors.white54,
          activeColor: Colors.white,
          tabBackgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.all(15),
          tabs: const [
            GButton(icon: Icons.list_alt_rounded, text: "Equipos"),
            GButton(icon: Icons.person_rounded, text: "Perfil",)
          ],
          onTabChange: (int index){
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
          },
        )
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      selectedPage = index;
    });
  }
}
