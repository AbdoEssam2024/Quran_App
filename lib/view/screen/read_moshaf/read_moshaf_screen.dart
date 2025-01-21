import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/read_moshaf/read_moshaf_controller.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/core/functions/pop_func.dart';
import 'package:quran/view/widgets/corewidgets/pop_widget.dart';
import 'package:quran/view/widgets/corewidgets/searchbar.dart';
import 'package:quran/view/widgets/read_moshaf_widgets/pages_control.dart';
import 'package:quran/view/widgets/read_moshaf_widgets/pages_widget.dart';

class ReadMoshafScreen extends GetView<ReadMoshafController> {
  const ReadMoshafScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReadMoshafController());
    return PopScopeWidget(
      func: (didpop, result) {
        popFunc(didpop, controller.backToHomePage());
      },
      widget: Scaffold(
        backgroundColor: AppColors.pagesBG,
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.05),
                child: CustomSearchBar(
                  feildControl: controller.searchPage,
                  btnFunc: () {
                    controller.backToHomePage();
                  },
                  testFunc: () {
                    controller.goToSpeceificPage();
                  },
                )),
            Expanded(
              child: Container(
                child: PagesWidget(),
              ),
            ),
            PagesControl(),
          ],
        ),
      ),
    );
  }
}
