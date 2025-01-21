import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/core/functions/handling_data_controller.dart';
import 'package:quran/data/suwarname/suwarname.dart';

class VariousReadingSuwarController extends GetxController {
    final Connectivity connectivity = Connectivity();

  // Make Instance From (StatusRequest) Class To Handle The Response Of Data , //
  // Taking Start Value Of (none) ; //
  StatusRequest statusRequest = StatusRequest.none;

  // Variable Of (String) DataType To Recieve Specified (Qarea) Name ; //
  String qareaName = "";

  // Variable Of (String) DataType To Recieve Audio Server Link , //
  // To Pass It To Player Screen ; //
  String serverLink = "";

  // Variable Of (String) DataType To Recieve (Rewaya) Type , //
  // Belongs To The Specified (Qarea) ; //
  String rewaya = "";

  // Variable Of (List) DataType To Recieve Audio (Surah List) , //
  // Belongs To The Specified (Qarea) ; //
  List surahList = [];

  // Variable Of (List) DataType To Filter (Surah Name) , //
  // Belongs To The Specified (Qarea) From The Main (SurahData) List ; //
  List qareaSwar = [];

  // Injection Of (SuwarName) Class To Get All (Suwar Data) From The Server ; //
  SuwarName suwarName = SuwarName(Get.find());

  // Variable Of (List) DataType To Recieve (All Suwar Data) From The Server Response ; //
  List suwarNamedata = [];

  // Variable Of (List) DataType To Search Result Data ; //
  List searchResult = [];

  // Variable Of (Boolean) DataType To Check If User Use Search Is Not , //
  // It Have Start Value Of (false) And It Will Change When The User Use Search ; //
  bool isSearch = false;

