import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../source.dart';

final profileProvider = StateProvider<Profile?>((ref) => null);

final profileRepoProvider = Provider((ref) => _ProfileRepository(ref));

class _ProfileRepository {
  final ProviderRef ref;
  _ProfileRepository(this.ref);

  final _repo = ProfileRepository();

  Future<Profile> getProfile() async {
    final profile = await _repo.getUserProfile();

    ref.read(profileProvider.notifier).state = profile;
    return profile;
  }

  Future<Profile> updateProfile(MapSD data) async {
    final profile = await _repo.updateProfile(data);
    ref.read(profileProvider.notifier).state = profile;
    return profile;
  }
}
