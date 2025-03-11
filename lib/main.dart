import 'package:finyx_mobile_app/routes/app_routes.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      initialRoute: '/', //set start page
      onGenerateRoute: AppRoutes.generateRoute,

    );
  }
}
