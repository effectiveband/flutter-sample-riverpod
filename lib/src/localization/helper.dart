import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

getThemeModeName(ThemeMode themeMode, AppLocalizations appLocalizations) {
  switch (themeMode) {
    case ThemeMode.light:
      {
        return appLocalizations.themeLight;
      }
    case ThemeMode.dark:
      {
        return appLocalizations.themeDark;
      }
    default:
      return appLocalizations.themeSystem; // appLocalizations.theme.light
  }
}
