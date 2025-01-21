import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/tafsir/tafsirscreencontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/functions/pop_func.dart';
import 'package:quran/model/tafseermodel.dart';
import 'package:quran/view/widgets/corewidgets/pop_widget.dart';
import 'package:quran/view/widgets/corewidgets/searchbar.dart';
import 'package:quran/view/widgets/tafsirwidgets/tafsiritemswidget.dart';

class TafsirScreen extends GetView<TafsirScreenController> {
  const TafsirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TafsirScreenController());
    return PopScopeWidget(
      func: (didpop, result) {
        popFunc(didpop, controller.gotoHome());
      },
      widget: Scaffold(
        backgroundColor: AppColors.splashMainBackGroundColor,
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            CustomSearchBar(btnFunc: () {
              controller.gotoHome();
            }, func: (val) {
              controller.checkSearch(val);
              controller.searchmoshaf(val);
            }),
            Container(
                height: ScreenSize.screenHeight * 0.86,
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.screenWidth * 0.015,
                    vertical: ScreenSize.screenHeight * 0.007),
                child: GetBuilder<TafsirScreenController>(
                    builder: (controller) => HandlingDataRequest(
                          statusRequest: controller.statusRequest,
                          widget: ListView.builder(
                              itemCount: controller.isSearch
                                  ? controller.searchResult.length
                                  : controller.data.length,
                              itemBuilder: (context, index) =>
                                  TafsirItemsWidget(
                                    tafsirModel: TafsirModel.fromJson(
                                        controller.isSearch
                                            ? controller.searchResult[index]
                                            : controller.data[index]),
                                    index: index,
                                  )),
                        )))
          ],
        ),
      ),
    );
  }
}
