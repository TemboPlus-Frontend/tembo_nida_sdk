import 'package:tembo_nida_sdk/src/view_models/token_manager.dart';

import '../../../source.dart';

const root = "https://gateway.temboplus.com/temboplus";

class ProfileAPI extends BaseHTTPAPI {
  ProfileAPI() : super(root, "profile/me") {
    updateToken(tokenManager.value);
  }

  Future<MapSD> editProfile(String body) async {
    final result = await patch<MapSD>("", body);
    if (result["reason"] != null) throw result["reason"];
    return result;
  }

  Future<MapSD> getProfile() async {
    final result = await get<MapSD>("");
    return result;
  }
}
