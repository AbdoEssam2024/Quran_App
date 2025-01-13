import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/appimages/appimages.dart';

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: Lottie.asset(AppImages.loading))
        : statusRequest == StatusRequest.offlineFailure
            ? Center(child: Lottie.asset(AppImages.offline))
            : statusRequest == StatusRequest.serverFailure
                ? Center(child: Lottie.asset(AppImages.nodata))
                : statusRequest == StatusRequest.failure
                    ? Center(child: Lottie.asset(AppImages.server))
                    : statusRequest == StatusRequest.serverException
                        ? Center(child: Lottie.asset(AppImages.server))
                        : widget;
  }
}
