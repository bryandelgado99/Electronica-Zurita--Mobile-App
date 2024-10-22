import 'package:electronica_zurita/app/views/pages/listPage.dart';
import 'package:flutter/material.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({super.key, required this.title});

  final String title;

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {

  double xOffeset = 0;
  double yOffset = 0;
  double borderRound = 0;

  bool isSideMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: ListPage(),
      ),
    );
  }
}
