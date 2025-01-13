import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/splashcontroller.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/constant/appimages/appimages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
        backgroundColor: AppColors.splashMainBackGroundColor,
        body: GetBuilder<SplashController>(
            builder: (controller) => Container(
                padding: EdgeInsets.all(10.sp),
                child: ListView(
                  children: [
                    AnimatedOpacity(
                      duration: Duration(seconds: 5),
                      opacity: controller.imagePosition,
                      curve: Curves.easeInOut,
                      child: SizedBox(
                        height: 350.h,
                        child: Image.asset(
                          AppImages.splash,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 60.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.sp),
                        border:
                            Border.all(color: AppColors.splashBtn, width: 2.w),
                      ),
                      child: MaterialButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 15.h),
                        onPressed: () {
                          controller.gotoHomePage();
                        },
                        child: Text(
                          "اقرا القرآن",
                          style: TextStyle(
                              color: AppColors.textwhite,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ))));
  }
}


// #001c27 = #002c2e = #004c3e //

// 0 28 39 = 0 44 46 = 0 76 62