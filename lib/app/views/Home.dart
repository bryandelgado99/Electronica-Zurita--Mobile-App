import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:electronica_zurita/app/views/pages/listPage.dart';
import 'package:electronica_zurita/app/views/pages/profilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/app_colors.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  PageController _pageController = PageController();
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: buildNavBottom(),
        body: Column(
         children: [
            buildPageView(),
         ],
        ),
    );
  }

  Widget buildPageView(){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90,
      child: PageView(
        controller: _pageController,
        children: const [
          listPage(),
          profilePage()
        ],
        onPageChanged: (index){
          onpageChanged(index);
        },
      ),
    );
  }

  Widget buildNavBottom(){
    return CurvedNavigationBar(
      index: selectedPage,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: AppColors.contrastColor,
      color: AppColors.contrastColor,
      items: const [
        Icon(Icons.list_alt_rounded, color: AppColors.bgColor),
        Icon(Icons.person_rounded, color: AppColors.bgColor)
      ],
      onTap: (int index){
        _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
    );
  }

  onpageChanged(int index){
    setState(() {
      selectedPage = index;
    });
  }

}

