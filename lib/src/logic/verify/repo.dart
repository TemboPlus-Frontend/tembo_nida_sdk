import 'package:tembo_nida_sdk/src/logic/models/question.dart';
import 'package:tembo_nida_sdk/src/logic/models/result.dart';
import 'package:tembo_nida_sdk/src/logic/models/user.dart';

import 'api.dart';

class IdentityRepository {
  final _api = IdentityVerificationAPI();

  Future<Question> getFirstQuestion(String onboardId) async {
    final body = await _api.getFirstQuestion(onboardId);
    return Question.fromMap(body["result"]);
  }

  Future<(User? user, ({Result result, Question newQn})?)> sendAnswer(
    Question qn,
    String onboardId,
    String answer,
  ) async {
    final body = await _api.sendAnswer(onboardId, qn.code, answer);

    String? code;
    Question? newQn;
    User? user;

    try {
      code = body["code"];
    } catch (_) {}
    
    try {
      newQn = Question.fromMap(body["result"]);
    } catch (_) {}

    try {
      user = User.fromMap(body["result"]);
    } catch (_) {}

    if (newQn != null) {
      return (
        null,
        (
          result: Result(question: qn, answer: answer),
          newQn: newQn,
        )
      );
    }

    if (code == "00" && user != null) return (user, null);

    throw "We could not process the result";
  }
}
