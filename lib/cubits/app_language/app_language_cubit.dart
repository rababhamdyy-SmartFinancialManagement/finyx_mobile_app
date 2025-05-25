import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finyx_mobile_app/helpers/constants.dart';
import 'package:finyx_mobile_app/models/langaugeEventType.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(AppLanguageInitial());
  // ignore: non_constant_identifier_names
  AppLanguageFunc(LangaugeEventEnums eventType) {
    switch (eventType) {
      case LangaugeEventEnums.IntialLangauge:
        if (shared_preferences!.getString('lang') != null) {
          if (shared_preferences!.getString('lang') == 'en') {
            emit(AppChangeLanguage(languageCode: 'en'));
          } else {
            emit(AppChangeLanguage(languageCode: 'ar'));
          }
        }
        break;
      case LangaugeEventEnums.ArbicLanguage:
        shared_preferences!.setString('lang', 'ar');
        emit(AppChangeLanguage(languageCode: 'ar'));
        break;
      case LangaugeEventEnums.EnglishLanguage:
        shared_preferences!.setString('lang', 'en');
        emit(AppChangeLanguage(languageCode: 'en'));
        break;
    }
  }
}
