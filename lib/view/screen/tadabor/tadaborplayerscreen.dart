import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/tadabor/tadaborplayscreencontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/functions/audiofunctions.dart';
import 'package:quran/core/functions/pop_func.dart';
import 'package:quran/view/widgets/corewidgets/audiocontrollers.dart';
import 'package:quran/view/widgets/corewidgets/customslider.dart';
import 'package:quran/view/widgets/corewidgets/pop_widget.dart';
import 'package:quran/view/widgets/homewidgets/tadabor.dart';
import 'package:video_player/video_player.dart';

class TadaborPlayerScreen extends GetView<TadaborPlayScreenController> {
  const TadaborPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TadaborPlayScreenController());
    return PopScopeWidget(
      func: (didpop, result) {
        popFunc(didpop, controller.goToTadaborScreen());
      },
      widget: Scaffold(
          backgroundColor: AppColors.splashMainBackGroundColor,
          body: GetBuilder<TadaborPlayScreenController>(
              builder: (controller) => Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize.screenHeight * 0.08),
                          width: ScreenSize.screenWidth * 0.3,
                          child: TextButton.icon(
                              iconAlignment: IconAlignment.end,
                              label: Text(
                                "Back",
                                style: TextStyle(
                                    color: AppColors.textwhite,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                controller.goToTadaborScreen();
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 25.sp,
                                color: AppColors.textwhite,
                              )),
                        ),
                      ),
                      Container(
                        height: ScreenSize.screenHeight * 0.76,
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenSize.screenHeight * 0.015),
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.borderColorGreen,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.bgColorLightGreen,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenSize.screenHeight * 0.007),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TadaborText(
                                        text: "سورة : ${controller.soraName}",
                                        size: 14.sp),
                                    TadaborText(
                                        text:
                                            "القارئ : ${controller.reciterName}",
                                        size: 14.sp),
                                  ],
                                ),
                              ),
                              Stack(
                                children: [
                                  SizedBox(
                                    height: ScreenSize.screenHeight * 0.6,
                                    child:
                                        VideoPlayer(controller.videoController),
                                  ),
                                  Positioned(
                                    left: ScreenSize.screenWidth * 0.1,
                                    right: ScreenSize.screenWidth * 0.1,
                                    top: ScreenSize.screenHeight * 0.2,
                                    child: AnimatedOpacity(
                                        duration: Duration(milliseconds: 500),
                                        opacity:
                                            controller.showPlayIcon ? 1.0 : 0.0,
                                        child: AudioControlIcons(
                                            func: () {
                                              controller.togglePlayIcon();
                                              controller.videoController.value
                                                      .isPlaying
                                                  ? controller.videoController
                                                      .pause()
                                                  : controller.videoController
                                                      .play();
                                              controller.playvideos();
                                            },
                                            icon: controller.videoIcon,
                                            size: 70.sp,
                                            iconColor:
                                                AppColors.iconSoundColor)),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenSize.screenHeight * 0.01),
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenSize.screenWidth * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(5.sp)),
                                  color: AppColors.bgColorLightGreen,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TadaborText(
                                          text:
                                              "${formatDuration(controller.videoPosition)}",
                                          size: 12.sp),
                                      Expanded(
                                          child: CustomSlider(
                                              func: (val) {
                                                val = controller
                                                    .videoPosition.inSeconds
                                                    .toDouble();
                                              },
                                              val: controller
                                                  .videoPosition.inSeconds
                                                  .toDouble(),
                                              maxval: controller
                                                  .videoDuration.inSeconds
                                                  .toDouble())),
                                      TadaborText(
                                          text:
                                              "${formatDuration(controller.videoDuration)}",
                                          size: 12.sp),
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))),
    );
  }
}
