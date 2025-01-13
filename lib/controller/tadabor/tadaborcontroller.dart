import 'package:get/get.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/core/functions/handling_data_controller.dart';
import 'package:quran/data/tadaborvideo/tadabor.dart';

class TadaborController extends GetxController {
  Tadabor tadabor = Tadabor(Get.find());

  StatusRequest tadaborStatusRequest = StatusRequest.loading;

  List tadaborMainData = [];
  Map tadaborSubData = {};
  List finalData = [];

  // Tadabor Get Data Function //
  getTadaborData() async {
    tadaborStatusRequest = StatusRequest.loading;
    var response = await tadabor.getData();
    tadaborStatusRequest = handlingData(response);
    if (tadaborStatusRequest == StatusRequest.success) {
      tadaborMainData.add(response['tadabor']);

      tadaborSubData.addAll(tadaborMainData[0]);

      finalData.addAll(tadaborSubData.values);

      if (tadaborMainData.isNotEmpty) {
        tadaborStatusRequest = StatusRequest.success;
      } else {
        tadaborStatusRequest = StatusRequest.serverFailure;
      }
    }
    update();
  }

  goToPlayScreen(String reciterName, String soraName, String videoUrl) {
    Get.toNamed(AppRoutesNames.tadaborplayerscreen, arguments: {
      "qarea_name": reciterName,
      "sura_name": soraName,
      "video_link": videoUrl
    });
  }

  goToHomePage() {
    Get.offNamed(AppRoutesNames.home);
  }

  @override
  void onInit() {
    getTadaborData();
    super.onInit();
  }
}
