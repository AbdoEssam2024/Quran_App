import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/variuosreading/variousreadingsuwarcontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/coremodel/suwarelqareamodel.dart';
import 'package:quran/view/widgets/corewidgets/searchbar.dart';
import 'package:quran/view/widgets/moshafaudiowidgets/moshafaudiosura.dart';
import 'package:quran/view/widgets/variousreading/variousreadingsura.dart';

class VariousReadingSuwar extends StatelessWidget {
  const VariousReadingSuwar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VariousReadingSuwarController());
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: AppColors.splashMainBackGroundColor,
          body: Container(
            margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.015),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.screenWidth * 0.015),
            child: GetBuilder<VariousReadingSuwarController>(
                builder: (controller) => HandlingDataRequest(
                    statusRequest: controller.statusRequest,
                    widget: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomSearchBar(
                                btnFunc: () {
                                  controller.goToMoshafAudio();
                                },
                                func: (value) {
                                  controller.checkSearch(value);
                                  controller.searchsuwar(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        MoshafSuraText(
                            text: "القارئ : ${controller.qareaName}",
                            size: 14.sp),
                        Container(
                          padding: EdgeInsets.all(5.sp),
                          height: ScreenSize.screenHeight * 0.81,
                          child: ListView.builder(
                              itemCount: controller.isSearch
                                  ? controller.searchResult.length
                                  : controller.qareaSwar.length,
                              itemBuilder: (context, index) => VariousReadingSuraCard(
                                      qareaSuwar: QareaSuwar.fromJson(
                                          controller.isSearch
                                              ? controller.searchResult[index]
                                              : controller.qareaSwar[index]),
                                      index: index,
                                    )),
                        )
                      ],
                    ))),
          )),
    );
  }
}
