import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/variuosreading/variousreadingcontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/view/widgets/corewidgets/searchbar.dart';
import 'package:quran/view/widgets/variousreading/variousreadingview.dart';

class VariousReadingScreen extends GetView<VariousReadingController> {
  const VariousReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VariousReadingController());
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.splashMainBackGroundColor,
        body: Container(
            margin:
                EdgeInsets.symmetric(vertical: ScreenSize.screenHeight * 0.02),
            padding: EdgeInsets.all(5.sp),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchBar(
                        btnFunc: () {
                          controller.gotoHome();
                        },
                        func: (value) {
                          controller.checkSearch(value);
                          controller.searchmoshaf(value);
                        },
                      ),
                    ),
                  ],
                ),
                VariousReadingStructure(),
              ],
            )),
      ),
    );
  }
}
