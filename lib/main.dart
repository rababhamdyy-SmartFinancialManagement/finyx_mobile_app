import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/cubits/bottom%20nav/navigation_cubit.dart';
import 'package:finyx_mobile_app/cubits/home/chart_cubit.dart';
import 'package:finyx_mobile_app/cubits/wallet/price_cubit.dart';
import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:finyx_mobile_app/routes/app_routes.dart';

void main() {
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
        BlocProvider(create: (_) => ProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        initialRoute: '/',
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
