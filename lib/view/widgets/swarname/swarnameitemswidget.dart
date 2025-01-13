import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quran/controller/suwarname/suwarnamecontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/suwarnamemodel.dart';

class SuwarNameItemsWidget extends GetView<SuwarNameController> {
  final SuwarNameModel suwarNameModel;
  final int index;
  const SuwarNameItemsWidget({super.key, required this.index , required this.suwarNameModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: ScreenSize.screenWidth * 0.015,
            bottom: ScreenSize.screenHeight * 0.007),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.borderColorGreen,
        ),
        child: Card(
          color: AppColors.bgColorLightGreen,
          child: ListTile(
            leading: SuwarNameTextWidget(
                text: "${suwarNameModel.id}", size: 16.sp),
            title: SuwarNameTextWidget(
                text: "سورة ${suwarNameModel.name}", size: 16.sp),
            subtitle: SuwarNameTextWidget(
                text: suwarNameModel.startPage ==
                        suwarNameModel.endPage
                    ? "صفحة  ${suwarNameModel.startPage}"
                    : " من صفحة ${suwarNameModel.startPage} : ${suwarNameModel.endPage}",
                size: 12.sp),
            trailing: SuwarNameTextWidget(
                text: suwarNameModel.makkia == 0
                    ? "سورة مدنية"
                    : "سورة مكية",
                size: 14.sp),
          ),
        ));
  }
}

class SuwarNameTextWidget extends StatelessWidget {
  final String text;
  final double size;
  const SuwarNameTextWidget(
      {super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: AppColors.textBlack),
    );
  }
}