  initConnectivity() {
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  updateConnectionStatus(List<ConnectivityResult> connectivityResultList) {
    if (connectivityResultList.contains(ConnectivityResult.none)) {
      statusRequest = StatusRequest.offlineFailure;
    } else {
      getData();
    }
    update();
  }

  // Function (getData) To Get The Request (All Suwar Data) From The Server , //
  getData() async {
    // Set statusRequest to (loading) Value At First Until Recieve Response From The Server , //
    statusRequest = StatusRequest.loading;

    // Variable Of (Dynamic) DataType To Recieve The Response From The Server , //
    var response = await suwarName.getData();

    // Set The The Response From The (handlnigData) Method To (statusRequest) Variable, //
    // And Start Handling Depend On The Result , //
    statusRequest = handlingData(response);

    // Condition To Handle The Exeptions If Found , //
    // First If The (statusRequest) == success , //
    if (statusRequest == StatusRequest.success) {
      // Add The (response['suwar]) To The List (suwarNameData) , //
      suwarNamedata.addAll(response['suwar']);

      // Another Nested Condition If The (statusRequest) == success , //
      // And The (suwarNamedata) Not Empty (Recieved Actual Data) , //
      if (suwarNamedata.isNotEmpty) {
        // Set The (statusRequest) = success , //
        statusRequest = StatusRequest.success;
      } else {
        // But If The List Still (Empty) Or (No Data Has Been Returned From The Server) , //
        // Set The (statusRequest) = serverFailure , //
        statusRequest = StatusRequest.serverFailure;
      }
    }
    // Declaration Of Temprorary Variable Of (List) DataType To Filter (Surah Name) , //
    // Belongs To The Specified (Qarea) From The Main (SurahData) List ; //
    List test = [];

    // Loop On The Main (suwarNameData) To Filter The Data As Map , //
    for (int i = 0; i < suwarNamedata.length; i++) {
      // Filter The Data We Need As Map Int (test) Variable , //
      test.add({
        // Add Surah Id , //
        "id": suwarNamedata[i]['id'],

        // Add Surah Name , //
        "name": suwarNamedata[i]['name'],

        // Add Surah Start Page , //
        "start": suwarNamedata[i]['start_page'],

        // Add Surah End Page , //
        "end": suwarNamedata[i]['end_page'],

        // Add Surah Type (Makkia || Madnia) , //
        "makkia": suwarNamedata[i]['makkia']
      });
    }
    // Loop On (test) Variable To Make The Filter Condition On The (test) Variables ||(Keys)||, //
    // To Get Just The Data Belongs To The (Qarea) Specified , //
    test.asMap().forEach((key, value) {
      // Loop On (surahList) Variable To Make The Filter Condition On The (surahList) ||(Data)||, //
      for (int i = 0; i < surahList.length; i++) {
        // Make The Condition (If The Keys (Suwar Number) Founded In The (Qarea surahList)) , //
        if ((key + 1).toString() == (surahList[i])) {
          // Add The Indexs Which Matches The Condition With Its Data To (qareaSwar) Variable , //
          // So Now We Have A list Of The (Complete Suwar Data) Which Belong To The Specified (Qarea) ; //
          qareaSwar.add(value);
        }
      }
    });
    update();
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
  searchsuwar(String value) {
    // First We Will Be Sure The Result List Don't Contain Any Stuck Data , //
    // By Clearing The List Firstly When The Function Being Excuted , //
    searchResult.clear();
    // Declare Temprorary Variable Of (List) DataType To Recieve The Results , //
    // From The Loop We Will Start Next , //
    List result = [];
    // Starting Loop On (qareaSwar) List , //
    for (int i = 0; i < qareaSwar.length; i++) {
      // Condition Means That If The Main (qareaSwar) In Index [i] In Key ['name'] , //
      // That Key Referes To The (Sura Name) , Contains Any Letters That User Entered , //
      if (qareaSwar[i]['name'].toString().contains(value)) {
        // Add The Data Matches The Search To The Temprorary Variable (result) , //
        result.add(qareaSwar[i]);
      }
    }
    // At The End Add All Data Matches The Search To The (searchResult) List , //
    // To Start Showing The Result At The Ui Page ; //
    searchResult.addAll(result);

    update();
  }

  // This Function Will Allow The User To Navigate To The Play Screen Page , //
  // And It Will Pass Some Information To It , //
  // First We Have Parameter (index) That Will Get It's Value From The Ui Page , //
  // To Specify Which (Surah) That The User Choose , //
  // And It's Depend On The The Way Which User Take To Choose , //
  // (From Local Ui) Or (From Search Option) , //
  goToPlayScreen(int index) {
    Get.toNamed(AppRoutesNames.variousreadingplayscreen,
        // First We Will Check If The User Choose From (Search Option) Or (Local Ui) , //
        // From The (isSearch) Variable , //
        // If The (isSearch) Variable Value (true) , //
        // That Means That The User Used The (Search Option) So , //
        arguments: isSearch
            ? {
                // Send The (Surah Id) From The (searchResult) List Variable, //
                "surah_id": searchResult[index]['id'],

                // Send The (Qarea Suwar) From The (qareaSwar) List Variable, //
                "sura_name": qareaSwar,
                // Send The (Qarea Name) From The (qareaName) String Variable , //
                "qarea_name": qareaName,
                // Send The (Audio Server Link) From The (serverLink) String Variable , //
                "server_link": serverLink,
                // Send The (Qarea Surah List) From The (surahList) List Variable, //
                "sura_link": surahList
              }
            : {
                // If The (isSearch) Variable Value (false) , //
                // That Means That The User Don't Use The (Search Option) So , //
                // Send The Surah Index From The (index) Parameter Returned From (Local Ui) , //
                "index": index,
                // Set The (Surah Id) To (0) And Will Check On It In The Next Page , //
                "surah_id": 0,
                // Send The (Qarea Suwar) From The (qareaSwar) List Variable, //
                "sura_name": qareaSwar,
                // Send The (Qarea Name) From The (qareaName) String Variable , //
                "qarea_name": qareaName,
                // Send The (Audio Server Link) From The (serverLink) String Variable , //
                "server_link": serverLink,
                // Send The (Qarea Surah List) From The (surahList) List Variable ; //
                "sura_link": surahList
              });
  }

  // This Function Allows User To Get Back If Want To Choose Another (Qarea) , //
  goToMoshafAudio() {
    // Route Back Without Keep The Page In The Stack , //
    Get.offNamed(AppRoutesNames.variousreading);
    // Delete The Page Controller To Save The Memory , //
    Get.delete<VariousReadingSuwarController>();
  }

  // This Function Excuted Automatically When Entered To The Page , //
  // And We Will Excute Some Methods Here To Get Data We Need In This Page , //
  @override
  void onInit() {
    initConnectivity();
    // Frist We Excuted The Function (getData) To Send Request To The Server , //
    // And Get The Main Data That We Will Work On In This Page , //
    getData();
    // Get (Qarea Name) Which Choosed By User In The Previous Page , //
    // And Set The Value To (qareaName) String Variable , //
    qareaName = Get.arguments["qareaName"];
    // Get (Rewya Type) That Belongs To The (Qarea) Which Choosed By User In The Previous Page , //
    // And Set The Value To (rewaya) String Variable , //
    rewaya = Get.arguments["rewaya"];
    // Get (Audio Server Link) To Use It In The Next Page To Excute The Audios Files , //
    serverLink = Get.arguments["serverlink"];
    // Get (Surah List) That Belongs To The (Qarea) Which Choosed By User In The Previous Page , //
    // And Set The Value To (surahList) List Variable , //
    surahList.addAll(Get.arguments["surahlist"].toString().split(",").toList());

    isSearch = false;
    super.onInit();
  }
}
// ============================================= End Of File =========================================== //
