// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sw.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('sw')
  ];

  Toc get toc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'sw'].contains(locale.languageCode);

  AppLocalizations lookupAppLocalizations(Locale locale) {
    // Lookup logic when only language code is specified.
    switch (locale.languageCode) {
      case 'en':
        return AppLocalizationsEn();
      case 'sw':
        return AppLocalizationsSw();
    }

    throw FlutterError(
        'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
        'an issue with the localizations generation tool. Please file an issue '
        'on GitHub with a reproducible sample app and the gen-l10n configuration '
        'that was used.');
  }
}

abstract class Toc {
  /// No description provided for @title
  ///
  /// In en it is translated to:
  /// **Terms And Conditions**
  String get title;

  /// No description provided for @desc
  ///
  /// In en it is translated to:
  /// **You must agree to the terms and conditions before you can continue.**
  String get desc;

  /// No description provided for @readTermsActions
  ///
  /// In en it is translated to:
  /// **Read Our Terms & Conditions**
  String get readTermsActions;

  /// No description provided for @readTermsConfirm
  ///
  /// In en it is translated to:
  /// **I have read and understood the terms and conditions.**
  String get readTermsConfirm;
}
