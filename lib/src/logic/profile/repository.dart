import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../source.dart';
import 'api.dart';

final profileProvider = StateProvider<Profile?>((ref) => null);

final profileRepoProvider = Provider((ref) => ProfileRepository(ref));

class ProfileRepository {
  final ProviderRef ref;
  ProfileRepository(this.ref);

  final _api = ProfileAPI();

  Future<Profile> getProfile() async {
    final result = await _api.getProfile();
    final profile = Profile.fromMap(result);

    ref.read(profileProvider.notifier).state = profile;
    return profile;
  }

  Future<Profile> updateProfile(MapSD data) async {
    final body = jsonEncode(data);
    final result = await _api.editProfile(body);
    final profile = Profile.fromMap(result);

    ref.read(profileProvider.notifier).state = profile;
    return profile;
  }
}
