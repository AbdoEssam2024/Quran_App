import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/suwarname/suwarnamecontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/functions/pop_func.dart';
import 'package:quran/model/suwarnamemodel.dart';
import 'package:quran/view/widgets/corewidgets/pop_widget.dart';
import 'package:quran/view/widgets/corewidgets/searchbar.dart';
import 'package:quran/view/widgets/swarname/swarnameitemswidget.dart';

class SuwarNameScreen extends GetView<SuwarNameController> {
  const SuwarNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SuwarNameController());
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
                height: ScreenSize.screenHeight * 0.85,
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.screenWidth * 0.015,
                    vertical: ScreenSize.screenHeight * 0.007),
                child: GetBuilder<SuwarNameController>(
                    builder: (controller) => HandlingDataRequest(
                          statusRequest: controller.statusRequest,
                          widget: ListView.builder(
                            itemCount: controller.isSearch
                                ? controller.searchResult.length
                                : controller.data.length,
                            itemBuilder: (context, index) =>
                                SuwarNameItemsWidget(
                              suwarNameModel: SuwarNameModel.fromJson(
                                  controller.isSearch
                                      ? controller.searchResult[index]
                                      : controller.data[index]),
                              index: index,
                            ),
                          ),
                        )))
          ],
        ),
      ),
    );
  }
}
