import '../../source.dart';
import 'manager.dart';

class LocaleManager extends Manager<TemboLocale> {
  LocaleManager(super.data);

  void updateLocale(TemboLocale locale) => update(locale);
}

// initializing
late final LocaleManager localeManager;

void initLocaleManager(BuildContext context, TemboLocale locale) {
  final state = locale;
  try {
    localeManager = LocaleManager(state);
  } catch (_) {
    // handling LateInitializationError issues
    localeManager.update(state);
  }
}
