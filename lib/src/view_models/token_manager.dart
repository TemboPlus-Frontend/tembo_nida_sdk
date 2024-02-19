import 'manager.dart';

class TokenManager extends Manager<String> {
  TokenManager(super.data);

  String get state => value;
}

// initializing
late TokenManager tokenManager;

void initTokenManager(String token) {
  try {
    tokenManager = TokenManager(token);
  } catch (_) {
    // handling LateInitializationError issues
    tokenManager.update(token);
  }
}
