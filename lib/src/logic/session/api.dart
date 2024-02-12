import 'dart:convert';

import '../../../source.dart';
import '../_api.dart';

class SessionAPI extends BaseHTTPAPI {
  SessionAPI() : super("onboard");

  Future<Map<String, dynamic>> startSession({
    required String nin,
    required String email,
    required ParsedPhoneNumber phone,
    required DateTime issueDate,
    required DateTime expiryDate,
  }) async {
    const dateFormat = "yyyy-MM-ddThh:mm:ss";
    final number = "255${phone.numberWithoutCountryPrefix}";

    final data = {
      "nin": nin,
      "phoneNumber": number,
      "email": email,
      "cardIssueDate": issueDate.toUtc().format(dateFormat),
      "cardExpiryDate": expiryDate.toUtc().format(dateFormat),
    };
    final result = await post("", body: jsonEncode(data));
    return result;
  }
}
