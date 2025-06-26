import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  Locale? locale;
  AppLocalizations({this.locale});
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> jsonStrings;
  Future loadLangJson() async {
    String strings = await rootBundle.loadString(
      'assets/lang/${locale!.languageCode}.json',
    );
    Map<String, dynamic> jsons = json.decode(strings);
    jsonStrings = jsons.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return jsonStrings[key] ?? "";
  }

  bool has(String key) {
    return jsonStrings.containsKey(key);
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale: locale);
    await appLocalizations.loadLangJson();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
