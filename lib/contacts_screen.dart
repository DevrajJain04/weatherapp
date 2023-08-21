// import 'dart:ffi';
// import 'dart:js';
// import 'dart:math';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ContactsScreen extends StatefulWidget {
//   const ContactsScreen({super.key});

//   @override
//   State<ContactsScreen> createState() => _ContactsScreenState();
// }

// class _ContactsScreenState extends State<ContactsScreen> {
//   List<Contact> contacts = [];

//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     getContactPermission();
//   }

//   void getContactPermission() async {
//     if (await Permission.contacts.isGranted) {
//       fetchContacts();
//     } else {
//       await Permission.contacts.request();
//     }
//   }

//   void fetchContacts() async {
//     contacts = await ContactsService.getContacts(withThumbnails: true);

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Contacts"),
//       ),
//       body: isLoading == false
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: contacts.length,
//               itemBuilder: (context, index) {
//                 var phones = contacts[index].phones;
//                 return ListTile(
//                   leading: Container(
//                     height: 30,
//                     width: 30,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 7,
//                           color: Colors.white.withOpacity(0.1),
//                           offset: const Offset(-3, -3),
//                         ),
//                         BoxShadow(
//                           blurRadius: 7,
//                           color: Colors.black.withOpacity(0.7),
//                           offset: const Offset(3, 3),
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(6),
//                       color: const Color.fromARGB(255, 3, 253, 178),
//                     ),
//                   ),
//                   title: Text(
//                     (contacts[index].givenName!.isNotEmpty)
//                         ? contacts[index].givenName!
//                         : 'N.A',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.cyanAccent,
//                       fontFamily: "Poppins",
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   subtitle: Text(
//                     (contacts[index].phones!.isNotEmpty)
//                         ? contacts[index].phones![0].value!
//                         : 'N.A',
//                     style: const TextStyle(
//                       fontSize: 11,
//                       color: Color(0xffC4c4c4),
//                       fontFamily: "Poppins",
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   onTap: () {
//                     return _buildFunction(contacts[index].phones?.isNotEmpty?contacts[index].phones:"N.A");
//                   },
//                   horizontalTitleGap: 12,
//                 );
//               },
//             ),
//     );
//   }
// }

// Widget _buildFunction(List<Item> phone) {
//   List<Item> phone;
//   return ListView.builder(itemBuilder: (context, index) {
//     return Text((phone.value));
//   });
// }
