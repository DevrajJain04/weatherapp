import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weatherapp/view_pages/user_details.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserDetails;
    final name = args.name;
    final phone = args.phone;
    final email = args.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(email),
            const SizedBox(
              height: 20,
            ),
            Text('Phone - $phone'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.call),
        onPressed: () async {
          final url = 'tel:$phone';
          await canLaunch(url)
              ? await launch(url)
              : throw 'Could not launch $url';
        },
      ),
    );
  }
}
