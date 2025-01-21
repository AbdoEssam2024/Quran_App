import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/read_moshaf/read_moshaf_controller.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/data/homedata/quran_data.dart';

class PagesControl extends GetView<ReadMoshafController> {
  const PagesControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.borderColorGreen,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 50,
        children: [
          IconButton(
              onPressed: () {
                controller.goToNextPage();
              },
              icon: Icon(Icons.arrow_back, color: AppColors.textwhite)),
          GetBuilder<ReadMoshafController>(
            builder: (controller) =>
                Text("${quranImages.length} / ${controller.currentPage + 1}",
                    style: TextStyle(
                      color: AppColors.textwhite,
                    )),
          ),
          IconButton(
            onPressed: () {
              controller.goToprefPage();
            },
            icon: Icon(Icons.arrow_forward),
            color: AppColors.textwhite,
          ),
          GetBuilder<ReadMoshafController>(
              builder: (controller) => IconButton(
                    onPressed: () {
                      controller.setFavourite();
                    },
                    icon: Icon(Icons.save, color: AppColors.textwhite),
                  ))
        ],
      ),
    );
  }
}
