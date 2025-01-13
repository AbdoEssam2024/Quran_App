import 'package:flutter/material.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';

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