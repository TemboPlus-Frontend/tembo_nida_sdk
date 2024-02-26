import 'app_localizations.dart';

/// The translations for sw).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  Toc get toc => TocSw();
}

class TocSw extends Toc {
  @override
  String get title => "Sheria Na Masharti";

  @override
  String get desc => "Lazima ukubali sheria na masharti kabla ya kuendelea.";

  @override
  String get readTermsActions => "Soma Sheria na Masharti Yetu";

  @override
  String get readTermsConfirm => "Nimesoma na kuelewa sheria na masharti.";
}
