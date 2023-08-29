import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// class AlphabeticalNavigationBar extends StatelessWidget {
//   const AlphabeticalNavigationBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: 26, // A to Z
//         itemBuilder: (context, index) {
//           final letter = String.fromCharCode(65 + index);
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {},
//               child: Text(letter),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class BackupContactView extends StatefulWidget {
  const BackupContactView({Key? key}) : super(key: key);
  @override
  BackupContactViewState createState() => BackupContactViewState();
}

class BackupContactViewState extends State<BackupContactView> {
  List<Contact>? contacts;
  List<Contact>? foundContacts;
  @override
  void initState() {
    super.initState();
    getContact();
    foundContacts = contacts;
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

  // void runFilter(String enteredKeyword) {
  //   List<Contact>? results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = contacts;
  //   } else {
  //     Iterable<Contact> cont = new Contact();
  //     results = contacts?.where((cont) => cont
  //         .toJson(withPhoto: true)
  //         .toString()
  //         .contains(enteredKeyword.toLowerCase()));
  //   }
  // }

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
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  // TextField(
                  //   //   onChanged: (value) => runFilter(value),
                  //   decoration: InputDecoration(
                  //       labelText: 'search',
                  //       hoverColor: Color.fromARGB(243, 13, 138, 240),
                  //       suffixIcon: Icon(
                  //         Icons.search,
                  //         size: 30,
                  //       )),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: contacts!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Uint8List? image = contacts![index].photo;
                        String num = (contacts![index].phones.isNotEmpty)
                            ? (contacts![index].phones.first.number)
                            : "--";
                        return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      buttonPadding: const EdgeInsets.all(4),
                                      title: const Text('Detailed View'),
                                      insetPadding:
                                          EdgeInsets.symmetric(horizontal: 100),    //trying to increase size of alert dialog box 
                                      actions: [
                                        (contacts![index].photo == null)
                                            ? const CircleAvatar(
                                                child: Icon(Icons.person,
                                                    size: 30),
                                              )
                                            : CircleAvatar(
                                                backgroundImage:
                                                    MemoryImage(image!)),
                                        Text(
                                          "${contacts![index].name.first} ${contacts![index].name.last}",
                                          style: const TextStyle(
                                            fontFamily: 'Ariel',
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            launch('tel:$num');
                                          },
                                          title: Text(num,
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue)),
                                        ),
                                        Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                    'Go back to list')),
                                            FloatingActionButton(
                                              onPressed: () {
                                                final whatsappUrl =
                                                    'https://wa.me/$num';

                                                launch(whatsappUrl);
                                              },
                                              child: FaIcon(
                                                  FontAwesomeIcons.whatsapp),
                                            ),
                                          ],
                                        ),

                                        // const AlphabeticalNavigationBar(),
                                      ],
                                    );
                                  });
                            },
                            child: ListTile(
                              leading: (contacts![index].photo == null)
                                  ? const CircleAvatar(
                                      child: Icon(Icons.person))
                                  : CircleAvatar(
                                      backgroundImage: MemoryImage(image!)),
                              title: Text(
                                  "${contacts![index].name.first} ${contacts![index].name.last}"),
                              subtitle: Text(num),
                            ));
                      },
                    ),
                  ),
                ]),
              ));
  }
}
