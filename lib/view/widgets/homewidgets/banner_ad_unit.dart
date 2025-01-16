import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quran/controller/homecontroller.dart';

class BannerAdUnit extends GetView<HomeController> {
  const BannerAdUnit({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
      child:
          controller.adLoaded ? AdWidget(ad: controller.bannerAD) : null,
    ));
  }
}
