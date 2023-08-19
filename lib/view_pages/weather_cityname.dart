import 'package:flutter/material.dart';

class CityName extends StatefulWidget {
  const CityName({super.key});

  @override
  State<CityName> createState() => _CityNameState();
}

class _CityNameState extends State<CityName> {
  final cityName = TextEditingController();
  late String ucityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Choose your City',
        style: TextStyle(
            fontFamily: "poppins", fontSize: 32, fontWeight: FontWeight.bold),
      )),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather/');
              },
              child: Text('Mumbai Weather right now')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/delhi/');
              },
              child: Text('Delhi Weather right now')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/london/');
              },
              child: Text('London Weather right now'))
        ],
      )),
    );
  }
}
