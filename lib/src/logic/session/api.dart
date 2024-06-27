import 'package:tembo_core/tembo_core.dart';

import "../common.dart";

class SessionAPI extends BaseHTTPAPI {
  SessionAPI() : super(root, "onboard");

  Future<void> initiate() async {
    void statusCodehandler(int code) {
      if (code != 200 && code != 201) {
        throw "An error happened";
      }
    }

    await post("", statusCodeHandler: statusCodehandler, checkBody: false);
  }
}
