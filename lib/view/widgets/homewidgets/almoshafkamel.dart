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

class AlmoshafKamelItems extends GetView<HomeController> {
  const AlmoshafKamelItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.almoshaStatusRequest,
            widget: controller.moshafSubData.isEmpty
                ? Center(child: Lottie.asset(AppImages.loading))
                : InkWell(
                    onTap: () {},
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.h),
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
                                          "القارئ : ${controller.moshafMainData[0]['name']}",
                                      size: 12.sp),
                                  SuwarNameText(
                                      text:
                                          "رواية : ${controller.moshafSubData[0]['name']}",
                                      size: 12.sp)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SuwarNameText(
                                      text: formatDuration(
                                          controller.almoshafKamelposition),
                                      size: 12.sp),
                                  Expanded(
                                      child: CustomSlider(
                                          func: (val) {
                                            controller.seekAudioPosition(
                                                Duration(seconds: val.toInt()));
                                          },
                                          val: controller
                                              .almoshafKamelposition.inSeconds
                                              .toDouble(),
                                          maxval: controller
                                              .almoshafKamelduration.inSeconds
                                              .toDouble())),
                                  SuwarNameText(
                                      text: formatDuration(
                                          controller.almoshafKamelduration),
                                      size: 12.sp),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AudioControlIcons(
                                      func: () {
                                        controller.playAudio(0);
                                      },
                                      icon: controller.almoshafKamelisPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow_rounded,
                                      size: 40.sp,
                                      iconColor: AppColors.borderColorGreen),
                                ],
                              ),
                            ],
                          ),
                        )),
                  )));
  }
}
