import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';

class HomeSectionHeader extends StatelessWidget {
  final String text;
  final Widget? widget;
  const HomeSectionHeader({super.key, this.widget, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: TextStyle(
                color: AppColors.textwhite,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.w)),
        Container(
          child: widget,
        )
      ],
    );
  }
}

class ShowMoreBtn extends StatelessWidget {
  final void Function() func;
  const ShowMoreBtn({super.key, required this.func});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: AppColors.btnBgColorGreen,
        textColor: Colors.white,
        onPressed: func,
        child: Text(
          "إظهار الكل",
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ));
  }
}
