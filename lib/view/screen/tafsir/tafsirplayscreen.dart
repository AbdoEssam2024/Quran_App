import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/tafsir/tafsirplayscreencontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/functions/audiofunctions.dart';
import 'package:quran/core/functions/pop_func.dart';
import 'package:quran/view/widgets/corewidgets/pop_widget.dart';
import 'package:quran/view/widgets/moshafaudiowidgets/moshaf_play_screen/playscreenwidgets.dart';

class TafsirPlayScreen extends GetView<TafsirPlayScreenController> {
  const TafsirPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TafsirPlayScreenController());
    return PopScopeWidget(
      func: (didpop, result) {
        popFunc(didpop, controller.goToTafseerSuwar());
      },
      widget: Scaffold(
          backgroundColor: AppColors.splashMainBackGroundColor,
          body: Container(
            margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.05),
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenSize.screenHeight * 0.015,
                            horizontal: ScreenSize.screenWidth * 0.01),
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSize.screenHeight * 0.015),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          color: AppColors.bgColorLightGreen,
                        ),
                        child: GetBuilder<TafsirPlayScreenController>(
                          builder: (controller) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              StaticImage(),
                              PlayerAnimationImage(
                                  animation: controller.animation),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenSize.screenWidth * 0.03),
                                  alignment: Alignment.centerRight,
                                  height: ScreenSize.screenHeight * 0.11,
                                  child: AudioData(
                                      surah: controller.index != -1
                                          ? "سورة : ${controller.data[controller.index]["name"]}"
                                          : "سورة : ${controller.selectedSuraNameSearch}",
                                      qarea: controller.index != -1
                                          ? "رقم السورة  : ${controller.data[controller.index]["sura_id"]}"
                                          : "رقم السورة  : ${controller.selectedSuraIdSearch}")),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: ScreenSize.screenWidth * 0.03,
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
                      top: ScreenSize.screenHeight * 0.007,
                      left: ScreenSize.screenWidth * 0.015,
                      child: BackButtonWidget(
                          backFunc: () {
                            controller.goToTafseerSuwar();
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
