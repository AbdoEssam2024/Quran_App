import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/homecontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/functions/audiofunctions.dart';
import 'package:quran/model/tadabormodel.dart';
import 'package:quran/view/widgets/corewidgets/audiocontrollers.dart';
import 'package:quran/view/widgets/corewidgets/customslider.dart';
import 'package:video_player/video_player.dart';

class TadaborSection extends StatelessWidget {
  const TadaborSection({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.tadaborStatusRequest,
            widget: Container(
                height: ScreenSize.screenHeight * 0.6,
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSize.screenHeight * 0.015),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context, index) => TadaborWidgets(
                          tadaborSubDataModel: TadaborSubDataModel.fromJson(
                              controller.tadaborSubData[index]),
                        )))));
  }
}

class TadaborWidgets extends GetView<HomeController> {
  final TadaborSubDataModel tadaborSubDataModel;
  const TadaborWidgets({super.key, required this.tadaborSubDataModel});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenSize.screenHeight * 0.005),
      padding: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.borderColorGreen,
      ),
      child: Container(
        height: ScreenSize.screenHeight * 0.53,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.bgColorLightGreen,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TadaborText(
                      text: "سورة : ${tadaborSubDataModel.soraName}",
                      size: 14.sp),
                  TadaborText(
                      text: "القارئ : ${tadaborSubDataModel.reciterName}",
                      size: 14.sp),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  height: ScreenSize.screenHeight * 0.4,
                  child: VideoPlayer(controller.videoController),
                ),
                Positioned(
                  left: ScreenSize.screenWidth * 0.15,
                  right: ScreenSize.screenWidth * 0.15,
                  top: ScreenSize.screenHeight * 0.12,
                  child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: controller.showPlayIcon ? 1.0 : 0.0,
                      child: AudioControlIcons(
                          func: () {
                            controller.togglePlayIcon();
                            controller.videoController.value.isPlaying
                                ? controller.videoController.pause()
                                : controller.videoController.play();
                            controller.playvideos();
                          },
                          icon: controller.videoIcon,
                          size: 70.sp,
                          iconColor: AppColors.iconSoundColor)),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.01),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.screenWidth * 0.01),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(5.sp)),
                color: AppColors.bgColorLightGreen,
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TadaborText(
                    text: "${formatDuration(controller.videoPosition)}",
                    size: 12.sp),
                Expanded(
                    child: CustomSlider(
                        func: (val) {
                          val = controller.videoPosition.inSeconds.toDouble();
                        },
                        val: controller.videoPosition.inSeconds.toDouble(),
                        maxval: controller.videoDuration.inSeconds.toDouble())),
                TadaborText(
                    text: "${formatDuration(controller.videoDuration)}",
                    size: 12.sp),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class TadaborText extends StatelessWidget {
  final String text;
  final double size;
  const TadaborText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: size,
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold));
  }
}
