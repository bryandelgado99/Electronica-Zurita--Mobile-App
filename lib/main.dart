import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'app/components/ClienteProvider.dart';
import 'app/components/app_colors.dart';
import 'app/views/Login.dart';
import 'models/equiposProvider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ClienteProvider()..fetchClienteInfo(),
      ),
      ChangeNotifierProvider(
        create: (context) => EquipoProvider()..fetchEquipos(),
      ),
    ],
      child: const MyApp(),
    ),
  );
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
  const MyApp({super.key});

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
              displayColor: AppColors.textColor
          ),
          bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColors.contrastColor)
      ),
      home: LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
