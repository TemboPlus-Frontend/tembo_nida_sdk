import 'app_localizations.dart';

/// The translations for sw).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  Toc get toc => TocSw();

  @override
  String get confirm => "Thibitisha";

  @override
  String get amount => "Kiasi";

  @override
  String isRequired(String name) => "$name: Ni Lazima Ujaze";

  @override
  String get yes => "Ndio";

  @override
  String get refresh => "Onyesha upya";

  @override
  String get cancel => "Ghairi";

  @override
  String get preview => "Angalia";

  @override
  String get send => "Tuma";

  @override
  String get tryAgain => "Jaribu Tena";

  @override
  String get to => "Kwenda";

  @override
  String get close => "Funga";

  @override
  String get home => "Nyumbani";

  @override
  String get account => "Akaunti";

  @override
  String get beCareful => "Kuwa Makini!";

  @override
  String get validationError => "Tafadhari angalia taarifa zako vizuri";

  @override
  String get channel => "Channel";

  @override
  String get seeAll => "Ona Yote";

  @override
  String get phone => "Namba Ya Simu";

  @override
  String get comingSoon => "Inakuja Hivi Karibuni!";

  @override
  String get no => "Hapana";

  @override
  String get show => "Onesha";

  @override
  String get next => "Endelea";

  @override
  String get from => "Kutoka";

  @override
  String get bank => "Benki";

  @override
  String get date => "Tarehe";

  @override
  String get hide => "Ficha";

  @override
  String get unknownError => "Kuna tatizo limetokea";

  @override
  String get remove => "Toa";

  @override
  String get description => "Maelezo";

  @override
  String get done => "Tayari";

  @override
  String get sendLink => "Tuma link kwa mteja";

  @override
  String get accountNumber => "Akaunti Namba";
}

class TocSw extends Toc {
  @override
  String get readTermsActions => "Soma Sheria na Masharti Yetu";

  @override
  String get readTermsConfirm => "Nimesoma na kuelewa sheria na masharti.";

  @override
  String get title => "Sheria Na Masharti";

  @override
  String get desc => "Lazima ukubali sheria na masharti kabla ya kuendelea.";
}
