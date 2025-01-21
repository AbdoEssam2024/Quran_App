import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/moshafaudio/moshafaudiosuwarcontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/functions/pop_func.dart';
import 'package:quran/model/coremodel/suwarelqareamodel.dart';
import 'package:quran/view/widgets/corewidgets/pop_widget.dart';
import 'package:quran/view/widgets/corewidgets/searchbar.dart';
import 'package:quran/view/widgets/moshafaudiowidgets/moshaf_sura_view/moshafaudiosura.dart';

class MoshafAudioSuwar extends GetView<MoshafAudioSuwarController> {
  const MoshafAudioSuwar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MoshafAudioSuwarController());
    return PopScopeWidget(
      func: (didpop, result) {
        popFunc(didpop, controller.goToMoshafAudio());
      },
      widget: Scaffold(
          backgroundColor: AppColors.splashMainBackGroundColor,
          body: Container(
              margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.015),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.screenWidth * 0.015),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: CustomSearchBar(
                          btnFunc: () {
                            controller.goToMoshafAudio();
                          },
                          func: (value) {
                            controller.checkSearch(value);
                            controller.searchsuwar(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  MoshafSuraText(
                      text: "القارئ : ${controller.qareaName}", size: 14.sp),
                  GetBuilder<MoshafAudioSuwarController>(
                      builder: (controller) => HandlingDataRequest(
                          statusRequest: controller.statusRequest,
                          widget: Container(
                            padding: EdgeInsets.all(5.sp),
                            height: ScreenSize.screenHeight * 0.8,
                            child: ListView.builder(
                                itemCount: controller.isSearch
                                    ? controller.searchResult.length
                                    : controller.qareaSwar.length,
                                itemBuilder: (context, index) => SuraCard(
                                      qareaSuwar: QareaSuwar.fromJson(
                                          controller.isSearch
                                              ? controller.searchResult[index]
                                              : controller.qareaSwar[index]),
                                      index: index,
                                    )),
                          )))
                ],
              ))),
    );
  }
}
