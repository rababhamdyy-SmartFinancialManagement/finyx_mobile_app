import 'package:bloc/bloc.dart';
import 'package:finyx_mobile_app/helpers/constants.dart';
import 'package:finyx_mobile_app/models/language_event_type.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(AppLanguageInitial());
  // ignore: non_constant_identifier_names
  AppLanguageFunc(LangaugeEventEnums eventType) {
    switch (eventType) {
      case LangaugeEventEnums.IntialLangauge:
        if (sharedPreferences!.getString('lang') != null) {
          if (sharedPreferences!.getString('lang') == 'en') {
            emit(AppChangeLanguage(languageCode: 'en'));
          } else {
            emit(AppChangeLanguage(languageCode: 'ar'));
          }
        }
        break;
      case LangaugeEventEnums.ArbicLanguage:
        sharedPreferences!.setString('lang', 'ar');
        emit(AppChangeLanguage(languageCode: 'ar'));
        break;
      case LangaugeEventEnums.EnglishLanguage:
        sharedPreferences!.setString('lang', 'en');
        emit(AppChangeLanguage(languageCode: 'en'));
        break;
    }
  }
}
