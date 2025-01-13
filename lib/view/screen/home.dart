import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/homecontroller.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/view/widgets/homewidgets/almoshafkamel.dart';
import 'package:quran/view/widgets/homewidgets/hometitle.dart';
import 'package:quran/view/widgets/homewidgets/homecategories.dart';
import 'package:quran/view/widgets/homewidgets/salahtiming.dart';
import 'package:quran/view/widgets/homewidgets/suwarname.dart';
import 'package:quran/view/widgets/homewidgets/tadabor.dart';
import 'package:quran/view/widgets/homewidgets/variousreading.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.splashMainBackGroundColor,
        body: GetBuilder<HomeController>(
            builder: (controller) => Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: ListView(
                    children: [
                      HomeSectionHeader(
                        text: "مواعيد الصلاة",
                      ),
                      SalahTimingWidget(),
                      Divider(
                        thickness: 2.h,
                        height: 20.h,
                      ),
                      HomeSectionHeader(
                        text: "الأقسام",
                      ),
                      HomeCategoriesSection(),
                      Divider(
                        thickness: 2.h,
                        height: 20.h,
                      ),
                      HomeSectionHeader(
                        text: "المصحف الكامل",
                        widget: ShowMoreBtn(
                          func: () {
                            Get.offNamed(AppRoutesNames.moshafAudio);
                          },
                        ),
                      ),
                      AlmoshafKamelItems(),
                      Divider(
                        thickness: 2.h,
                        height: 20.h,
                      ),
                      HomeSectionHeader(
                        text: "اسماء السور",
                        widget: ShowMoreBtn(func: () {
                          Get.offNamed(AppRoutesNames.suwarname);
                        }),
                      ),
                      SuwarNames(),
                      Divider(
                        thickness: 2.h,
                        height: 20.h,
                      ),
                      HomeSectionHeader(
                        text: "تدبر القرآن",
                        widget: ShowMoreBtn(func: () {
                          Get.offNamed(AppRoutesNames.tadaborScreen);
                        }),
                      ),
                      TadaborSection(),
                      Divider(
                        thickness: 2.h,
                        height: 20.h,
                      ),
                      HomeSectionHeader(
                        text: "قراءات متنوعة",
                        widget: ShowMoreBtn(func: () {
                          Get.offNamed(AppRoutesNames.variousreading);
                        }),
                      ),
                      VariousReadingWidgets(),
                      Divider(
                        thickness: 2.h,
                        height: 20.h,
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
