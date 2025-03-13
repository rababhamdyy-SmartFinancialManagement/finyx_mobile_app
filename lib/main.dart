import 'package:finyx_mobile_app/app_routes.dart';
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
      initialRoute: AppRoutes.splash, //Set start page
      routes: AppRoutes.routes, 

    );
  }
}
