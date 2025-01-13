import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/homecontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/suwarnamemodel.dart';

class SuwarNames extends GetView<HomeController> {
  const SuwarNames({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.suwarNameStatusRequest,
            widget: Container(
                height: ScreenSize.screenHeight * 0.13,
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSize.screenHeight * 0.015),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => SuwarNameItems(
                          index: index,
                          suwarNameModel: SuwarNameModel.fromJson(
                              controller.suwarNameData[index]),
                        )))));
  }
}

class SuwarNameItems extends GetView<HomeController> {
  final SuwarNameModel suwarNameModel;
  final int index;
  const SuwarNameItems(
      {super.key, required this.index, required this.suwarNameModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          width: ScreenSize.screenWidth * 0.7,
          margin: EdgeInsets.only(left: ScreenSize.screenWidth * 0.015),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: AppColors.borderColorGreen,
          ),
          child: Card(
            color: AppColors.bgColorLightGreen,
            child: ListTile(
              title: SuwarNameText(
                  text: "سورة ${suwarNameModel.name}", size: 14.sp),
              subtitle: SuwarNameText(
                  text: suwarNameModel.startPage == suwarNameModel.endPage
                      ? "صفحة  ${suwarNameModel.startPage}"
                      : " من صفحة ${suwarNameModel.startPage} : ${suwarNameModel.endPage}",
                  size: 10.sp),
              trailing: SuwarNameText(
                  text: suwarNameModel.makkia == 0 ? "سورة مدنية" : "سورة مكية",
                  size: 14.sp),
            ),
          )),
    );
  }
}

class SuwarNameText extends StatelessWidget {
  final String text;
  final double size;
  const SuwarNameText({super.key, required this.text, required this.size});

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
