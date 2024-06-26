import 'app_localizations.dart';

/// The translations for en).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  ProfileCheck get profileCheck => ProfileCheckEn();

  @override
  NinStartSession get ninStartSession => NinStartSessionEn();

  @override
  NinSteps get ninSteps => NinStepsEn();

  @override
  NinInfoPage get ninInfoPage => NinInfoPageEn();

  @override
  NinQuestionPage get ninQuestionPage => NinQuestionPageEn();

  @override
  NinSuccessPage get ninSuccessPage => NinSuccessPageEn();

  @override
  NinFailurePage get ninFailurePage => NinFailurePageEn();

  @override
  Toc get toc => TocEn();

  @override
  String get next => "Next";

  @override
  String get done => "Done";

  @override
  String get comingSoon => "Coming Soon!";

  @override
  String get bank => "Bank";

  @override
  String get show => "Show";

  @override
  String get confirm => "Confirm";

  @override
  String get cancel => "Cancel";

  @override
  String get preview => "Preview";

  @override
  String get date => "Date";

  @override
  String get okay => "Okay";

  @override
  String get email => "Email";

  @override
  String get unknownError => "An unknown error happened";

  @override
  String get remove => "Remove";

  @override
  String get account => "Account";

  @override
  String get seeAll => "See All";

  @override
  String get validationError => "Please check your information carefully";

  @override
  String get yes => "Yes";

  @override
  String get hide => "Hide";

  @override
  String get send => "Send";

  @override
  String get description => "Description";

  @override
  String get amount => "Amount";

  @override
  String get close => "Close";

  @override
  String get accountNumber => "Account Number";

  @override
  String get no => "No";

  @override
  String get tryAgain => "Try Again";

  @override
  String get refresh => "Refresh";

  @override
  String get from => "From";

  @override
  String get to => "To";

  @override
  String isRequired(String name) => "$name is required";

  @override
  String get home => "Home";

  @override
  String get beCareful => "Be careful!";

  @override
  String get phone => "Phone";

  @override
  String isInvalid(String name) =>
      "Please check $name carefully. We think it is invalid.";

  @override
  String get channel => "Channel";

  @override
  String get hi => "Hi";
}

class ProfileCheckEn extends ProfileCheck {
  @override
  String get error =>
      "For some reason we can't find the profile. Consider starting again";
}

class NinStartSessionEn extends NinStartSession {
  @override
  String get couldNotStartError => "We could not start a session";
}

class NinStepsEn extends NinSteps {
  @override
  String get me => "Steps to follow";

  @override
  String get desc =>
      "To continue using this service you need to confirm your NIDA identity. This is to ensure the safety of your money.";

  @override
  String get steps =>
      "Enter NIDA Number:Answer Questions from NIDA:Get Answers";
}

class NinInfoPageEn extends NinInfoPage {
  @override
  String get title => "Your details";

  @override
  String get nin => "NIN Number";
}

class NinQuestionPageEn extends NinQuestionPage {
  @override
  String get answer => "Answer";

  @override
  String get sendAnswerAction => "Send Answer";

  @override
  String get title => "Answer Questions";

  @override
  String get question => "Question";
}

class NinSuccessPageEn extends NinSuccessPage {
  @override
  String get successMsg => "We have successfully verified your NIN Number";
}

class NinFailurePageEn extends NinFailurePage {
  @override
  String get msg =>
      "Tumeshindwa kuthibitisha utambulisho wako. Kuna maswali hujayajibu kwa usahihi. Tafadhari jaribu tena baadae";
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
