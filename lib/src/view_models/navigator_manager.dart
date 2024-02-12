import '../../source.dart';

import 'manager.dart';

class NavigatorManager extends Manager<NavigatorState> {
  NavigatorManager(super.data);

  NavigatorState get state => value;
}

// initializing
late NavigatorManager prevAppNavManager;

void initNavigatorManager(BuildContext context) {
  final state = Navigator.of(context, rootNavigator: true);
  try {
    prevAppNavManager = NavigatorManager(state);
  } catch (_) {
    // handling LateInitializationError issues
    prevAppNavManager.update(state);
  }
}
