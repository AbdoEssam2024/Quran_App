import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/homecontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/data/homedata/homecategories.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenSize.screenHeight * 0.31,
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppCategories.quranDepratments.length,
            itemBuilder: (context, index) =>
                HomeCategoriesItems(index: index)));
  }
}

class HomeCategoriesItems extends StatelessWidget {
  final int index;
  const HomeCategoriesItems({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return InkWell(
      onTap: () {
        controller.pageRoute(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 5.w),
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          color: AppColors.borderColorGreen,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: AppColors.bgColorLightGreen,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedOpacity(
                duration: Duration(seconds: 5),
                opacity: controller.sectionsImageShow,
                curve: Curves.easeInOut,
                child: SizedBox(
                  width: 150.w,
                  height: 130.h,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15.sp)),
                    child: Image.asset(
                      AppCategories.quranDepratments[index]['image'],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Text(
                AppCategories.quranDepratments[index]['name'],
                style: TextStyle(fontSize: 14.sp, color: AppColors.textBlack),
              )
            ],
          ),
        ),
      ),
    );
  }
}
