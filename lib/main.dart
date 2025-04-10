import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finyx_mobile_app/app_routes.dart';
import 'cubit/navigation_cubit.dart'; 
import 'cubit/chart_cubit.dart';
import 'models/user_type.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => ChartCubit(userType: UserType.individual)), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes, 
      ),
    );
  }
}
