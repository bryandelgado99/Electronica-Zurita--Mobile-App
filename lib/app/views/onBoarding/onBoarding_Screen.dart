import 'package:electronica_zurita/app/components/app_colors.dart';
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
        duration: Duration(milliseconds: 300),
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
            top: MediaQuery.of(context).size.height/1.75,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                  children: _buildIndicator(),
                  mainAxisAlignment: MainAxisAlignment.center,
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
      duration: Duration(microseconds: 300),
      height: 8,
      width: 42,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white
      ),
    );
  }
  Widget _indicatorsFalse(){
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.grey
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

Widget page_Three(VoidCallback onNextPage) {
  return pageElement(
    title: "Observa las proformas de reparación",
    description: "Conoce el presupuesto de las proformas de reparación de tus equipos, el tipo de repuestos y su precio.",
    isSkipped: false,
    path: "assets/images/undraw_Receipt_re_fre3.png",
    onTab: onNextPage,
    color: AppColors.contrastColor,
  );
}