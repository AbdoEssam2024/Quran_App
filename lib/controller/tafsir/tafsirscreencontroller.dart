import 'package:get/get.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/core/functions/handling_data_controller.dart';
import 'package:quran/data/tafsir/tafsir.dart';

class TafsirScreenController extends GetxController {
  // Make Instance From (StatusRequest) Class To Handle The Response Of Data , //
  // Taking Start Value Of (none) ; //
  StatusRequest statusRequest = StatusRequest.none;

  // Injection Of (Tafsir) Class To Get All (Data) From The Server ; //
  Tafsir tafsir = Tafsir(Get.find());

  // Variable Of (List) DataType To Recieve All (Data) From The Server Response ; //
  List data = [];

  // Variable Of (List) DataType To Search Result Data ; //
  List searchResult = [];

  // Variable Of (Boolean) DataType To Check If User Use Search Is Not , //
  // It Have Start Value Of (false) And It Will Change When The User Use Search ; //
  bool isSearch = false;

  // Variable Of (List) DataType To Get Audio Urls ; //
  List allUrl = [];

  // Function (getData) To Get The Request (Qarea Data) From The Server , //
  getData() async {
    // Set statusRequest to (loading) Value At First Until Recieve Response From The Server , //
    statusRequest = StatusRequest.loading;

    // Variable Of (Dynamic) DataType To Recieve The Response From The Server , //
    var response = await tafsir.getData();

    // Set The The Response From The (handlnigData) Method To (statusRequest) Variable, //
    // And Start Handling Depend On The Result , //
    statusRequest = handlingData(response);

    // Condition To Handle The Exeptions If Found , //
    // First If The (statusRequest) == success , //
    if (statusRequest == StatusRequest.success) {
      // Add The (response['tafasir']) To The List (data) , //
      data.addAll(response['tafasir']['soar']);

      // Another Nested Condition If The (statusRequest) == success , //
      // And The (data) Not Empty (Not Recieved Actual Data) , //
      if (data.isNotEmpty) {
        // Declare Temporary List To Get Loop Results , //
        List allLinks = [ ] ;
        for (int i = 0; i < data.length; i++) {
          // Add The Results To The Temporary List , //
          allLinks.add(data[i]['url']);
        }

        // Store All Links In (allUrl) List To Send It To Play Screen; //
        allUrl.addAll(allLinks);
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

  // This Function Will Allow The User To Navigate To The Play Screen Page , //
  // And It Will Pass Some Information To It , //
  // First We Have Parameter (index) That Will Get It's Value From The Ui Page , //
  // To Specify Which (Surah) That The User Choose , //
  // And It's Depend On The The Way Which User Take To Choose , //
  // (From Local Ui) Or (From Search Option) , //
  goToPlayScreen(int index) {
    Get.toNamed(AppRoutesNames.tafsirplayscreen,
        // First We Will Check If The User Choose From (Search Option) Or (Local Ui) , //
        // From The (isSearch) Variable , //
        // If The (isSearch) Variable Value (true) , //
        // That Means That The User Used The (Search Option) So , //
        arguments: isSearch
            ? {
                // Send The (Id) From The (searchResult) List Variable, //
                "surah_id": searchResult[index]['id'],
                // Send The (Qarea Suwar) From The (searchResult) List Variable, //
                "sura_name": searchResult[index]['name'],
                // Send The (Qarea Surah List) From The (searchResult) List Variable, //
                "sura_link": searchResult[index]['url'],
                // Send All Data From The (data) List Variable, //
                "tafsir_data": data,
                // Send All Data From The (allUrl) List Variable, //
                "sura_list": allUrl,
                // Send The (Surah Id) From The (searchResult) List Variable, //
                "sura_id_search": searchResult[index]['sura_id']
              }
            : {
                // If The (isSearch) Variable Value (false) , //
                // That Means That The User Don't Use The (Search Option) So , //
                // Send The Surah Index From The (index) Parameter Returned From (Local Ui) , //
                "index": index,
                // Set The (Surah Id) To (0) And Will Check On It In The Next Page , //
                "surah_id": 0,
                // Send All Data From The (data) List Variable, //
                "tafsir_data": data,
                // Send All Data From The (allUrl) List Variable, //
                "sura_list": allUrl
              });
  }

  // This Function Will Allow The User To Navigate Back The Home Page , //
  gotoHome() {
    // Route Back Without Keep The Page In The Stack , //
    Get.offNamed(AppRoutesNames.home);
    // Delete The Page Controller To Save The Memory , //
    Get.delete<TafsirScreenController>();
  }

  @override
  void onInit() {
    // First We Excuted The Function (getData) To Send Request To The Server , //
    // And Get The Main Data That We Will Work On In This Page , //
    getData();
    super.onInit();
  }
}

// ============================================= End Of File =========================================== //
