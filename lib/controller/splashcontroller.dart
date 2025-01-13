import 'package:get/get.dart';
import 'package:quran/core/constant/routes/routesname.dart';

class SplashController extends GetxController {
  double imagePosition = 0.0;

  changeImagePosition() {
    imagePosition = 1.0;
    update();
  }

  gotoHomePage() {
    Get.offAllNamed(AppRoutesNames.home);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    changeImagePosition();
    super.onReady();
  }
}
