import 'dart:convert';

import 'package:tembo_core/tembo_core.dart';

class IdentityVerificationAPI extends BaseHTTPAPI {
  IdentityVerificationAPI() : super("onboard/verify");

  Future<Map<String, dynamic>> getFirstQuestion(String onboardId) async {
    final data = {"onboardId": onboardId};
    final result = await post("", body: jsonEncode(data));
    return result;
  }

  Future<Map<String, dynamic>> sendAnswer(
    String onboardId,
    String questionCode,
    String answer,
  ) async {
    final data = {
      "onboardId": onboardId,
      "questionCode": questionCode,
      "answer": answer,
    };
    final result = await post("", body: jsonEncode(data));
    return result;
  }
}
