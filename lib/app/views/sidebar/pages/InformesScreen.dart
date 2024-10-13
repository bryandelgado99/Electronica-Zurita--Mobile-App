import 'package:flutter/material.dart';

class Informesscreen extends StatefulWidget {
  const Informesscreen({super.key, required this.title});

  final String title;

  @override
  State<Informesscreen> createState() => _InformesscreenState();
}

class _InformesscreenState extends State<Informesscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("No tienes informes técnicos"),
      ),
    );
  }
}
