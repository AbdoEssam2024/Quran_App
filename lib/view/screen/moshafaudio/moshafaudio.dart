import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/moshafaudio/moshafaudiocontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/functions/pop_func.dart';
import 'package:quran/view/widgets/corewidgets/pop_widget.dart';
import 'package:quran/view/widgets/corewidgets/searchbar.dart';
import 'package:quran/view/widgets/moshafaudiowidgets/moshaf_main_view/moshafaudioview.dart';

class MoshafAudio extends GetView<MoshafAudioController> {
  const MoshafAudio({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MoshafAudioController());
    return PopScopeWidget(
      func: (didpop, result) {
        popFunc(didpop, controller.gotoHome());
      },
      widget: Scaffold(
        backgroundColor: AppColors.splashMainBackGroundColor,
        body: Container(
            margin:
                EdgeInsets.symmetric(vertical: ScreenSize.screenHeight * 0.015),
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
                MoshafAudioStructure(),
              ],
            )),
      ),
    );
  }
}
