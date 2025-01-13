import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/homecontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/mwaqeetelsalah.dart';

class SalahTimingWidget extends GetView<HomeController> {
  const SalahTimingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.salahTimingStatusRequest,
            widget: Container(
                height: ScreenSize.screenHeight * 0.6,
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSize.screenHeight * 0.01),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.salahTimingData.length,
                    itemBuilder: (context, index) => SalahTimingItems(
                          salah: MawaqeetSalah.fromJson(
                              controller.salahTimingData[index]),
                        )))));
  }
}

class SalahTimingItems extends GetView<HomeController> {
  final MawaqeetSalah salah;
  const SalahTimingItems({super.key, required this.salah});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.screenWidth * 0.94,
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.screenWidth * 0.015),
      decoration: BoxDecoration(
        color: AppColors.bgColorLightGreen,
        border: Border.all(
            color: AppColors.borderColorGreen,
            width: ScreenSize.screenWidth * 0.008),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SalahTimingCard(timeText: salah.fajr!, labelText: "الفجر"),
          Divider(
            color: AppColors.textBlack,
            height: ScreenSize.screenHeight * 0.005,
          ),
          SalahTimingCard(timeText: salah.sunrise!, labelText: "الشروق"),
          Divider(
            color: AppColors.textBlack,
            height: ScreenSize.screenHeight * 0.005,
          ),
          SalahTimingCard(timeText: salah.dhuhr!, labelText: "الظهر"),
          Divider(
            color: AppColors.textBlack,
            height: ScreenSize.screenHeight * 0.005,
          ),
          SalahTimingCard(timeText: salah.asr!, labelText: "العصر"),
          Divider(
            color: AppColors.textBlack,
            height: ScreenSize.screenHeight * 0.005,
          ),
          SalahTimingCard(timeText: salah.maghrib!, labelText: "المغرب"),
          Divider(
            color: AppColors.textBlack,
            height: ScreenSize.screenHeight * 0.005,
          ),
          SalahTimingCard(timeText: salah.isha!, labelText: "العشاء"),
          Divider(
            color: AppColors.textBlack,
            height: ScreenSize.screenHeight * 0.005,
          ),
          SalahTimingCard(
              timeText: salah.firstthird!, labelText: "الثلث الأول"),
          Divider(
            color: AppColors.textBlack,
            height: ScreenSize.screenHeight * 0.005,
          ),
          SalahTimingCard(
              timeText: salah.lastthird!, labelText: "الثلث الأخير"),
        ],
      ),
    );
  }
}

class SalahTimingCard extends StatelessWidget {
  final String timeText;
  final String labelText;
  const SalahTimingCard(
      {super.key, required this.timeText, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SalahTimingText(text: labelText, size: 16.sp),
        SalahTimingText(text: timeText, size: 16.sp),
      ],
    );
  }
}

class SalahTimingText extends StatelessWidget {
  final String text;
  final double size;
  const SalahTimingText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: AppColors.textBlack,
      ),
    );
  }
}
