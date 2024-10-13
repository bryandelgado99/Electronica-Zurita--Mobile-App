import 'package:electronica_zurita/app/views/sidebar/ScreenView.dart';
import 'package:electronica_zurita/app/views/sidebar/sidebarCompose.dart';
import 'package:flutter/material.dart';

class Homecompose extends StatefulWidget {
  const Homecompose({super.key});

  @override
  State<Homecompose> createState() => _HomecomposeState();
}

class _HomecomposeState extends State<Homecompose> {

  int _selectedIndex = 0;
  double xOffeset = 0;
  double yOffset = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Sidebarcompose(onItemSelected: _onItemSelected),
          Screenview(selectedIndex: _selectedIndex),
        ],
      ),
    );
  }
}
