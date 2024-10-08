import 'package:electronica_zurita/app/components/ClienteInfo.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_icons.dart';
import 'package:url_launcher/link.dart';

import '../../models/Equipo.dart';

class Whatslink extends StatelessWidget {
  final ClienteInfo cliente;
  final Equipo equipo;

  const Whatslink({
    super.key,
    required this.cliente,
    required this.equipo,
  });

  @override
  Widget build(BuildContext context) {
    const String phoneNumber = '593995603471';
    String message = 'Hola, buen día! Le saluda su cliente, ${cliente.nombreCliente}. Quisiera información sobre la proforma generada, para la orden Nro. ${equipo.numOrden} de mi equipo, por favor.';
    final Uri url = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');

    return Link(
      uri: url,
      target: LinkTarget.blank,
      builder: (BuildContext ctx, FollowLink? followLink) {
        return FilledButton(
          onPressed: followLink,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(SocialMediaIcons.whatsapp, color: Colors.white, size: 20,),
              SizedBox(width: 8,),
              Text("Servicio al Cliente")
            ],
          ),
        );
      },
    );
  }
}
