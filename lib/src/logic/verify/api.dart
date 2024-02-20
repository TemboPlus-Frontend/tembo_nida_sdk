import 'dart:convert';

import 'package:tembo_core/tembo_core.dart';
import 'package:tembo_nida_sdk/src/view_models/token_manager.dart';

import "../common.dart";

class IdentityVerificationAPI extends BaseHTTPAPI {
  IdentityVerificationAPI() : super(root, "onboard/verify") {
    updateToken(tokenManager.value);
  }

  Future<Map<String, dynamic>> getFirstQuestion() async {
    final result = await post("");
    return result;
  }

  Future<Map<String, dynamic>> sendAnswer(
    String questionCode,
    String answer,
  ) async {
    final data = {
      "questionCode": questionCode,
      "answer": answer,
    };
    final result = await post("", body: jsonEncode(data));
    return result;
  }
}
