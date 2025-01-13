import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/constant/routes/routesname.dart';
import 'package:video_player/video_player.dart';

class BestReadingPlayScreenController extends GetxController {
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayer;
  Duration videoPosition = Duration.zero;
  Duration videoDuration = Duration.zero;
  IconData videoIcon = Icons.play_arrow;
  bool showPlayIcon = true;
  StatusRequest tadaborStatusRequest = StatusRequest.loading;

  int index = 0;
  String reciterName = "";
  List videosUrl = [];

  initializeVideoplayer() {
    videoController = VideoPlayerController.networkUrl(
        Uri.parse(videosUrl[index]['video_url']));
    initializeVideoPlayer = videoController.initialize();
    videoController.setLooping(false);
    videoController.setVolume(1.0);
    videoController.play();
    playvideos();
    togglePlayIcon();
    videoController.addListener(() {
      videoDuration = videoController.value.duration;
      if (videoController.value.isPlaying) {
        videoIcon = Icons.pause;
      } else {
        videoIcon = Icons.play_arrow;
      }
      if (videoController.value.isCompleted) {
        videoPosition = Duration.zero;
        videoIcon = Icons.play_arrow;
        togglePlayIcon();
        if ((index + 1) < videosUrl.length) {
          index++;
          initializeVideoplayer();
          videoController.play();
        } else {
          goToBestReadingScreen;
        }
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

  goToBestReadingScreen() {
    videoController.pause();
    Get.offNamed(AppRoutesNames.bestReadings);
  }

  @override
  void onInit() {
    reciterName = Get.arguments['qarea_name'];
    videosUrl.addAll(Get.arguments['videos']);
    initializeVideoplayer();
    super.onInit();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
