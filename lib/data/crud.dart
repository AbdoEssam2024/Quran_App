import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:quran/core/class/staturequest.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String link, Map data) async {
    try {
      var response = await http.get(Uri.parse(link));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);

        return Right(responsebody);
      } else {
        return Left(StatusRequest.failure);
      }
    } catch (error) {
      return Left(StatusRequest.offlineFailure);
    }
  }
}
