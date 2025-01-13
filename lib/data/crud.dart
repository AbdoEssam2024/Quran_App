import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:quran/core/class/staturequest.dart';
import 'package:quran/core/functions/checkinternet.dart';

class Crud {


  Future<Either<StatusRequest, Map>> postData(String link, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(link));
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);

          return Right(responsebody);
        } else {
          return Left(StatusRequest.failure);
        }
      } else {
        return Left(StatusRequest.offlineFailure);
      }
    } catch (error) {
      return Left(StatusRequest.serverException);
    }
  }
}
