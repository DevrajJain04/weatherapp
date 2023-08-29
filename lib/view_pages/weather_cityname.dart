import 'package:flutter/material.dart';

class CityName extends StatefulWidget {
  const CityName({super.key});

  @override
  State<CityName> createState() => CityNameState();
}

class CityNameState extends State<CityName> {
  final cityName = TextEditingController();
  static late String ucityName;

  @override
  void dispose() {
    super.dispose();
    cityName.dispose();
  }

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
          TextField(
            controller: cityName,
            decoration: InputDecoration(hintText: 'Enter City Name'),
          ),
          ElevatedButton(
              onPressed: () {
                ucityName = cityName.text.toString();
                Navigator.pushNamed(context, '/weather/');
              },
              child: const Text('Weather right now')),
        ],
      )),
    );
  }
}
