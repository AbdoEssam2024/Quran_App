import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quran/controller/tafsir/tafsirscreencontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/tafseermodel.dart';

class TafsirItemsWidget extends GetView<TafsirScreenController> {
  final TafsirModel tafsirModel;
  final int index;
  const TafsirItemsWidget(
      {super.key, required this.index, required this.tafsirModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToPlayScreen(index);
      },
      child: Container(
          width: ScreenSize.screenWidth * 0.75,
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
                  text: "${tafsirModel.suraId}", size: 16.sp),
              title: SuwarNameTextWidget(
                  text: "${tafsirModel.name}", size: 14.sp),
            ),
          )),
    );
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
