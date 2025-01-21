import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/data/homedata/quran_data.dart';
import 'package:quran/main.dart';

class ReadMoshafController extends GetxController {
  int currentPage = 0;
  late PageController pageController;
  late TextEditingController searchPage;
  int savedPage = -1;

  backToHomePage() {
    Get.offAllNamed(AppRoutesNames.home);
  }

  getCurrentPage(val) {
    currentPage = val;

    update();
  }

  goToNextPage() {
    currentPage++;
    if (currentPage > quranImages.length - 1) {
      Get.snackbar("الصفحة الأخيرة", "",
          backgroundColor: AppColors.borderColorGreen,
          colorText: AppColors.textwhite,
          messageText: Text(
            "هذه اخر صفحة",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ));
    } else {
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  goToprefPage() {
    if (currentPage != 0) {
      currentPage--;
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {}
  }

  goToSpeceificPage() {
    if (int.parse(searchPage.text) <= quranImages.length &&
        int.parse(searchPage.text) > -1) {
      currentPage = (int.parse(searchPage.text) - 1);
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      Get.snackbar("خطأ", "",
          backgroundColor: AppColors.borderColorGreen,
          colorText: AppColors.textwhite,
          messageText: Text(
            "برجاء ادخل رقم مابين 1 و 604 :",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ));
    }
    update();
  }

  setFavourite() {
    sharedPreferences.setInt("page", currentPage);
    savedPage = currentPage;
    print(savedPage);
    Get.snackbar("تم الحفظ", "",
        backgroundColor: AppColors.borderColorGreen,
        colorText: AppColors.textwhite,
        messageText: Text(
          "تم حفظ الصفحة",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ));
    update();
  }

  openLastPage() {
    if (sharedPreferences.getInt("page") != null) {
      print("currebt :=> $currentPage");
      currentPage = sharedPreferences.getInt("page")!;
    } else {
      currentPage = 0;
    }
    update();
  }

  @override
  void onInit() {
    openLastPage();
    savedPage = currentPage;
    pageController = PageController(initialPage: currentPage);
    searchPage = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    searchPage.dispose();
    super.onClose();
  }
}
