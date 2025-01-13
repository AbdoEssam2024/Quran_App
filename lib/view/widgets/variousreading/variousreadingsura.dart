import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/variuosreading/variousreadingsuwarcontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/coremodel/suwarelqareamodel.dart';
import 'package:quran/view/widgets/homewidgets/suwarname.dart';

class VariousReadingSuraCard extends GetView<VariousReadingSuwarController> {
  final QareaSuwar qareaSuwar;
  final int index;
  const VariousReadingSuraCard(
      {super.key, required this.index, required this.qareaSuwar});

  @override
  Widget build(BuildContext context) {
    Get.put(VariousReadingSuwarController());
    return InkWell(
      onTap: () {
        controller.goToPlayScreen(index);
      },
      child: Container(
          width: ScreenSize.screenWidth * 0.25,
          margin:
              EdgeInsets.symmetric(vertical: ScreenSize.screenHeight * 0.007),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: AppColors.borderColorGreen,
          ),
          child: Card(
            color: AppColors.bgColorLightGreen,
            child: ListTile(
              leading: SuwarNameText(text: "${index + 1}", size: 12.sp),
              title:
                  SuwarNameText(text: "سورة ${qareaSuwar.name}", size: 16.sp),
              subtitle: SuwarNameText(
                  text: qareaSuwar.start == qareaSuwar.end
                      ? "صفحة  ${qareaSuwar.start}"
                      : " من صفحة ${qareaSuwar.start} : ${qareaSuwar.end}",
                  size: 12.sp),
              trailing: SuwarNameText(
                  text: qareaSuwar.makkia == 0 ? "سورة مدنية" : "سورة مكية",
                  size: 14.sp),
            ),
          )),
    );
  }
}

class VariousReadingSuraText extends StatelessWidget {
  final String text;
  final double size;
  const VariousReadingSuraText(
      {super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: AppColors.textwhite,
          letterSpacing: 1.w),
    );
  }
}
