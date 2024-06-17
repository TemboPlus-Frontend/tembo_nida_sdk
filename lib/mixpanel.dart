import 'source.dart';

class SDKMixPanelManager {
  final _mixpanel = MixPanelManager.instance;

  SDKMixPanelManager._();
  static SDKMixPanelManager instance = SDKMixPanelManager._();

  Future<void> trackNIDAVERFailure(Profile profile) async {
    final props = <String, String>{};
    props["PROFILE_ID"] = profile.id;
    props["PROFILE_NAME"] = profile.name;
    props["PROFILE_EMAIL"] = profile.email ?? "";
    props["PROFILE_PHONE"] = profile.phone?.label ?? "";

    await _mixpanel.track("NIDA_VER_FAILED", props);
  }

  Future<void> trackNIDAVERSuccess(Profile profile) async {
    final props = <String, String>{};
    props["PROFILE_ID"] = profile.id;
    props["PROFILE_NAME"] = profile.name;
    props["PROFILE_EMAIL"] = profile.email ?? "";
    props["PROFILE_PHONE"] = profile.phone?.label ?? "";

    await _mixpanel.track("NIDA_VER_SUCCESS", props);
  }
}
