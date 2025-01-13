import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/bestreading/bestreadingcontroller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/bestreadingmodel.dart';

class BestReadingCard extends GetView<BestReadingController> {
  final BestReadingModel bestReadingModel;
  final int index;

  const BestReadingCard(
      {super.key, required this.bestReadingModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToPlayScreen(bestReadingModel.reciterName!, index);
      },
      child: Container(
        padding: EdgeInsets.all(3.sp),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Card(
                color: AppColors.bgColorLightGreen,
                child: ListTile(
                  contentPadding: EdgeInsets.all(15.sp),
                  title: BestReadingText(
                      text: bestReadingModel.reciterName!, size: 12.sp),
                )),
            Positioned(
              left: ScreenSize.screenWidth * 0.025,
              top: ScreenSize.screenHeight * 0.02,
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
                      bestReadingModel.videos![0].videoThumbUrl!,
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

class BestReadingText extends StatelessWidget {
  final String text;
  final double size;
  const BestReadingText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: size,
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold));
  }
}
