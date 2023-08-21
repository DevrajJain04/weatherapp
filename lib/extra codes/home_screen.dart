import 'package:flutter/material.dart';
import 'package:weatherapp/extra%20codes/user_details.dart';

class HomeScreen extends StatelessWidget {
  final List<UserDetails> users = [
    UserDetails(name: 'Ramesh Verma', phone: 22233444, email: 'adsad@hedd.com'),
    UserDetails(name: 'suresh verma', phone: 34333444, email: '3232@hedd.com'),
    // {"name": "Ramesh Verma", "phone": 123456, "email": 'ramesh@ramesh.com'},
    // {"name": "Suresh Sharma", "phone": 789123, "email": 'suresh@ramesh.com'},
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact App'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/about',
                      arguments: users[index]);
                },
                leading: const Icon(Icons.person),
                title: Text(users[index].name),
              ),
            );
          },
          itemCount: users.length,
        ));
  }
}
