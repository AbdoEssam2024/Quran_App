import 'package:get/get.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/core/functions/handling_data_controller.dart';
import 'package:quran/data/readmoshaf/moshafaudiodata.dart';

class MoshafAudioController extends GetxController {
  // Make Instance From (StatusRequest) Class To Handle The Response Of Data , //
  // Taking Start Value Of (none) ; //
  StatusRequest statusRequest = StatusRequest.none;

  // Injection Of (MoshafAudioData) Class To Get All (Qarea Data) From The Server ; //
  MoshafAudioData readMoshafData = MoshafAudioData(Get.find());

  // Variable Of (List) DataType To Recieve (Qarea Data) From The Server Response ; //
  List data = [];

  // Variable Of (List) DataType Used To Devide The Main Data Recieved From The Server , //
  // To Handle It After In Easly Way ; //
  List subData = [];

  // Variable Of (List) DataType To Search Result Data ; //
  List searchResult = [];

  // Variable Of (Boolean) DataType To Check If User Use Search Is Not , //
  // It Have Start Value Of (false) And It Will Change When The User Use Search ; //
  bool isSearch = false;

  // Function (getData) To Get The Request (Qarea Data) From The Server , //
  getData() async {
    // Set statusRequest to (loading) Value At First Until Recieve Response From The Server , //
    statusRequest = StatusRequest.loading;

    // Variable Of (Dynamic) DataType To Recieve The Response From The Server , //
    var response = await readMoshafData.getData();

    // Set The The Response From The (handlnigData) Method To (statusRequest) Variable, //
    // And Start Handling Depend On The Result , //
    statusRequest = handlingData(response);

    // Condition To Handle The Exeptions If Found , //
    // First If The (statusRequest) == success , //
    if (statusRequest == StatusRequest.success) {
      // Add The (response['reciters']) To The List (data) , //
      data.addAll(response['reciters']);

      // Loop On The Main (data) To Divide Key ['moshaf'] , //
      // Cause It Have More Complex Information To Easly Handle The Data , //
      for (int i = 0; i < data.length; i++) {
        // Add Key ['moshaf'] To (subData) List , //
        subData.addAll(data[i]['moshaf']);
      }

      // Another Nested Condition If The (statusRequest) == success , //
      // And The (data && subData) Not Empty (Recieved Actual Data) , //
      if (data.isNotEmpty && subData.isNotEmpty) {
        // Set The (statusRequest) = success , //
        statusRequest = StatusRequest.success;
      } else {
        // But If The List Still (Empty) Or (No Data Has Been Returned From The Server) , //
        // Set The (statusRequest) = serverFailure , //
        statusRequest = StatusRequest.serverFailure;
      }
    }

    update();
  }

  // This Function Will Allow The User To Navigate Back The Home Page , //
  gotoHome() {
    // Route Back Without Keep The Page In The Stack , //
    Get.offNamed(AppRoutesNames.home);
    // Delete The Page Controller To Save The Memory , //
    Get.delete<MoshafAudioController>();
  }

  // This Function Will Allow The User To Navigate To The Suwar Page To Choose The Surah To Play , //
  // And It Will Pass Some Information To It , //
  // First We Have Parameter (index) That Will Get It's Value From The Ui Page , //
  // To Specify Which (Qarea) That The User Choose , //
  // And It's Depend On The The Way Which User Take To Choose , //
  // (From Local Ui) Or (From Search Option) , //
  gotoSuwarAudio(int index) {
    Get.toNamed(AppRoutesNames.moshafAudioSuwar,
        // First We Will Check If The User Choose From (Search Option) Or (Local Ui) , //
        // From The (isSearch) Variable Value, //
        // If The (isSearch) Variable Value (true) , //
        // That Means That The User Used The (Search Option) So , //
        arguments: isSearch
            ? {
                // Send The (Qarea Surah List) From The (searchResult) List Variable, //
                "surahlist": searchResult[index]['moshaf'][0]['surah_list'],

                // Send The (Qarea Name) From The (searchResult) List Variable , //
                "qareaName": searchResult[index]['name'],

                // Send The (Audio Server Link) From The (searchResult) List Variable , //
                "serverlink": searchResult[index]['moshaf'][0]['server'],

                // Send The (Rewaya Type) From The (searchResult) List Variable , //
                "rewaya": searchResult[index]['moshaf'][0]['name'],
              }
            : {
                // Send The (Qarea Surah List) From The (subData) List Variable, //
                "surahlist": subData[index]['surah_list'],

                // Send The (Qarea Name) From The (data) List Variable , //
                "qareaName": data[index]['name'],

                // Send The (Audio Server Link) From The (subData) List Variable , //
                "serverlink": subData[index]['server'],

                // Send The (Rewaya Type) From The (subData) List Variable , //
                "rewaya": subData[index]['name'],
              });
  }

  // Function To Check If The User Uses Search Option , //
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
    for (int i = 0; i < data.length; i++) {
      // Condition Means Thar If The Main (data) In Index [i] In Key ['name'] , //
      // That Key Referes To The (Qarea Name) , Contains Any Letters That User Entered , //
      if (data[i]['name'].toString().contains(value)) {
        // Add The Data Matches The Search To The Temprorary Variable (result) , //
        result.add(data[i]);
      }
    }
    // At The End Add All Data Matches The Search To The (searchResult) List , //
    // To Start Showing The Result At The Ui Page ; //
    searchResult.addAll(result);
    update();
  }

  // This Function Excuted Automatically When Entered To The Page , //
  // And We Will Excute Some Methods Here To Get Data We Need In This Page , //
  @override
  void onInit() {
    // First We Excuted The Function (getData) To Send Request To The Server , //
    // And Get The Main Data That We Will Work On In This Page , //
    getData();
    super.onInit();
  }
}
// ============================================= End Of File =========================================== //
