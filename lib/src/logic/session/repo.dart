import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api.dart';

final sessionRepoProvider = Provider((ref) => SessionRepository());

class SessionRepository {
  final _api = SessionAPI();

  Future<void> initiateSession() async {
    await _api.initiate();
  }
}
