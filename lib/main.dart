import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/view_pages/contacts_take2.dart';
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

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  MyLoginPageState createState() => MyLoginPageState();
}

class MyLoginPageState extends State<MyLoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  var dobController = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
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
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dobController.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Beautiful Details of Beautiful People",
          style: TextStyle(
            color: Color.fromARGB(246, 89, 160, 240),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Get-in Form",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    label: Text('username'),
                    hintText: 'example: John Wick'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9)),
                    label: Text('Phone Number'),
                    hintText: 'XXXXX XXXXX'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: dobController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.calendar_month),
                    ),
                    hintText: 'dd-mm-yyyy',
                    label: Text('Date Of Birth')),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text;
                int phone = phoneController.hashCode;
                String dob = dobController.text;
                if (username != '' && phone != hashCode && dob != '') {
                  logindata.setBool('login', false);
                  logindata.setString('username', username);
                  logindata.setInt('phone', phone);
                  logindata.setString('dob', dob);
                  Navigator.pushNamed(context, '/loginsuccess/');
                }
              },
              child: const Text("Get-In"),
            ),
            ElevatedButton(
              onPressed: () {
                logindata.setBool('login', true);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyLoginPage()));
              },
              child: const Text('Reset Fields'),
            ),
          ],
        ),
      ),
    );
  }
}
