import 'package:tembo_core/tembo_core.dart';
import 'package:tembo_nida_sdk/src/view_models/token_manager.dart';

import "../common.dart";

class SessionAPI extends BaseHTTPAPI {
  SessionAPI() : super(root, "onboard") {
    updateToken(tokenManager.value);
  }

  Future<void> initiate() async {
    void statusCodehandler(int code) {
      if (code != 200 && code != 201) {
        throw "An error happened";
      }
    }

    await post("", statusCodeHandler: statusCodehandler, checkBody: false);
  }
}
