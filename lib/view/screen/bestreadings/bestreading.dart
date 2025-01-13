import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/bestreading/bestreadingcontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/bestreadingmodel.dart';
import 'package:quran/view/widgets/bestradingwidgets/bestreadingwidgets.dart';
import 'package:quran/view/widgets/corewidgets/searchbar.dart';

class BestReadingScreen extends GetView<BestReadingController> {
  const BestReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BestReadingController());
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.splashMainBackGroundColor,
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    btnFunc: () {
                      controller.goToHomePage();
                    },
                    func: (value) {
                      controller.checkSearch(value);
                      controller.searchmoshaf(value);
                    },
                  ),
                ),
              ],
            ),
            GetBuilder<BestReadingController>(
                builder: (controller) => HandlingDataRequest(
                    statusRequest: controller.statusRequest,
                    widget: SizedBox(
                      height: ScreenSize.screenHeight * 0.88,
                      child: ListView.builder(
                          itemCount: controller.isSearch
                              ? controller.searchResult.length
                              : controller.bestReadingMainData.length,
                          itemBuilder: (context, index) => BestReadingCard(
                            index: index,
                                bestReadingModel: BestReadingModel.fromJson(
                                    controller.isSearch
                                        ? controller.searchResult[index]
                                        : controller.bestReadingMainData[index]),
                              )),
                    ))),
          ],
        ),
      ),
    );
  }
}
