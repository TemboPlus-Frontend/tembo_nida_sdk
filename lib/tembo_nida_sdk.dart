library tembo_nida_sdk;

import 'package:tembo_nida_sdk/src/view_models/locale_manager.dart';
import 'package:tembo_nida_sdk/src/view_models/navigator_manager.dart';
import 'package:tembo_nida_sdk/src/view_models/theme_manager.dart';

import 'source.dart';
import 'src/views/root_app.dart';
import 'src/views/toc_page.dart';

export 'package:tembo_core/tembo_core.dart';

NavigatorState get rootNavigator => prevAppNavManager.value;

Future<T?> startVerificationProcess<T>(
  BuildContext context, {
  /// Sets the language to be used.
  ///
  /// Only Swahili(sw) and English(en) are currently supported
  TemboLocale locale = TemboLocale.en,

  /// Sets the themeMode for all pages in the SDK
  ThemeMode themeMode = ThemeMode.system,
}) async {
  initNavigatorManager(context);
  initLocaleManager(context, locale);
  initThemeManager(context, themeMode);

  return await pushApp(context, "toc", const TOCPage());
}
