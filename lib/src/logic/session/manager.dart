import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/session/repo.dart';
import 'package:tembo_nida_sdk/src/logic/models/session.dart';

final sessionManagerProvider =
    StateNotifierProvider<SessionManager, Session>((ref) {
  return SessionManager();
});

class SessionManager extends StateNotifier<Session> {
  SessionManager() : super(const Session.initial());

  final _repo = SessionRepo();

  Future<Session> start(SessionCreateData data) async {
    final session = await _repo.startSession(data);
    state = session;
    return session;
  }
}
