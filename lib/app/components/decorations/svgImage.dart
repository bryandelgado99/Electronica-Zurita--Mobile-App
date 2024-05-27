import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class svgImage extends StatelessWidget {
  const svgImage({super.key, required this.asset_url, required this.semantic_label, required this.width});

  final String asset_url;
  final String semantic_label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(asset_url, semanticsLabel: semantic_label, width: width);
  }
}
