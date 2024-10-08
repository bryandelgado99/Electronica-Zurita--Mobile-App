import 'package:electronica_zurita/app/components/app_colors.dart';
import 'package:electronica_zurita/app/views/onBoarding/newPageElement.dart';
import 'package:electronica_zurita/app/views/onBoarding/pageElement.dart';
import 'package:electronica_zurita/utilities/navigator_rules.dart';
import 'package:flutter/material.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int _activePage = 0;

  final PageController _pageController = PageController();

  void _onNextPage() {
    if (_activePage < _views.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
    else {
      finishOnBoarding(context);
    }
  }


  List<Widget> get _views => [
    page_One(_onNextPage),
    page_Two(_onNextPage),
    pageOutlaw(_onNextPage),
    page_Three(_onNextPage),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _views.length,
            itemBuilder: (BuildContext context, int index) {
              return _views[index];
            },
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 50,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];

    for (var i = 0; i < _views.length; i++) {
      if (_activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return indicators;
  }

  Widget _indicatorsTrue(){
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 8,
      width: 42,
      margin: const EdgeInsets.only(right: 9),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: AppColors.primaryColor
      ),
    );
  }
  Widget _indicatorsFalse(){
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 9),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: AppColors.contrastColor
      ),
    );
  }

}

Widget page_One(VoidCallback onNextPage) {
  return pageElement(
    title: "Bienvenido a la aplicación de Electrónica Zurita",
    description: "Esta aplicación te ayudará en el proceso de visualizar los trabajos de tus equipos.",
    isSkipped: true,
    path: 'assets/images/electrician.png',
    onTab: onNextPage,
    color: AppColors.primaryColor,
  );
}

Widget page_Two(VoidCallback onNextPage) {
  return pageElement(
    title: "Visualiza el estado de tus equipos",
    description: "Enterate del proceso del servicio de tus equipos. Recibirás un correo electrónico cada que se actualice un trabajo.",
    isSkipped: true,
    path: "assets/images/mail.png",
    onTab: onNextPage,
    color: AppColors.secondaryColor,
  );
}

Widget pageOutlaw(VoidCallback onNextPage){
  return NewPageElement(
    title: "Mantente en contacto con nosotros",
    description: "Agrega nuestro nuevo widget a tu pantalla de inicio y mantente conectado con tu técnico de confianza.",
    isSkipped: true,
    path: "assets/images/homescreen.png",
    onTab: onNextPage,
    color: AppColors.primaryColor,
  );
}

Widget page_Three(VoidCallback onNextPage) {
  return pageElement(
    title: "Observa las proformas de reparación",
    description: "Conoce el presupuesto de las proformas de reparación de tus equipos, el tipo de repuestos y su precio.",
    isSkipped: false,
    path: "assets/images/undraw_Receipt_re_fre3.png",
    onTab: onNextPage,
    color: AppColors.secondaryColor,
  );
}
