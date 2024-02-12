import '../../source.dart';

import 'manager.dart';

class ThemeManager extends Manager<ThemeMode> {
  ThemeManager(super.data);

  ThemeMode get state => value;
}

// initializing
late final ThemeManager themeManager;

void initThemeManager(BuildContext context, ThemeMode mode) {
  late final ThemeMode state;
  if (mode == ThemeMode.system) {
    if (Theme.of(context).brightness == Brightness.dark) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  } else {
    state = ThemeMode.light;
  }

  try {
    themeManager = ThemeManager(state);
  } catch (_) {
    // handling LateInitializationError issues
    themeManager.update(state);
  }
}
