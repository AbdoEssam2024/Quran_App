import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/controller/tadabor/tadaborcontroller.dart';
import 'package:quran/core/class/handlingdataview.dart';
import 'package:quran/core/class/screensize.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';
import 'package:quran/model/tadabormodel.dart';
import 'package:quran/view/widgets/tadaborwidget/tadaborcard.dart';

class TadaborScreen extends GetView<TadaborController> {
  const TadaborScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TadaborController());
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: AppColors.splashMainBackGroundColor,
          body: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                    iconAlignment: IconAlignment.end,
                    label: Text(
                      "Back",
                      style: TextStyle(
                          color: AppColors.textwhite,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      controller.goToHomePage();
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25.sp,
                      color: AppColors.textwhite,
                    )),
              ),
              GetBuilder<TadaborController>(
                builder: (controller) => HandlingDataRequest(
                    statusRequest: controller.tadaborStatusRequest,
                    widget: Container(
                      padding: EdgeInsets.all(10.sp),
                      child: SizedBox(
                        height: ScreenSize.screenHeight * 0.88,
                        child: ListView.builder(
                            itemCount: controller.finalData.length,
                            itemBuilder: (context, index) => Column(
                                  children: [
                                    TadaborItems(
                                        tadaborSubData:
                                            TadaborSubDataModel.fromJson(
                                                controller.finalData[index][0]))
                                  ],
                                )),
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
