import 'package:tembo_nida_sdk/src/logic/models/session.dart';

import 'api.dart';

class SessionRepo {
  final _api = SessionAPI();

  Future<Session> startSession(SessionCreateData data) async {
    final body = await _api.startSession(
      nin: data.nin,
      email: data.email,
      phone: data.phone,
      issueDate: data.issueDate,
      expiryDate: data.expiryDate,
    );
    return Session.fromMap(body);
  }
}
