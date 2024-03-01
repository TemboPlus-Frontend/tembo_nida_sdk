import 'app_localizations.dart';

/// The translations for sw).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  ProfileCheck get profileCheck => ProfileCheckSw();

  @override
  NinStartSession get ninStartSession => NinStartSessionSw();

  @override
  NinSteps get ninSteps => NinStepsSw();

  @override
  NinInfoPage get ninInfoPage => NinInfoPageSw();

  @override
  NinQuestionPage get ninQuestionPage => NinQuestionPageSw();

  @override
  NinSuccessPage get ninSuccessPage => NinSuccessPageSw();

  @override
  Toc get toc => TocSw();

  @override
  String get beCareful => "Kuwa Makini!";

  @override
  String get done => "Tayari";

  @override
  String isRequired(String name) => "$name: Ni Lazima Ujaze";

  @override
  String get accountNumber => "Akaunti Namba";

  @override
  String get bank => "Benki";

  @override
  String get date => "Tarehe";

  @override
  String get unknownError => "Kuna tatizo limetokea";

  @override
  String get confirm => "Thibitisha";

  @override
  String get phone => "Namba Ya Simu";

  @override
  String get amount => "Kiasi";

  @override
  String get channel => "Channel";

  @override
  String get no => "Hapana";

  @override
  String get next => "Endelea";

  @override
  String get from => "Kutoka";

  @override
  String get send => "Tuma";

  @override
  String get validationError => "Tafadhari angalia taarifa zako vizuri";

  @override
  String get hi => "Habari";

  @override
  String get preview => "Angalia";

  @override
  String get description => "Maelezo";

  @override
  String get okay => "Okay";

  @override
  String get remove => "Toa";

  @override
  String get to => "Kwenda";

  @override
  String get close => "Funga";

  @override
  String isInvalid(String name) =>
      "Tafadhali angalia $name kwa umakini. Tunadhani si sahihi.";

  @override
  String get account => "Akaunti";

  @override
  String get seeAll => "Ona Yote";

  @override
  String get tryAgain => "Jaribu Tena";

  @override
  String get comingSoon => "Inakuja Hivi Karibuni!";

  @override
  String get email => "Barua Pepe (Email)";

  @override
  String get home => "Nyumbani";

  @override
  String get show => "Onesha";

  @override
  String get refresh => "Onyesha upya";

  @override
  String get cancel => "Ghairi";

  @override
  String get yes => "Ndio";

  @override
  String get hide => "Ficha";
}

class ProfileCheckSw extends ProfileCheck {
  @override
  String get error =>
      "Kwa sababu fulani hatuwezi kupata wasifu. Fikiria kuanza tena";
}

class NinStartSessionSw extends NinStartSession {
  @override
  String get couldNotStartError => "Hatukuweza kuanzisha session";
}

class NinStepsSw extends NinSteps {
  @override
  String get me => "Hatua za kufuata";

  @override
  String get desc =>
      "Ili kuendelea kutumia huduma hii unahitaji kuthibitisha utambulisho wako wa NIDA. Hii ni kuhakikisha usalama wa pesa zako.";

  @override
  String get steps =>
      "Ingiza Namba ya NIDA:Jibu Maswali kutoka NIDA:Pata Majibu";
}

class NinInfoPageSw extends NinInfoPage {
  @override
  String get nin => "Namba ya NIDA";

  @override
  String get title => "Taarifa zako";
}

class NinQuestionPageSw extends NinQuestionPage {
  @override
  String get sendAnswerAction => "Tuma Jibu";

  @override
  String get title => "Jibu Maswali";

  @override
  String get question => "Swali";

  @override
  String get answer => "Jibu";
}

class NinSuccessPageSw extends NinSuccessPage {
  @override
  String get successMsg => "Tumethibitisha namba yako ya NIDA";
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
