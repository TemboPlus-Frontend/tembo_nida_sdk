import 'package:tembo_nida_sdk/src/logic/models/question.dart';
import 'package:tembo_nida_sdk/src/logic/models/result.dart';

import 'api.dart';

class IdentityRepository {
  final _api = IdentityVerificationAPI();

  Future<Question> getFirstQuestion(String onboardId) async {
    final body = await _api.getFirstQuestion(onboardId);
    return Question.fromMap(body["result"]);
  }

  Future<(bool? successfullyVerified, ({Result result, Question newQn})?)>
      sendAnswer(
    Question qn,
    String onboardId,
    String answer,
  ) async {
    final body = await _api.sendAnswer(onboardId, qn.code, answer);

    String? code;
    Question? newQn;
    try {
      code = body["code"];
      newQn = Question.fromMap(body["result"]);
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

    if (code == "00") return (true, null);

    throw "We could not process the result";
  }
}
