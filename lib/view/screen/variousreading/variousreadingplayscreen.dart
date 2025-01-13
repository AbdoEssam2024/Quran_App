import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/variuosreading/variousreadplayscreencontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/functions/audiofunctions.dart';
import 'package:quran/view/widgets/moshafaudiowidgets/playscreenwidgets.dart';

class VariousReadingPlayScreen
    extends GetView<VariousReadingPlayScreenController> {
  const VariousReadingPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VariousReadingPlayScreenController());
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: AppColors.splashMainBackGroundColor,
          body: Container(
            margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.08),
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenSize.screenHeight * 0.015,
                            horizontal: ScreenSize.screenWidth * 0.015),
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSize.screenHeight * 0.015),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          color: AppColors.bgColorLightGreen,
                        ),
                        child: GetBuilder<VariousReadingPlayScreenController>(
                          builder: (controller) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              StaticImage(),
                              PlayerAnimationImage(
                                  animation: controller.animation),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenSize.screenWidth * 0.015),
                                  alignment: Alignment.centerRight,
                                  height: ScreenSize.screenHeight * 0.11,
                                  child: AudioData(
                                      surah: controller.index != -1
                                          ? "سورة   : ${controller.suraName[controller.index]["name"]}"
                                          : "سورة   : ${controller.selectedSuraNameSearch}",
                                      qarea:
                                          "القارئ : ${controller.qareaName}")),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: ScreenSize.screenWidth * 0.015,
                                    vertical: ScreenSize.screenHeight * 0.02),
                                child: DurationSeekBarPosition(
                                    positionText: formatDuration(
                                        controller.almoshafKamelposition),
                                    durationText: formatDuration(
                                        controller.almoshafKamelduration),
                                    val: controller
                                        .almoshafKamelposition.inSeconds
                                        .toDouble(),
                                    maxval: controller
                                        .almoshafKamelduration.inSeconds
                                        .toDouble(),
                                    func: (val) {
                                      controller.seekAudioPosition(
                                          Duration(seconds: val.toInt()));
                                    }),
                              ),
                              PlayControllers(
                                  prevfunc: () {
                                    controller.prevsurah();
                                  },
                                  playfunc: () {
                                    controller.playAudio();
                                  },
                                  nextfunc: () {
                                    controller.nextsurah();
                                  },
                                  playicon: controller.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow_rounded)
                            ],
                          ),
                        )),
                    Positioned(
                      top: ScreenSize.screenHeight * 0.009,
                      left: ScreenSize.screenWidth * 0.009,
                      child: BackButtonWidget(
                          backFunc: () {
                            controller.goToSudioSuwar();
                          },
                          text: "Back"),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
