import 'package:flutter/material.dart';
import 'package:weatherapp/view_pages/contacts_take2.dart';
import 'package:weatherapp/view_pages/login_page.dart';
import 'package:weatherapp/view_pages/login_success_view.dart';
import 'package:weatherapp/view_pages/weather_cityname.dart';
import 'package:weatherapp/view_pages/weather_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unicode Task',
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        home: const MyLoginPage(),
        routes: {
          '/weather/': (context) => const WeatherScreen(),
          '/loginsuccess/': (context) => const MyDashboard(),
          '/cityname/': (context) => const CityName(),
          '/contacts/': (context) => const BackupContactView(),
        });
  }
}
