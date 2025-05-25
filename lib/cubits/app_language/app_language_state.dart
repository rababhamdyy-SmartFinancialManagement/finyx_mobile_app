part of 'app_language_cubit.dart';

abstract class AppLanguageState {}

final class AppLanguageInitial extends AppLanguageState {}

class AppChangeLanguage extends AppLanguageState {
  final String? languageCode;
  AppChangeLanguage({this.languageCode});
}
