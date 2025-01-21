import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/constant/appimages/appimages.dart';
import 'package:quran/view/widgets/corewidgets/audiocontrollers.dart';
import 'package:quran/view/widgets/corewidgets/customslider.dart';
import 'package:quran/view/widgets/homewidgets/suwarname.dart';

class StaticImage extends StatelessWidget {
  const StaticImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.03),
        padding:
            EdgeInsets.symmetric(horizontal: ScreenSize.screenWidth * 0.015),
        width: ScreenSize.screenWidth * 0.9,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.sp),
            child: Image.asset(AppImages.imageEight, fit: BoxFit.cover)));
  }
}

class PlayerAnimationImage extends StatelessWidget {
  final bool animation;
  const PlayerAnimationImage({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Lottie.asset(
          AppImages.playsound,
          animate: animation,
          fit: BoxFit.fill,
          height: ScreenSize.screenHeight * 0.16,
          width: Get.width,
        ));
  }
}

class AudioData extends StatelessWidget {
  final String surah;
  final String qarea;
  const AudioData({super.key, required this.surah, required this.qarea});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SuwarNameText(text: surah, size: 14.sp),
        SuwarNameText(text: qarea, size: 14.sp)
      ],
    );
  }
}

class DurationSeekBarPosition extends StatelessWidget {
  final String positionText;
  final String durationText;
  final void Function(double) func;
  final double val;
  final double maxval;
  const DurationSeekBarPosition(
      {super.key,
      required this.positionText,
      required this.durationText,
      required this.val,
      required this.maxval,
      required this.func});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SuwarNameText(text: positionText, size: 12.sp),
        Expanded(child: CustomSlider(func: func, val: val, maxval: maxval)),
        SuwarNameText(text: durationText, size: 12.sp),
      ],
    );
  }
}

class PlayControllers extends StatelessWidget {
  final void Function() prevfunc;
  final void Function() playfunc;
  final void Function() nextfunc;
  final IconData playicon;
  const PlayControllers(
      {super.key,
      required this.prevfunc,
      required this.playfunc,
      required this.nextfunc,
      required this.playicon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: ScreenSize.screenWidth * 0.15,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.textBlack.withAlpha(200),
              borderRadius: BorderRadius.circular(50.sp)),
          padding: EdgeInsets.all(5.sp),
          child: AudioControlIcons(
              func: prevfunc,
              icon: Icons.keyboard_double_arrow_right_rounded,
              size: 30.sp,
              iconColor: AppColors.textwhite),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.textBlack.withAlpha(200),
              borderRadius: BorderRadius.circular(50.sp)),
          padding: EdgeInsets.all(5.sp),
          child: AudioControlIcons(
              func: playfunc,
              icon: playicon,
              size: 45.sp,
              iconColor: AppColors.textwhite),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.textBlack.withAlpha(200),
              borderRadius: BorderRadius.circular(50.sp)),
          padding: EdgeInsets.all(5.sp),
          child: AudioControlIcons(
              func: nextfunc,
              icon: Icons.keyboard_double_arrow_left_rounded,
              size: 30.sp,
              iconColor: AppColors.textwhite),
        ),
      ],
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  final void Function() backFunc;
  final String text;
  const BackButtonWidget(
      {super.key, required this.backFunc, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      iconAlignment: IconAlignment.end,
      icon: Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.borderColorGreen,
        size: 25.sp,
      ),
      label: Text(
        text,
        style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.borderColorGreen),
      ),
      onPressed: backFunc,
    );
  }
}
