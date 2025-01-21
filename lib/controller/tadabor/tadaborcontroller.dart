import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/core/functions/handling_data_controller.dart';
import 'package:quran/data/tadaborvideo/tadabor.dart';

class TadaborController extends GetxController {
  final Connectivity connectivity = Connectivity();

  Tadabor tadabor = Tadabor(Get.find());

  StatusRequest tadaborStatusRequest = StatusRequest.loading;

  List tadaborMainData = [];
  Map tadaborSubData = {};
  List finalData = [];

  initConnectivity() {
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  updateConnectionStatus(List<ConnectivityResult> connectivityResultList) {
    if (connectivityResultList.contains(ConnectivityResult.none)) {
      tadaborStatusRequest = StatusRequest.offlineFailure;
    } else {
      getTadaborData();
    }
    update();
  }

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
    Get.offAllNamed(AppRoutesNames.home);
  }

  @override
  void onInit() {
    initConnectivity();

    getTadaborData();
    super.onInit();
  }
}
