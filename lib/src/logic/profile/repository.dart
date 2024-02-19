import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../source.dart';
import '../models/profile.dart';
import 'api.dart';

final profileRepoProvider = Provider((ref) => ProfileRepository());

class ProfileRepository {
  final _api = ProfileAPI();

  Future<Profile> getProfile() async {
    final result = await _api.getProfile();
    final profile = Profile.fromMap(result);
    return profile;
  }

  Future<Profile> updateProfile(MapSD data) async {
    final body = jsonEncode(data);
    final result = await _api.editProfile(body);
    final profile = Profile.fromMap(result);
    return profile;
  }
}
