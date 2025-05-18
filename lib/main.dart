import 'package:finyx_mobile_app/cubits/app_theme/app_theme_cubit.dart';
import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:finyx_mobile_app/helpers/constants.dart';
import 'package:finyx_mobile_app/models/theme_state_enum.dart';
import 'package:finyx_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'package:finyx_mobile_app/cubits/bottom%20nav/navigation_cubit.dart';
import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/routes/app_routes.dart';

Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  shared_preferences = await SharedPreferences.getInstance();

  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  await _initializeNotifications();

  runApp(MyApp(notificationsPlugin: notificationsPlugin));
}

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  const MyApp({super.key, required this.notificationsPlugin});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => ChartCubit(userType: UserType.individual)),
        BlocProvider(create: (_) => PriceCubit()),
        BlocProvider(create: (_) => ProfileCubit(notificationsPlugin)),
        BlocProvider(
          create: (_) => AppThemeCubit()..changeTheme(ThemeStateEnum.initial),
        ),
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
