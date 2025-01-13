import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/controller/homecontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/constant/appimages/appimages.dart';
import 'package:quran/core/functions/audiofunctions.dart';
import 'package:quran/view/widgets/corewidgets/audiocontrollers.dart';
import 'package:quran/view/widgets/corewidgets/customslider.dart';
import 'package:quran/view/widgets/homewidgets/suwarname.dart';

class VariousReadingWidgets extends GetView<HomeController> {
  const VariousReadingWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.variousReadingStatusRequest,
            widget: controller.variousReadingSubData.isEmpty
                ? Center(child: Lottie.asset(AppImages.loading))
                : InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: AppColors.borderColorGreen,
                      ),
                      child: Container(
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            color: AppColors.bgColorLightGreen,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SuwarNameText(
                                      text:
                                          "القارئ : ${controller.variousReadingMainData[1]['name']}",
                                      size: 12.sp),
                                  SuwarNameText(
                                      text:
                                          "رواية : ${controller.variousReadingSubData[1]['name']}",
                                      size: 12.sp),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SuwarNameText(
                                      text: formatDuration(
                                          controller.variousReadingposition),
                                      size: 12.sp),
                                  Expanded(
                                    child: CustomSlider(
                                        func: (val) {
                                          controller
                                              .seekVariousReadingAudioPosition(
                                                  Duration(
                                                      seconds: val.toInt()));
                                        },
                                        val: controller
                                            .variousReadingposition.inSeconds
                                            .toDouble(),
                                        maxval: controller
                                            .variousReadingduration.inSeconds
                                            .toDouble()),
                                  ),
                                  SuwarNameText(
                                      text: formatDuration(
                                          controller.variousReadingduration),
                                      size: 12.sp),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AudioControlIcons(
                                      func: () {
                                        controller.playVariousReadingAudio(1);
                                      },
                                      icon: controller.variousReadingisPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow_rounded,
                                      size: 40.sp,
                                      iconColor: AppColors.borderColorGreen),
                                ],
                              ),
                            ],
                          )),
                    ))));
  }
}
