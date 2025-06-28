import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finyx_mobile_app/helpers/constants.dart';
import 'package:finyx_mobile_app/models/theme_state_enum.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());
  changeTheme(ThemeStateEnum state) {
    switch (state) {
      case ThemeStateEnum.light:
        sharedPreferences!.setString('theme', 'light');
        emit(AppLightTheme());
        break;
      case ThemeStateEnum.dark:
        sharedPreferences!.setString('theme', 'dark');
        emit(AppDarkTheme());
        break;
      case ThemeStateEnum.initial:
        if (sharedPreferences!.getString('theme') != null) {
          if (sharedPreferences!.getString('theme') == 'dark') {
            emit(AppDarkTheme());
          } else {
            emit(AppLightTheme());
          }
          break;
        }
    }
  }
}
