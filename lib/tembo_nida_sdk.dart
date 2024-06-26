library tembo_nida_sdk;

import 'package:tembo_nida_sdk/src/view_models/locale_manager.dart';
import 'package:tembo_nida_sdk/src/view_models/navigator_manager.dart';
import 'package:tembo_nida_sdk/src/view_models/theme_manager.dart';

import 'source.dart';
import 'src/views/root_app.dart';
import 'src/views/toc_page.dart';
import 'tembo_nida_sdk.dart';

export "./src/logic/models/user.dart";

NavigatorState get prevAppRootNav => prevAppNavManager.value;

Future<NIDAUser?> startNIDAVerProcess(
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
