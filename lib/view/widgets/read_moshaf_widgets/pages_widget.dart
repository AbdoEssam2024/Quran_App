import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/read_moshaf/read_moshaf_controller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/data/homedata/quran_data.dart';

class PagesWidget extends GetView<ReadMoshafController> {
  const PagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        reverse: true,
        controller: controller.pageController,
        onPageChanged: (value) {
          controller.getCurrentPage(value);
        },
        scrollBehavior: ScrollBehavior(),
        itemCount: quranImages.length,
        itemBuilder: (context, index) => Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      quranImages[index],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 5,
                  child: GetBuilder<ReadMoshafController>(
                      builder: (controller) => Container(
                            decoration: BoxDecoration(
                                color: index == controller.savedPage
                                    ? AppColors.borderColorGreen
                                    : AppColors.pagesBG,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50))),
                            width: ScreenSize.screenWidth * 0.2,
                            height: ScreenSize.screenHeight * 0.015,
                          )),
                )
              ],
            ));
  }
}
