import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/variuosreading/variousreadingcontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/constant/appimages/appimages.dart';
import 'package:quran/model/variousreadingmodel.dart';

class VariousReadingStructure extends StatelessWidget {
  const VariousReadingStructure({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VariousReadingController>(
      builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: SizedBox(
            height: ScreenSize.screenHeight * 0.88,
            child: ListView.builder(
                itemCount: controller.isSearch
                    ? controller.searchResult.length
                    : controller.data.length,
                itemBuilder: (context, index) => VariousReadingView(
                      variousReadingReads: Reads.fromJson(controller.isSearch
                          ? controller.searchResult[index]
                          : controller.data[index]),
                      variousReadingMoshaf:
                          Moshaf.fromJson(controller.subData[index]),
                      index: index,
                    )),
          )),
    );
  }
}

class VariousReadingView extends GetView<VariousReadingController> {
  final Reads variousReadingReads;
  final Moshaf variousReadingMoshaf;
  final int index;
  const VariousReadingView(
      {super.key,
      required this.index,
      required this.variousReadingReads,
      required this.variousReadingMoshaf});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.gotoSuwarAudio(index);
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
                title: VariousReadingText(
                    text: "${variousReadingReads.name}", size: 16.sp),
                subtitle: VariousReadingText(
                    text: "${variousReadingMoshaf.name}", size: 12.sp),
              ),
            ),
            Positioned(
              left: ScreenSize.screenWidth * 0.012,
              top: ScreenSize.screenHeight * 0.025,
              child: Container(
                width: ScreenSize.screenWidth * 0.2,
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.screenWidth * 0.007,
                    vertical: ScreenSize.screenHeight * 0.003),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.sp))),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                    child: Image.asset(
                      AppImages.imageEight,
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

class VariousReadingText extends StatelessWidget {
  final String text;
  final double size;
  const VariousReadingText({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: AppColors.textBlack,
          fontSize: size,
          fontWeight: FontWeight.bold),
    );
  }
}
