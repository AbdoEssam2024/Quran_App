import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:quran/data/tadaborvideo/tadabor.dart';
import 'package:video_player/video_player.dart';

class TadaborPlayScreenController extends GetxController {
  Tadabor tadabor = Tadabor(Get.find());
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayer;
  Duration videoPosition = Duration.zero;
  Duration videoDuration = Duration.zero;
  List<String> tadaborVideoLink = [];
  IconData videoIcon = Icons.play_arrow;
  bool showPlayIcon = true;
  StatusRequest tadaborStatusRequest = StatusRequest.loading;

  String reciterName = "";
  String soraName = "";
  String videoUrl = "";

  initializeVideoplayer() {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    initializeVideoPlayer = videoController.initialize();
    videoController.setLooping(false);
    videoController.setVolume(1.0);
    videoController.play();
    togglePlayIcon();
    videoController.addListener(() {
      videoDuration = videoController.value.duration;
      if (videoController.value.isCompleted) {
        videoPosition = Duration.zero;
        videoIcon = Icons.play_arrow;
        togglePlayIcon();
        goToTadaborScreen();
      } else {
        videoPosition = videoController.value.position;
      }

      update();
    });
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

  goToTadaborScreen() {
    videoController.pause();
    Get.offNamed(AppRoutesNames.tadaborScreen);
  }

  @override
  void onInit() {
    reciterName = Get.arguments["qarea_name"];
    soraName = Get.arguments["sura_name"];
    videoUrl = Get.arguments["video_link"];
    initializeVideoplayer();
    super.onInit();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
