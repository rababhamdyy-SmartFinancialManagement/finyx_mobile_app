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
        shared_preferences!.setString('theme', 'light');
        emit(AppLightTheme());
        break;
      case ThemeStateEnum.dark:
        shared_preferences!.setString('theme', 'dark');
        emit(AppDarkTheme());
        break;
      case ThemeStateEnum.initial:
        if (shared_preferences!.getString('theme') != null) {
          if (shared_preferences!.getString('theme') == 'dark') {
            emit(AppDarkTheme());
          } else {
            emit(AppLightTheme());
          }
          break;
        }
    }
  }
}
