import 'app_localizations.dart';

/// The translations for en).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  Toc get toc => TocEn();
}

class TocEn extends Toc {
  @override
  String get title => "Terms And Conditions";

  @override
  String get desc =>
      "You must agree to the terms and conditions before you can continue.";

  @override
  String get readTermsActions => "Read Our Terms & Conditions";

  @override
  String get readTermsConfirm =>
      "I have read and understood the terms and conditions.";
}
