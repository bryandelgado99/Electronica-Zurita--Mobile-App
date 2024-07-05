import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/link.dart';

class socialButtons extends StatefulWidget {
  const socialButtons({super.key});

  @override
  State<socialButtons> createState() => _socialButtonsState();
}

class _socialButtonsState extends State<socialButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Siguenos en: "),
        instaLink(),
        faceLink()
      ],
    );
  }
}

Widget instaLink() {
  final Uri url = Uri.parse('https://www.instagram.com/electronica_zurita.uio?igsh=bW5weHJlMDJ2cnJ2');

  return Link(
    uri: url,
    target: LinkTarget.blank,
    builder: (BuildContext ctx, FollowLink? followLink) {
      return IconButton(
        icon: Icon(SocialMediaIcons.instagram, color: AppColors.primaryColor, size: 30,),
        onPressed: followLink,
      );
    },
  );
}

Widget faceLink() {
  final Uri url = Uri.parse('https://www.facebook.com/profile.php?id=100083414747442');

  return Link(
    uri: url,
    target: LinkTarget.blank,
    builder: (BuildContext ctx, FollowLink? followLink) {
      return IconButton(
        icon: Icon(SocialMediaIcons.facebook, color: AppColors.primaryColor, size: 30,),
        onPressed: followLink,
      );
    },
  );
}