import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  @override
  Widget build(BuildContext context) {
    return  CurvedNavigationBar(
      index: 0,
      backgroundColor: Colors.transparent,
      color: AppColors.contrastColor,
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        Icon(Icons.list_alt_rounded, color: AppColors.bgColor,),
        Icon(Icons.person_rounded, color: AppColors.bgColor,)
      ],
    );
  }
}
