import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/views/first_view.dart';
import 'package:finyx_mobile_app/views/splash_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      initialRoute: '/', //Set start page
      routes: {
        '/': (context) => SplashScreen(), 
        '/home': (context) => FirstScreen(), 
      },
    );
  }
}
