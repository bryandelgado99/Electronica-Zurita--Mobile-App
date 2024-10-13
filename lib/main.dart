import 'package:electronica_zurita/app/views/onBoarding/onBoarding_Screen.dart';
import 'package:electronica_zurita/app/views/sidebar/HomeCompose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/ClienteProvider.dart';
import 'app/components/app_colors.dart';
import 'app/views/Login.dart';
import 'models/equiposProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showOnBoardScreen = prefs.getBool('showOnBoardScreen') ?? true;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ClienteProvider()..fetchClienteInfo(),
      ),
      ChangeNotifierProvider(
        create: (context) => EquipoProvider()..fetchEquipos(),
      ),
    ],
    child: MyApp(showOnBoardScreen: showOnBoardScreen),
  ));

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.contrastColor
    ..backgroundColor = Colors.white
    ..indicatorColor = AppColors.contrastColor
    ..textColor = AppColors.contrastColor
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  final bool showOnBoardScreen;

  const MyApp({super.key, required this.showOnBoardScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electrónica Zurita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        scaffoldBackgroundColor: AppColors.bgColor,
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Poppins',
          bodyColor: AppColors.textColor,
          displayColor: AppColors.textColor,
        ),
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColors.contrastColor),
      ),
      home: showOnBoardScreen ? const OnBoardScreen() : LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}