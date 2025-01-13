import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/view/screen/bestreadings/bestreading.dart';
import 'package:quran/view/screen/bestreadings/bestreadingplayscreen.dart';
import 'package:quran/view/screen/home.dart';
import 'package:quran/view/screen/moshafaudio/moshafaudio.dart';
import 'package:quran/view/screen/moshafaudio/moshafaudiosuwar.dart';
import 'package:quran/view/screen/moshafaudio/playscreen.dart';
import 'package:quran/view/screen/splashscreen.dart';
import 'package:quran/view/screen/suwarname/suwarname.dart';
import 'package:quran/view/screen/tadabor/tadaborplayerscreen.dart';
import 'package:quran/view/screen/tadabor/tadaborscreen.dart';
import 'package:quran/view/screen/tafsir/tafsir.dart';
import 'package:quran/view/screen/tafsir/tafsirplayscreen.dart';
import 'package:quran/view/screen/variousreading/variousreadingplayscreen.dart';
import 'package:quran/view/screen/variousreading/variousreadingscreen.dart';
import 'package:quran/view/screen/variousreading/variousreadingsuwar.dart';

class AppRoutes {
  static List<GetPage<dynamic>> getpages = [
    // ====================== Splash Screen ========================== //
    GetPage(
      name: AppRoutesNames.splashScreen,
      page: () => SplashScreen(),
    ),

    // ======================= Home Screen =========================== //
    GetPage(name: AppRoutesNames.home, page: () => HomePage()),

    // =================== Moshaf Sudio Screens ====================== //
    GetPage(name: AppRoutesNames.moshafAudio, page: () => MoshafAudio()),
    GetPage(
        name: AppRoutesNames.moshafAudioSuwar, page: () => MoshafAudioSuwar()),
    GetPage(name: AppRoutesNames.moshafplayscreen, page: () => PlayScreen()),
    // ===================== Suwar Name Screen ======================= //
    GetPage(name: AppRoutesNames.suwarname, page: () => SuwarNameScreen()),

    // ================= Various Reading Screens ===================== //
    GetPage(
        name: AppRoutesNames.variousreading,
        page: () => VariousReadingScreen()),
    GetPage(
        name: AppRoutesNames.variousreadingSuwar,
        page: () => VariousReadingSuwar()),
    GetPage(
        name: AppRoutesNames.variousreadingplayscreen,
        page: () => VariousReadingPlayScreen()),

    // ======================== Tafsir Screen ========================= //
    GetPage(name: AppRoutesNames.tafsirscreen, page: () => TafsirScreen()),
    GetPage(
        name: AppRoutesNames.tafsirplayscreen, page: () => TafsirPlayScreen()),

    // ======================== Tadabor Screen ======================== //
    GetPage(name: AppRoutesNames.tadaborScreen, page: () => TadaborScreen()),
    GetPage(
        name: AppRoutesNames.tadaborplayerscreen,
        page: () => TadaborPlayerScreen()),
    // ====================== Best Reading Screen ====================== //
    GetPage(name: AppRoutesNames.bestReadings, page: () => BestReadingScreen()),
    GetPage(
        name: AppRoutesNames.bestReadingsplayscreen,
        page: () => BestReadingPlayerScreen()),
  ];
}
