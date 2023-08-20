import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/contacts_screen.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: MyLoginPage(),
        routes: {
          '/weather/': (context) => const WeatherScreen(),
          '/loginsuccess/': (context) => const MyDashboard(),
          '/cityname/': (context) => const CityName(),
          '/contacts/': (context) => const ContactsScreen(),
        });
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    //print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beautiful Details of Beautiful People"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Get-in Form",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Center(
              child: Text(
                "INFORMATION(Cause u have no enemies! to hide it from)",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text;
                String password = passwordController.text;
                if (username != '' && password != '') {
                  //print('Successfull');
                  logindata.setBool('login', false);
                  logindata.setString('username', username);
                  Navigator.pushNamed(context, '/loginsuccess/');
                }
              },
              child: const Text("Get-In"),
            ),
          ],
        ),
      ),
    );
  }
}
