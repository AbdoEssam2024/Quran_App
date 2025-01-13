import 'package:get/get.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/core/functions/handling_data_controller.dart';
import 'package:quran/data/bestreading/bestreadingdata.dart';

class BestReadingController extends GetxController {
  BestReadingData bestReadingData = BestReadingData(Get.find());
  StatusRequest statusRequest = StatusRequest.loading;

  List bestReadingMainData = [];

  // Variable Of (List) DataType To Search Result Data ; //
  List searchResult = [];

  // Variable Of (Boolean) DataType To Check If User Use Search Is Not , //
  // It Have Start Value Of (false) And It Will Change When The User Use Search ; //
  bool isSearch = false;

  getBestReadingData() async {
    statusRequest = StatusRequest.loading;
    var response = await bestReadingData.getData();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      bestReadingMainData.addAll(response['videos']);
      if (bestReadingMainData.isNotEmpty) {
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.serverFailure;
      }
    }
    update();
  }

  checkSearch(String value) {
    // Condition If The Value Of The Text Feild != null Or Empty ,
    // It's Mean That The User (Using) The Search Option , //
    if (value != "") {
      // In This Case We Will Change The (isSearch) Variable Value To (true) , //
      isSearch = true;
    } else {
      // If The Value Of The Text Feild == null Or Empty ,
      // It's Mean That The User (Not Using) The Search Option , //
      // In This Case (isSearch) Variable Value Still (false) , //
      isSearch = false;
    }
    update();
  }

  // This Function Will Only Excuted If The User Start Using The Search Option , //
  searchmoshaf(String value) {
    // First We Will Be Sure The Result List Don't Contain Any Stuck Data , //
    // By Clearing The List Firstly When The Function Being Excuted , //
    searchResult.clear();
    // Declare Temprorary Variable Of (List) DataType To Recieve The Results , //
    // From The Loop We Will Start Next , //
    List result = [];
    // Starting Loop On The Main (data) List , //
    for (int i = 0; i < bestReadingMainData.length; i++) {
      // Condition Means Thar If The Main (data) In Index [i] In Key ['name'] , //
      // That Key Referes To The (Qarea Name) , Contains Any Letters That User Entered , //
      if (bestReadingMainData[i]['reciter_name'].toString().contains(value)) {
        // Add The Data Matches The Search To The Temprorary Variable (result) , //
        result.add(bestReadingMainData[i]);
      }
    }
    // At The End Add All Data Matches The Search To The (searchResult) List , //
    // To Start Showing The Result At The Ui Page ; //
    searchResult.addAll(result);
    update();
  }

  goToHomePage() {
    Get.offNamed(AppRoutesNames.home);
  }

  goToPlayScreen(String qareaname, int index) {
    Get.toNamed(AppRoutesNames.bestReadingsplayscreen,
        arguments: isSearch
            ? {"qarea_name": qareaname, "videos": searchResult[index]['videos']}
            : {
                "qarea_name": qareaname,
                "videos": bestReadingMainData[index]['videos']
              });
  }

  @override
  void onInit() {
    getBestReadingData();
    super.onInit();
  }
}
