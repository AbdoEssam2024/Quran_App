import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/main.dart';

class SplashMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sharedPreferences!.getInt("visit") != null) {
      return RouteSettings(name: AppRoutesNames.home);
    }
    return super.redirect(route);
  }
}
