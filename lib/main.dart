import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quran/core/binding/initial_binding.dart';
import 'package:quran/core/constant/apptheme/apptheme.dart';
import 'package:quran/core/constant/routes/routes.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
            theme: AppTheme.arabicTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutesNames.splashScreen,
            getPages: AppRoutes.getpages,
            initialBinding: InitialBindings(),
          );
        });
  }
}
