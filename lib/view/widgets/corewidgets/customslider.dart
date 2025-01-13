import 'package:flutter/material.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';

class CustomSlider extends StatelessWidget {
  final void Function(double) func;
  final double val;
  final double maxval;
  const CustomSlider({super.key, required this.func, required this.val, required this.maxval});

  @override
  Widget build(BuildContext context) {
    return Slider(
        thumbColor: AppColors.sliderBallColorGrey,
        inactiveColor: AppColors.btntextColorWhite,
        activeColor: AppColors.borderColorGreen,
        value: val,
        min: 0.0,
        max: maxval,
        onChanged: func);
  }
}
