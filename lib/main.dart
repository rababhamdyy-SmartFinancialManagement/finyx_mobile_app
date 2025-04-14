import 'package:finyx_mobile_app/cubits/app_theme/app_theme_cubit.dart';
import 'package:finyx_mobile_app/helpers/constants.dart';
import 'package:finyx_mobile_app/models/theme_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/bottom nav/navigation_cubit.dart';
import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finyx_mobile_app/theme/app_theme.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => ChartCubit(userType: UserType.individual)),
        BlocProvider(create: (_) => PriceCubit()),
        BlocProvider(create: (_) => AppThemeCubit()..changeTheme(ThemeStateEnum.initial)),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          ThemeData? themeData;

          if (state is AppDarkTheme) {
            themeData = AppTheme.darkTheme;
          } else if (state is AppLightTheme) {
            themeData = AppTheme.lightTheme;
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            initialRoute: '/',
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
