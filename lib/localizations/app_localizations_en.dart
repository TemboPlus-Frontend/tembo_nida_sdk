import 'app_localizations.dart';

/// The translations for en).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  Toc get toc => TocEn();

  @override
  String get confirm => "Confirm";

  @override
  String get amount => "Amount";

  @override
  String isRequired(String name) => "$name is required";

  @override
  String get yes => "Yes";

  @override
  String get refresh => "Refresh";

  @override
  String get cancel => "Cancel";

  @override
  String get preview => "Preview";

  @override
  String get send => "Send";

  @override
  String get tryAgain => "Try Again";

  @override
  String get to => "To";

  @override
  String get close => "Close";

  @override
  String get home => "Home";

  @override
  String get account => "Account";

  @override
  String get beCareful => "Be careful!";

  @override
  String get validationError => "Please check your information carefully";

  @override
  String get channel => "Channel";

  @override
  String get seeAll => "See All";

  @override
  String get phone => "Phone";

  @override
  String get comingSoon => "Coming Soon!";

  @override
  String get no => "No";

  @override
  String get show => "Show";

  @override
  String get next => "Next";

  @override
  String get from => "From";

  @override
  String get bank => "Bank";

  @override
  String get date => "Date";

  @override
  String get hide => "Hide";

  @override
  String get unknownError => "An unknown error happened";

  @override
  String get remove => "Remove";

  @override
  String get description => "Description";

  @override
  String get done => "Done";

  @override
  String get sendLink => "Send link to the customer";

  @override
  String get accountNumber => "Account Number";
}

class TocEn extends Toc {
  @override
  String get readTermsActions => "Read Our Terms & Conditions";

  @override
  String get readTermsConfirm =>
      "I have read and understood the terms and conditions.";

  @override
  String get title => "Terms And Conditions";

  @override
  String get desc =>
      "You must agree to the terms and conditions before you can continue.";
}
