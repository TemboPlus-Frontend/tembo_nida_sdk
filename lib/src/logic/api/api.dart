import 'dart:convert';

import 'base_http_api.dart';

class IdentityVerificationAPI extends BaseHTTPAPI {
  IdentityVerificationAPI() : super();

  Future<Map<String, dynamic>> startSession(String nin) async {
    final data = {
      "nin": nin,
       "phoneNumber": "255712345678",
  "email": "customer@example.com",
  "cardIssueDate": "2010-01-19",
  "cardExpiryDate": "2024-06-20"
    };
    final result = await post("onboard", body: jsonEncode(data));
    return result;
  }

  Future<Map<String, dynamic>> sendAnswer(
    String nin,
    String questionCode,
    String answer,
  ) async {
    final data = {
      "nin": nin,
      "questionCode": questionCode,
      "answer": answer,
    };
    final result = await post("onboard", body: jsonEncode(data));
    return result;
  }
}
