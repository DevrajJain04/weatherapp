import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/view_pages/login_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  MyDashboardState createState() => MyDashboardState();
}

class MyDashboardState extends State<MyDashboard> {
  SharedPreferences? logindata;
  String? username;
  String? dob;
  String? phone;
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata?.getString('username')!;
      dob = logindata?.getString('dob');
      phone = logindata?.getString('phone');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Here's ur Information !!"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Hey $username, what would you like to see today?',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  Text('We will wish you on $dob',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('And your phone number : $phone',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cityname/');
                },
                child: const Text('for real time weather')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/contacts/');
                },
                child: const Text('Contact List')),
            ElevatedButton(
              onPressed: () {
                logindata?.setBool('login', true);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyLoginPage()));
              },
              child: const Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
