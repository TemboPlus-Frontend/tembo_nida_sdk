import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/source.dart';
import 'package:tembo_nida_sdk/src/logic/models/user.dart';

import '../view_models/locale_manager.dart';
import '../view_models/navigator_manager.dart';
import '../view_models/theme_manager.dart';

final temboNIDASDKRootNavKey = GlobalKey<NavigatorState>();
final temboNIDASDKMessengerKey = GlobalKey<ScaffoldMessengerState>();

void popBackToPrevApp([NIDAUser? result]) {
  temboNIDASDKRootNavKey.popToFirstPage();
  prevAppNavManager.state.pop(result);
}

Future<T?> pushApp<T>(BuildContext context, String name, Widget page) async {
  return await prevAppNavManager.state.push(
    MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) {
        return ValueListenableBuilder(
          valueListenable: localeManager,
          builder: (context, temboLocale, _) {
            return ValueListenableBuilder(
              valueListenable: themeManager,
              builder: (context, theme, _) {
                return ProviderScope(
                  child: MaterialApp(
                    home: page,
                    navigatorKey: temboNIDASDKRootNavKey,
                    locale: temboLocale.locale,
                    debugShowCheckedModeBanner: false,
                    theme: getTheme(),
                    scaffoldMessengerKey: temboNIDASDKMessengerKey,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                  ),
                );
              },
            );
          },
        );
      },
    ),
  );
}
