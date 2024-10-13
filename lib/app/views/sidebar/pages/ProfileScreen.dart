import 'package:electronica_zurita/app/views/pages/profileUser.dart';
import 'package:flutter/material.dart';
import '../../../../models/dataUser.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key, required this.title});
  
  final String title;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profilePage(token: DataUser.token),
    );
  }
}
