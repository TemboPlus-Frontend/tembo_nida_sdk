import '../../../source.dart';

import "../common.dart";

class ProfileAPI extends BaseHTTPAPI {
  ProfileAPI() : super(root, "profile/me");

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
