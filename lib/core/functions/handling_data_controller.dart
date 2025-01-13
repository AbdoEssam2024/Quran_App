import 'package:quran/core/class/staturequest.dart';

handlingData(response) {
  if (response is StatusRequest) {
    if (response == StatusRequest.offlineFailure) {
      return response;
    } else if (response == StatusRequest.serverFailure) {
      return response;
    } else if (response == StatusRequest.serverException) {
      return response;
    } else if (response == StatusRequest.failure) {
      return response;
    }
  } else {
    return response = StatusRequest.success;
  }

}
