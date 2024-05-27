import 'package:electronica_zurita/app/components/decorations/svgImage.dart';
import 'package:electronica_zurita/app/components/decorations/texts/widgetText.dart';
import 'package:flutter/material.dart';

class emptyView extends StatelessWidget {
  const emptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          svgImage(
            asset_url: "assets/vectors/undraw_no_data_re_kwbl.svg",
            semantic_label: 'Empty List',
            width: 150,
          ),
          SizedBox(height: 20),
          widgetText(
            text: "Parece que no todavía dispones de ordenes de trabajo en acción.",
            fontSize: 15,
            fontWeight: FontWeight.w100,
            color: Colors.grey,
            textAlign: TextAlign.center,
          ),
          Spacer(),

          Spacer(),
        ],
      ),
    );
  }
}
