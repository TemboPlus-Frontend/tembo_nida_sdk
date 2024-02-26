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

  /// No description provided for @confirm
  ///
  /// In en it is translated to:
  /// **Confirm**
  String get confirm;

  /// No description provided for @amount
  ///
  /// In en it is translated to:
  /// **Amount**
  String get amount;

  /// Used in forms when a certain required field is not filled
  ///
  /// In en it is translated to:
  /// **{name} is required**
  String isRequired(String name);

  /// No description provided for @yes
  ///
  /// In en it is translated to:
  /// **Yes**
  String get yes;

  /// No description provided for @refresh
  ///
  /// In en it is translated to:
  /// **Refresh**
  String get refresh;

  /// No description provided for @cancel
  ///
  /// In en it is translated to:
  /// **Cancel**
  String get cancel;

  /// No description provided for @preview
  ///
  /// In en it is translated to:
  /// **Preview**
  String get preview;

  /// No description provided for @send
  ///
  /// In en it is translated to:
  /// **Send**
  String get send;

  /// No description provided for @tryAgain
  ///
  /// In en it is translated to:
  /// **Try Again**
  String get tryAgain;

  /// No description provided for @to
  ///
  /// In en it is translated to:
  /// **To**
  String get to;

  /// No description provided for @close
  ///
  /// In en it is translated to:
  /// **Close**
  String get close;

  /// No description provided for @home
  ///
  /// In en it is translated to:
  /// **Home**
  String get home;

  /// No description provided for @account
  ///
  /// In en it is translated to:
  /// **Account**
  String get account;

  /// No description provided for @beCareful
  ///
  /// In en it is translated to:
  /// **Be careful!**
  String get beCareful;

  /// No description provided for @validationError
  ///
  /// In en it is translated to:
  /// **Please check your information carefully**
  String get validationError;

  /// No description provided for @channel
  ///
  /// In en it is translated to:
  /// **Channel**
  String get channel;

  /// No description provided for @seeAll
  ///
  /// In en it is translated to:
  /// **See All**
  String get seeAll;

  /// No description provided for @phone
  ///
  /// In en it is translated to:
  /// **Phone**
  String get phone;

  /// No description provided for @comingSoon
  ///
  /// In en it is translated to:
  /// **Coming Soon!**
  String get comingSoon;

  /// No description provided for @no
  ///
  /// In en it is translated to:
  /// **No**
  String get no;

  /// No description provided for @show
  ///
  /// In en it is translated to:
  /// **Show**
  String get show;

  /// No description provided for @next
  ///
  /// In en it is translated to:
  /// **Next**
  String get next;

  /// No description provided for @from
  ///
  /// In en it is translated to:
  /// **From**
  String get from;

  /// No description provided for @bank
  ///
  /// In en it is translated to:
  /// **Bank**
  String get bank;

  /// No description provided for @date
  ///
  /// In en it is translated to:
  /// **Date**
  String get date;

  /// No description provided for @hide
  ///
  /// In en it is translated to:
  /// **Hide**
  String get hide;

  /// No description provided for @unknownError
  ///
  /// In en it is translated to:
  /// **An unknown error happened**
  String get unknownError;

  /// No description provided for @remove
  ///
  /// In en it is translated to:
  /// **Remove**
  String get remove;

  /// No description provided for @description
  ///
  /// In en it is translated to:
  /// **Description**
  String get description;

  /// No description provided for @done
  ///
  /// In en it is translated to:
  /// **Done**
  String get done;

  /// No description provided for @sendLink
  ///
  /// In en it is translated to:
  /// **Send link to the customer**
  String get sendLink;

  /// No description provided for @accountNumber
  ///
  /// In en it is translated to:
  /// **Account Number**
  String get accountNumber;
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
}
