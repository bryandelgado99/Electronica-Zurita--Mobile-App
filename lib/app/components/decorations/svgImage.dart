// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

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
