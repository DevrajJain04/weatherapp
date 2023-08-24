import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BackupContactView extends StatefulWidget {
  const BackupContactView({Key? key}) : super(key: key);
  @override
  BackupContactViewState createState() => BackupContactViewState();
}

class BackupContactViewState extends State<BackupContactView> {
  List<Contact>? contacts;
  @override
  void initState() {
    super.initState();
    getContact();
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      setState(() {});
    } else {
      FlutterContacts.requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Your Contact List",
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: (contacts) == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: contacts!.length,
                itemBuilder: (BuildContext context, int index) {
                  Uint8List? image = contacts![index].photo;
                  String num = (contacts![index].phones.isNotEmpty)
                      ? (contacts![index].phones.first.number)
                      : "--";
                  return ListTile(
                      leading: (contacts![index].photo == null)
                          ? const CircleAvatar(child: Icon(Icons.person))
                          : CircleAvatar(backgroundImage: MemoryImage(image!)),
                      title: Text(
                          "${contacts![index].name.first} ${contacts![index].name.last}"),
                      subtitle: Text(num),
                      onTap: () {
                        AlertDialog(
                          title: Text('Detailed View'),
                          content: Text('data'),
                          actions: [
                            (contacts![index].photo == null)
                                ? const CircleAvatar(child: Icon(Icons.person))
                                : CircleAvatar(
                                    backgroundImage: MemoryImage(image!)),
                            Text(
                              "${contacts![index].name.first} ${contacts![index].name.last}",
                              style: TextStyle(
                                fontFamily: 'Ariel',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(num,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        );
                      });
                },
              ));
  }
}
