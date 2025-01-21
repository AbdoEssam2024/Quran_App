import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/core/functions/handling_data_controller.dart';
import 'package:quran/data/readmoshaf/moshafaudiodata.dart';
import 'package:quran/data/salahtimingdata/salahtiming.dart';
import 'package:quran/data/suwarname/suwarname.dart';
import 'package:quran/data/tadaborvideo/tadabor.dart';
import 'package:quran/data/variousreadingsaudio/variousreadingsaudio.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  final Connectivity connectivity = Connectivity();

  double sectionsImageShow = 0.0;

  // Categories Data Implementation //
  MoshafAudioData readMoshafData = MoshafAudioData(Get.find());
  SuwarName suwarName = SuwarName(Get.find());
  VariousReading variousReading = VariousReading(Get.find());
  Tadabor tadabor = Tadabor(Get.find());
  SalahTiming salahTiming = SalahTiming(Get.find());

  // Full Moshaf Category Variables //
  List moshafMainData = [];
  List moshafSubData = [];
  Map<int, List> moshafAudioData = {};
  String? audioLink;
  final almoshafKamelPlayer = AudioPlayer();
  bool almoshafKamelisPlaying = false;
  Duration almoshafKamelduration = Duration.zero;
  Duration almoshafKamelposition = Duration.zero;
  double almoshafKamelsoundValue = 0.5;
  bool almoshafKamelvisibleSoundBar = false;
  StatusRequest almoshaStatusRequest = StatusRequest.loading;

  // Suwar Name Category Variables //
  List suwarNameData = [];
  StatusRequest suwarNameStatusRequest = StatusRequest.loading;

  // Salah Timing Category Variables //
  List salahTimingData = [];
  StatusRequest salahTimingStatusRequest = StatusRequest.loading;

  // Various Reading Category Variables //
  List variousReadingMainData = [];
  List variousReadingSubData = [];
  Map<int, List> variousReadingAudioData = {};
  String? variousReadingaudioLink;
  final variousReadingPlayer = AudioPlayer();
  bool variousReadingisPlaying = false;
  Duration variousReadingduration = Duration.zero;
  Duration variousReadingposition = Duration.zero;
  double variousReadingsoundValue = 0.5;
  bool variousReadingvisibleSoundBar = false;
  StatusRequest variousReadingStatusRequest = StatusRequest.loading;

  // Tadabor Category Variables //
  Map tadaborMainData = {};
  List tadaborSubData = [];
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayer;
  Duration videoPosition = Duration.zero;
  Duration videoDuration = Duration.zero;
  List<String> tadaborVideoLink = [];
  IconData videoIcon = Icons.play_arrow;
  bool showPlayIcon = true;
  StatusRequest tadaborStatusRequest = StatusRequest.loading;

  showSectionsImage() {
    sectionsImageShow = 1.0;
    update();
  }

  updateConnectionStatus(List<ConnectivityResult> connectivityResultList) {
    if (connectivityResultList.contains(ConnectivityResult.none)) {
      salahTimingStatusRequest = StatusRequest.offlineFailure;
      almoshaStatusRequest = StatusRequest.offlineFailure;
      suwarNameStatusRequest = StatusRequest.offlineFailure;
      tadaborStatusRequest = StatusRequest.offlineFailure;
      variousReadingStatusRequest = StatusRequest.offlineFailure;
    } else {
      getSalahTimingData();
      getAlmoshafKamelData();
      getSuwarNameData();
      getTadaborData();
      initializeVideoplayer();
      getVariousReadingData();
    }
    update();
  }

  initConnectivity() {
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  // Salah Timing Get Data Function //
  getSalahTimingData() async {
    salahTimingStatusRequest = StatusRequest.loading;
    var response = await salahTiming.getData();
    salahTimingStatusRequest = handlingData(response);
    if (salahTimingStatusRequest == StatusRequest.success) {
      salahTimingData.add(response['data']['timings']);
      if (salahTimingData.isNotEmpty) {
        salahTimingStatusRequest = StatusRequest.success;
      } else {
        salahTimingStatusRequest = StatusRequest.serverFailure;
      }
    }

    update();
  }

  // Almoshaf Alkamel Get Data Function //
  getAlmoshafKamelData() async {
    almoshaStatusRequest = StatusRequest.loading;
    var response = await readMoshafData.getData();
    almoshaStatusRequest = handlingData(response);
    if (almoshaStatusRequest == StatusRequest.success) {
      moshafMainData.addAll(response['reciters']);
      for (int i = 0; i < moshafMainData.length; i++) {
        moshafSubData.addAll(moshafMainData[i]['moshaf']);
      }
      if (moshafMainData.isNotEmpty && moshafSubData.isNotEmpty) {
        almoshaStatusRequest = StatusRequest.success;
      } else {
        almoshaStatusRequest = StatusRequest.serverFailure;
      }

      for (int index = 0; index < moshafSubData.length; index++) {
        Map<int, List> dt = {
          index: moshafSubData[index]['surah_list'].toString().split(",")
        };
        moshafAudioData.addAll(dt);
      }
    }

    update();
  }

  // Almoshaf Alkamel Initialize Audio Function //
  initAudiodurationAndPosition() {
    almoshafKamelPlayer.onDurationChanged.listen((Duration d) {
      almoshafKamelduration = d;
      update();
    });
    almoshafKamelPlayer.onPositionChanged.listen((Duration p) {
      almoshafKamelposition = p;
      update();
    });

    almoshafKamelPlayer.onPlayerComplete.listen((position) {
      almoshafKamelposition = Duration.zero;
      update();
    });
    almoshafKamelPlayer.onPlayerStateChanged.listen((PlayerState playerstate) {
      if (playerstate == PlayerState.playing) {
        almoshafKamelisPlaying = true;
      } else {
        almoshafKamelisPlaying = false;
      }
      update();
    });
  }

  // Almoshaf Alkamel Slider Control Function //
  seekAudioPosition(Duration pos) {
    almoshafKamelPlayer.seek(pos);
    update();
  }

  // Almoshaf Alkamel Play Audio Function //
  playAudio(int index) async {
    if (almoshafKamelisPlaying) {
      almoshafKamelPlayer.pause();
    } else {
      await almoshafKamelPlayer.play(UrlSource(
          "${moshafSubData[index]['server']}${moshafAudioData[index]![0].toString().padLeft(3, "0")}.mp3"));
    }
  }

  // Suwar Name Get Data Function //
  getSuwarNameData() async {
    suwarNameStatusRequest = StatusRequest.loading;
    var response = await suwarName.getData();
    suwarNameStatusRequest = handlingData(response);
    if (suwarNameStatusRequest == StatusRequest.success) {
      suwarNameData.addAll(response['suwar']);
      if (suwarNameData.isNotEmpty) {
        suwarNameStatusRequest = StatusRequest.success;
      } else {
        suwarNameStatusRequest = StatusRequest.serverFailure;
      }
    }
    update();
  }

  // Varios Reading Get Data Function //
  getVariousReadingData() async {
    variousReadingStatusRequest = StatusRequest.loading;
    var response = await variousReading.getData();
    variousReadingStatusRequest = handlingData(response);
    if (variousReadingStatusRequest == StatusRequest.success) {
      variousReadingMainData.addAll(response['reads']);
      for (int i = 0; i < variousReadingMainData.length; i++) {
        variousReadingSubData.addAll(variousReadingMainData[i]['moshaf']);
      }
      if (variousReadingMainData.isNotEmpty &&
          variousReadingSubData.isNotEmpty) {
        variousReadingStatusRequest = StatusRequest.success;
      } else {
        variousReadingStatusRequest = StatusRequest.serverFailure;
      }

      for (int index = 0; index < variousReadingSubData.length; index++) {
        Map<int, List> variousReadingdt = {
          index:
              variousReadingSubData[index]['surah_list'].toString().split(",")
        };
        variousReadingAudioData.addAll(variousReadingdt);
      }
    }
    update();
  }

  // Various Reading Initialize Audio Function //
  initVariousReadungAudiodurationAndPosition() {
    variousReadingPlayer.onDurationChanged.listen((Duration d) {
      variousReadingduration = d;
      update();
    });
    variousReadingPlayer.onPositionChanged.listen((Duration p) {
      variousReadingposition = p;
      update();
    });

    variousReadingPlayer.onPlayerComplete.listen((position) {
      variousReadingposition = Duration.zero;
      update();
    });

    variousReadingPlayer.onPlayerStateChanged.listen((PlayerState playerstate) {
      if (playerstate == PlayerState.playing) {
        variousReadingisPlaying = true;
      } else {
        variousReadingisPlaying = false;
      }
      update();
    });
  }

  // Various Reading Slider Control Function //
  seekVariousReadingAudioPosition(Duration pos) {
    variousReadingPlayer.seek(pos);
    update();
  }

  // AVarious Reading Play Audio Function //
  playVariousReadingAudio(int index) async {
    if (variousReadingisPlaying) {
      variousReadingPlayer.pause();
    } else {
      await variousReadingPlayer.play(UrlSource(
          "${variousReadingSubData[index]['server']}${variousReadingAudioData[index]![0].toString().padLeft(3, "0")}.mp3"));
    }
  }

  // Various Reading Adjust Audio Sound Function //
  adjustVariousReadingSound(double value) {
    variousReadingPlayer.setVolume(1.0);
    update();
  }

  // Tadabor Get Data Function //
  getTadaborData() async {
    tadaborStatusRequest = StatusRequest.loading;
    var response = await tadabor.getData();
    tadaborStatusRequest = handlingData(response);
    if (tadaborStatusRequest == StatusRequest.success) {
      tadaborMainData.addAll(response['tadabor']);
      tadaborMainData.forEach(
        (key, value) {
          tadaborSubData.add(value[0]);
        },
      );

      if (tadaborMainData.isNotEmpty && tadaborSubData.isNotEmpty) {
        tadaborStatusRequest = StatusRequest.success;
      } else {
        tadaborStatusRequest = StatusRequest.serverFailure;
      }
    }
    for (int i = 0; i < tadaborSubData.length; i++) {
      tadaborVideoLink.add(tadaborSubData[i]['video_url']);
    }
    update();
  }

  initializeVideoplayer() {
    videoController = VideoPlayerController.networkUrl(Uri.parse(
        "https://upload.mp3quran.net/tadabbor/87اهدنا_الصراط_المستقيم_-_عبدالله_العبيد.mp4"));
    initializeVideoPlayer = videoController.initialize();
    videoController.setLooping(false);
    videoController.setVolume(1.0);
    videoController.addListener(() {
      videoDuration = videoController.value.duration;
      if (videoController.value.isCompleted) {
        videoPosition = Duration.zero;
        videoIcon = Icons.play_arrow;
        showPlayIcon = !showPlayIcon;
      } else {
        videoPosition = videoController.value.position;
      }

      update();
    });
  }

  resetVideo(double pos) {
    if (videoController.value.isCompleted) {
      videoPosition = Duration.zero;
      pos = videoPosition.inSeconds.toDouble();
      videoIcon = Icons.play_arrow;
      videoController.play();
      update();
    } else {
      pos = videoPosition.inSeconds.toDouble();
      update();
    }
  }

  togglePlayIcon() {
    showPlayIcon = !showPlayIcon;
  }

  playvideos() {
    if (videoController.value.isPlaying) {
      videoIcon = Icons.pause;
      update();
    } else {
      videoIcon = Icons.play_arrow;
      update();
    }
  }

  //======================= Core Functions Used In All Widgets =======================//

  pageRoute(int index, {Map? argument}) {
    if (index == 0) {
      Get.offNamed(AppRoutesNames.readMoshafScreen, arguments: argument);
    } else if (index == 1) {
      Get.offNamed(AppRoutesNames.moshafAudio, arguments: argument);
    } else if (index == 2) {
      Get.offNamed(AppRoutesNames.suwarname, arguments: argument);
    } else if (index == 3) {
      Get.offNamed(AppRoutesNames.variousreading, arguments: argument);
    } else if (index == 4) {
      Get.offNamed(AppRoutesNames.tafsirscreen, arguments: argument);
    } else if (index == 5) {
      Get.offNamed(AppRoutesNames.tadaborScreen, arguments: argument);
    } else {
      Get.offNamed(AppRoutesNames.bestReadings, arguments: argument);
    }
  }



  @override
  void onInit() async {
    initConnectivity();
    initializeVideoplayer();
    getSalahTimingData();
    getTadaborData();
    getAlmoshafKamelData();
    getSuwarNameData();
    getVariousReadingData();
    initAudiodurationAndPosition();
    initVariousReadungAudiodurationAndPosition();

    update();
    super.onInit();
  }

  @override
  void onReady() {
    showSectionsImage();
    super.onReady();
  }

  @override
  void onClose() {
    almoshafKamelPlayer.dispose();
    variousReadingPlayer.dispose();
    videoController.dispose();
    super.onClose();
  }
}
