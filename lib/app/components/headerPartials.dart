import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';

class headerPartials extends StatelessWidget {
  const headerPartials({super.key, required this.titleHeader});

  final String titleHeader;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Container(
        decoration: const BoxDecoration(
          color: AppColors.contrastColor,
          //borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/logo_bn@2x.png', width: 60),
                Text(titleHeader, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.bgColor),),
              ],
          ),
        ),
    ),
  );
}
