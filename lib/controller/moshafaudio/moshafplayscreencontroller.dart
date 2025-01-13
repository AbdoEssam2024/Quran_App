import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:quran/core/constant/routes/routesname.dart';

class MoshafPlayScreenController extends GetxController {
  // (suraName) Variable Of List DataType To Get SurahNameList From Previous Page , //
  // Which Belong To The Specified (Qarea) That User Chossed Before ; //
  List suraName = [];

  // (qareaName) Variable Of String DataType To Get (Qarea) Name That User Chossed Before ; //
  late String qareaName;

  // (serverLink) Variable Of String DataType To Get SuraList Server Link Which Will Passed Later To The Player ; //
  late String serverLink;

  // (suraList) Variable Of List DataType To Get SuraList Indexes , //
  // Which Belong To The Specified (Qarea) That User Chossed Before ; //
  List suraList = [];

  // (index) Variable Of int DataType To Get The Specified Surah Which User Choose To Listen ; //
  late int index;

  // Surah Id Variable It Changes If The User Choose Surah From Search Function From Previous Page , //
  // It Still == (0) If The User Choose Surah Without Using Search ; //
  int surahId = 0;

  // Boolean Variable To Control Player To Switch Between Play And Pause , //
  bool isPlaying = false;
  // Boolean Variable To Control To Start And Stop ; //
  bool animation = false;

  // Audio Player Varibles (Audio Player Controller) , //
  final almoshafKamelPlayer = AudioPlayer();

  // Duration Of The Audio Variable , With (Zero) Strat Value //
  Duration almoshafKamelduration = Duration.zero;

  // Position Of The Audio Variable , With (Zero) Strat Value //
  Duration almoshafKamelposition = Duration.zero;

  // Variable Of (String) DataType , //
  // To Recieve (Sura Name) From Search Option ; //
  String selectedSuraNameSearch = "";

  // Function Listen To The Changes In (Duration And Position And On Audio Completed) , //
  initAudiodurationAndPosition() {
    // This Stream Update The Duration Of The Audio And Show It On The Ui , //
    almoshafKamelPlayer.onDurationChanged.listen((Duration d) {
      // Set The Duration Value To The Variable To Show It On The Ui ; //
      almoshafKamelduration = d;
      update();
    });
    // This Stream Update The Current Position Of The Player On The Seek Bar Immediately While Playing The Audio, //
    almoshafKamelPlayer.onPositionChanged.listen((Duration p) {
      // Set The Position Value To The Variable To Update The Seek Bar On The Ui ; //
      almoshafKamelposition = p;
      update();
    });
    // This Stream Moves To The Next Audio And Play It When The Previous One Is Completed, //
    almoshafKamelPlayer.onPlayerComplete.listen((position) {
      // Reset The Position To Start , //
      almoshafKamelposition = Duration.zero;
      // Excute The The Function Which Play The Next Audio ; //
      nextsurah();
      update();
    });
  }

// Function Control Changing The Current Audio In The List To (Next) Audio In The List , //
  nextsurah() {
    // Check If The User In The Last Audio In The List , //
    // Because The Index Value Can't Be (Greater) Than The Audio List Length , //
    // To Not Cause (Value Range Error) ; //
    if (index < suraList.length - 1 && index != -1) {
      // Increase The Index Value By 1, //
      index++;
      // Return The Position To Start , //
      almoshafKamelposition = Duration.zero;
      // Change The (isPlaying) Value To (false) ,
      isPlaying = false;
      // Stop The Animation To ReStart It In The Next Audio When Excuted ; //
      animation = false;
      // Excute Play Function To Start Playing The New Audio ; //
      playAudio();
    } else {
      // Return The Position To Start , //
      almoshafKamelposition = Duration.zero;
      // Change The (isPlaying) Value To (false) ,
      isPlaying = false;
      // Stop The Animation To ReStart It In The Next Audio When Excuted ; //
      animation = false;
      // Excute Stop Function To Stop Playing The List ; //
      Get.back();
    }

    update();
  }

  // Function Control Changing The Current Audio In The List To (Previous) Audio In The List , //
  prevsurah() {
    // Check If The User In The First Audio In The List , //
    // Because The Index Value Can't Be (Negative) To Not Cause (Value Range Error) ; //
    if (index != 0 && index != -1) {
      // Decrease The Index Value By 1, //
      index--;
      // Return The Position To Start , //
      almoshafKamelposition = Duration.zero;
      // Change The (isPlaying) Value To (false) ,
      isPlaying = false;
      // Stop The Animation To ReStart It In The Previous Audio When Excuted , //
      animation = false;
      // Excute Play Function To Start Playing The New Audio ; //
      playAudio();
    } else {
      // Return The Position To Start , //
      almoshafKamelposition = Duration.zero;
      // Change The (isPlaying) Value To (false) ,
      isPlaying = false;
      // Stop The Animation To ReStart It In The Next Audio When Excuted ; //
      animation = false;
      // Excute Stop Function To Stop Playing The List ; //
      Get.back();
    }
    update();
  }

