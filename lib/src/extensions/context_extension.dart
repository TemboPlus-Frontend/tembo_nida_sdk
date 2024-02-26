import 'package:flutter/material.dart';

import '../../localizations/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this)!;
}
