import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/moshafaudio/moshafaudiosuwarcontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/coremodel/suwarelqareamodel.dart';
import 'package:quran/view/widgets/homewidgets/suwarname.dart';

class SuraCard extends GetView<MoshafAudioSuwarController> {
  final QareaSuwar qareaSuwar;
  final int index;
  const SuraCard({super.key, required this.index, required this.qareaSuwar});

  @override
  Widget build(BuildContext context) {
    Get.put(MoshafAudioSuwarController());
    return InkWell(
      onTap: () {
        controller.goToPlayScreen(index);
      },
      child: Container(
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

class MoshafSuraText extends StatelessWidget {
  final String text;
  final double size;
  const MoshafSuraText({super.key, required this.text, required this.size});

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
