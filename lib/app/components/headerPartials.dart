// ignore_for_file: camel_case_types

import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_icons.dart';
import 'package:url_launcher/link.dart';

class headerPartials extends StatelessWidget implements PreferredSizeWidget {
  const headerPartials({super.key});

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.contrastColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
      child: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/logo_bn@2x.png', width: 60),
                const Spacer(),
                whatsAppWork()
              ],
          ),
        ],
      ),
  );

  Widget whatsAppWork() {
    const String phoneNumber = '593995603471'; // Reemplaza con el número de teléfono
    const String message = 'Hola, un gusto saludarte! Quisiera solicitar un trabajo, por favor.'; // Reemplaza con tu mensaje
    final whatsappUrl = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';

    return Link(
      uri: Uri.parse(whatsappUrl),
      target: LinkTarget.self,
      builder: (context, followLink) => IconButton(
        onPressed: followLink,
        icon: const Icon(
          SocialMediaIcons.whatsapp, // Icono de WhatsApp
          color: Colors.white,
          size: 28,
        ),// Color de fondo del botón
      ),
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32); // Altura del AppBar más el padding
}