  // Function Control Playing Audio Depend On Status Of (isPlaying) Variable, //
  // if The Variable (false) It Will Play The Audio And The Animation , //
  // If (true) It Will Change The Control To (Pause Audio) And Stop The Animation ; //
  playAudio() async {
    // Check If (isPlaying) Is (false) To Play //
    if (isPlaying == false) {
      // Initialize The Audio Source In The Play Mood //

      // Check If (surahId) == 0 ,//
      if (surahId == 0) {
        // (index) Will Take The Value From The Argument And Pass It To The Audio Link, //
        await almoshafKamelPlayer.play(UrlSource(
            "$serverLink${suraList[index].toString().padLeft(3, "0")}.mp3"));
      } else {
        // If (surahId) != 0 , Will Pass It To The Audio Link ; //
        await almoshafKamelPlayer.play(
            UrlSource("$serverLink${surahId.toString().padLeft(3, "0")}.mp3"));
      }

      // await almoshafKamelPlayer.play(UrlSource(
      //     "$serverLink${suraList[index].toString().padLeft(3, "0")}.mp3"));
      // Change (isplaying) Variable Value To Switch Between (Play) And (Pause) Action , //
      isPlaying = !isPlaying;
      // Change (animation) Variable Value To Start The Animation , //
      animation = !animation;
      // If (isPlaying) Is (true) It Will Active (pause) Action And Stop The Animation ; //
    } else {
      // Excute (pause) Action From The Audio Controller , //
      almoshafKamelPlayer.pause();
      // Change (isplaying) Variable Value To Switch Between (Play) And (Pause) Action , //
      isPlaying = !isPlaying;
      // Change (animation) Variable Value To Stop The Animation , //
      animation = !animation;
    }
    update();
  }

  // Function To Control The Position Of The Seek Bar , //
  // When The Player Is Playing ; //
  seekAudioPosition(Duration pos) {
    // Update The Position When It Changes In Playing ; //
    almoshafKamelPlayer.seek(pos);
    update();
  }

  // Get Sura Index From Search Result By Sura Id , //
  // If Not Selected From Search Get By Sura Index ; //
  getsurahindex() {
    // Check If (surahId) == 0 ,//
    if (surahId == 0) {
      // (index) Will Take The Value From The Argument , //
      index = Get.arguments['index'];
    } else {
      // If (surahId) != 0 , We Will Declare Temporary Map , //
      // To Get (Sura Name) That The The User Selected , //
      // To Avoid Range Error Exception , //
      Map test = suraName.asMap();
      test.forEach((key, value) {
        // Condition If (Value['id'] == (suraId || That We Get From Previous Page)) , //
        if (value['id'] == surahId) {
          // Set The Name Of The Result Matched To The String Variable (selectedSuraNameSearch) , //
          selectedSuraNameSearch = value['name'];
        }
      });
      // Set (index) == 0 ; //
      index = -1;
    }
  }

  // This Function Allows User To Get Back If Want To Choose Another (Sura) , //
  goToSudioSuwar() {
    // Route Back Without Keep The Page In The Stack , //
    Get.offNamed(AppRoutesNames.moshafAudioSuwar);
  }

  @override
  void onInit() {
    // ||Data Pasing From Audio Suwar Page|| //
    // Sura Name List Belong To The Specified (Qarea) , //
    suraName.addAll(Get.arguments['sura_name']);

    // The Specified Qarea Name , //
    qareaName = Get.arguments['qarea_name'];
    // Audio Server Link , //
    serverLink = Get.arguments['server_link'];
    // List Of Surah Belongs To The Specified (Qarea) , //
    suraList.addAll(Get.arguments['sura_link']);

    // Get Surah Id If It Selected From The Search Function , //
    // it Will Be ( 0 ) If Not Selected From Search ; //
    surahId = Get.arguments['surah_id'];

    // Excute Function To Handle Sura Will Declare By (Surah Id) if Not == 0 , Or ( Surah Index ) ; //
    getsurahindex();

    // initialize Audio Player And Play Audio Selected From Prev Page //
    initAudiodurationAndPosition();
    // Start Playing The Audio File When The User Enter To The Player Page ; //
    playAudio();
    super.onInit();
  }

  @override
  void onClose() {
    // Stop Any Audio If Still Playing When Leaving The Page , //
    almoshafKamelPlayer.stop();
    // Dispose Player Controller When Leaving The Page ; //
    almoshafKamelPlayer.dispose();
    super.onClose();
  }
}
