import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/tadabor/tadaborcontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/tadabormodel.dart';
import 'package:quran/view/widgets/homewidgets/tadabor.dart';

class TadaborItems extends GetView<TadaborController> {
  final TadaborSubDataModel tadaborSubData;
  const TadaborItems({
    super.key,
    required this.tadaborSubData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToPlayScreen(tadaborSubData.reciterName!,
            tadaborSubData.soraName!, tadaborSubData.videoUrl!);
      },
      child: Container(
        padding: EdgeInsets.all(3.sp),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
        child: Stack(
          children: [
            Card(
                color: AppColors.bgColorLightGreen,
                child: ListTile(
                  contentPadding: EdgeInsets.all(5.sp),
                  title:
                      TadaborText(text: tadaborSubData.soraName!, size: 12.sp),
                  subtitle: TadaborText(
                      text: tadaborSubData.reciterName!, size: 16.sp),
                )),
            Positioned(
              left: ScreenSize.screenWidth * 0.025,
              top: ScreenSize.screenHeight * 0.015,
              child: Container(
                width: ScreenSize.screenWidth * 0.2,
                height: ScreenSize.screenHeight * 0.08,
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.screenWidth * 0.007,
                    vertical: ScreenSize.screenHeight * 0.003),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.sp))),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                    child: Image.network(
                      tadaborSubData.imageUrl!,
                      fit: BoxFit.cover,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
