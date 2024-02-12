import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembo_nida_sdk/source.dart';

import '../view_models/locale_manager.dart';
import '../view_models/navigator_manager.dart';
import '../view_models/theme_manager.dart';

final sdkRootNavKey = GlobalKey<NavigatorState>();

void popBackToPrevApp<T>([T? result]) {
  sdkRootNavKey.popToFirstPage();
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
                    navigatorKey: sdkRootNavKey,
                    locale: temboLocale.locale,
                    debugShowCheckedModeBanner: false,
                    theme: theme == ThemeMode.light ? _lightTheme : _darkTheme,
                    scaffoldMessengerKey: rootMessengerKey,
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

const _kFontFamily = "IBMPlexSans";
final _lightTheme = _colorScheme.toTheme;
final _darkTheme = _darkColorScheme.toTheme;

const _light = TemboColorScheme.light();
final _colorScheme = FlexColorScheme.light(
  fontFamily: _kFontFamily,
  appBarBackground: _light.background,
  primary: _light.primary,
  onPrimary: _light.onPrimary,
  error: _light.error,
  onError: _light.onError,
  background: _light.background,
  scaffoldBackground: _light.background,
  surface: _light.surface,
  onSurface: _light.onSurface,
  onBackground: Colors.black,
  useMaterial3: true,
  useMaterial3ErrorColors: true,
  appBarStyle: FlexAppBarStyle.material,
  subThemesData: const FlexSubThemesData(
    elevatedButtonSchemeColor: SchemeColor.background,
    appBarBackgroundSchemeColor: SchemeColor.background,
  ),
);

const _dark = TemboColorScheme.dark();
final _darkColorScheme = FlexColorScheme.dark(
  fontFamily: _kFontFamily,
  primary: _dark.primary,
  onPrimary: _dark.onPrimary,
  appBarBackground: _dark.background,
  error: _dark.error,
  onError: _dark.onError,
  background: _dark.background,
  scaffoldBackground: _dark.background,
  surface: _dark.surface,
  onSurface: _dark.onSurface,
  onBackground: Colors.black87,
  useMaterial3: true,
  useMaterial3ErrorColors: true,
  appBarStyle: FlexAppBarStyle.material,
  subThemesData: const FlexSubThemesData(
    elevatedButtonSchemeColor: SchemeColor.background,
    appBarBackgroundSchemeColor: SchemeColor.background,
  ),
);
