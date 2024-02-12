import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/src/logic/models/session.dart';
import 'package:tembo_nida_sdk/src/logic/models/user.dart';
import 'package:tembo_nida_sdk/src/logic/verify/repo.dart';
import 'package:tembo_nida_sdk/src/logic/models/question.dart';

import '../models/result.dart';

final verManagerProvider =
    StateNotifierProvider<VerificationManager, List<Result>>((ref) {
  return VerificationManager();
});

class VerificationManager extends StateNotifier<List<Result>> {
  VerificationManager() : super(const []);


  final _repo = IdentityRepository();

  late Session _session;
  void init(Session s) => _session = s;

  Future<Question> getFirstQuestion() async {
    final qn = await _repo.getFirstQuestion(_session.onboardId);
    return qn;
  }

  Future<({User? user, Question? newQn})> sendAnswer(
    Question qn,
    String answer,
  ) async {
    final result = await _repo.sendAnswer(qn, _session.onboardId, answer);
    if (result.$2 != null) updateState(result.$2!.result);
    return (user: result.$1, newQn: result.$2?.newQn);
  }

  void updateState(Result result) {
    final current = List<Result>.from(state);
    current.add(result);
    state = current;
  }
}
