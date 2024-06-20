import 'package:flutter/material.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset('assets/images/page-turner.png', width: 125),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: 125),
                  const SizedBox(height: 15),
                  const Text(
                    "Electrónica Zurita",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  const SizedBox(height: 55),
                  const Text(
                    "¡Gracias por confiar en nosotros!",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
