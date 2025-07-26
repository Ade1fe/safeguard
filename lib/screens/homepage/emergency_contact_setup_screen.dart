// import 'package:flutter/material.dart';
// import 'package:safeguard/components/layout.dart';
// import 'package:safeguard/screens/homepage/add_edit_contact_screen.dart'; // Import the new screen
// import 'package:safeguard/theme/theme.dart';
// import 'package:safeguard/widgets/custom_button.dart';

// // Define a simple model for an Emergency Contact
// class EmergencyContact {
//   String id; // Unique ID for list keys
//   String name;
//   String phoneNumber;
//   String relationship;

//   EmergencyContact({
//     required this.id,
//     required this.name,
//     required this.phoneNumber,
//     required this.relationship,
//   });
// }

// class EmergencyContactSetupScreen extends StatefulWidget {
//   const EmergencyContactSetupScreen({super.key});

//   @override
//   State<EmergencyContactSetupScreen> createState() =>
//       _EmergencyContactSetupScreenState();
// }

// class _EmergencyContactSetupScreenState
//     extends State<EmergencyContactSetupScreen> {
//   final List<EmergencyContact> _emergencyContacts = [];

//   // Placeholder for adding from phonebook
//   Future<void> _addFromPhonebook() async {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Phonebook access not implemented in this demo.'),
//       ),
//     );
//   }

//   void _deleteContact(String id) {
//     setState(() {
//       _emergencyContacts.removeWhere((contact) => contact.id == id);
//     });
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('Contact deleted.')));
//   }

//   void _saveEmergencyContacts() {
//     if (_emergencyContacts.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please add at least one emergency contact.'),
//         ),
//       );
//       return;
//     }
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Saved ${_emergencyContacts.length} emergency contacts!'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Calculate the available height for the scrollable content (the ListView)
//     // This needs to account for all fixed-height widgets above and below it.
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double statusBarHeight = MediaQuery.of(context).padding.top;
//     final double bottomNavBarHeight = MediaQuery.of(context).padding.bottom;

//     // Approximate heights of fixed widgets in the Column:
//     // These values might need fine-tuning based on your exact AppTextStyles and CustomButton/ElevatedButton implementations.
//     const double topSizedBoxHeight = 10.0;
//     const double headerTextSectionHeight =
//         28.0 + 8.0 + 16.0 + 32.0; // Heading1 + SizedBox + Body + SizedBox
//     const double buttonsSectionHeight =
//         50.0 + 24.0 + 24.0; // CustomButton + SizedBox + Heading2
//     const double SizedBoxBeforeList = 12.0;
//     const double SizedBoxAfterList = 40.0;
//     const double saveButtonSectionHeight = 20.0; // ElevatedButton height

//     final double fixedWidgetsTotalHeight =
//         topSizedBoxHeight +
//         headerTextSectionHeight +
//         buttonsSectionHeight +
//         SizedBoxBeforeList +
//         SizedBoxAfterList +
//         saveButtonSectionHeight;

//     final double availableHeightForContent =
//         screenHeight -
//         statusBarHeight -
//         bottomNavBarHeight -
//         fixedWidgetsTotalHeight;

//     return Layout(
//       imagePath: 'assets/background.png',
//       backgroundColor: AppColors.primary,
//       padding: EdgeInsets.zero,
//       child: Column(
//         // Removed the outer Expanded here
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // const SizedBox(height: topSizedBoxHeight), // Space for the top image
//           const SizedBox(height: 120),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Emergency Contacts",
//                   style: AppTextStyles.heading1.copyWith(
//                     color: AppColors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Add contacts who will be notified in case of an emergency.",
//                   style: AppTextStyles.body.copyWith(
//                     color: AppColors.white.withOpacity(0.8),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomButton(
//                         text: "Contacts",
//                         icon: Icons.contacts,
//                         backgroundColor: AppColors.green,
//                         textColor: AppColors.white,
//                         borderColor: AppColors.green,
//                         onPressed: _addFromPhonebook,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomButton(
//                         text: "Add Manually",
//                         icon: Icons.person_add,
//                         backgroundColor: AppColors.green,
//                         textColor: AppColors.white,
//                         borderColor: AppColors.green,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AddEditContactScreen(
//                                 onSave: (newContact) {
//                                   setState(() {
//                                     _emergencyContacts.add(newContact);
//                                   });
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text('Contact added!'),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Added Contacts (${_emergencyContacts.length})",
//                     style: AppTextStyles.heading2.copyWith(
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // const SizedBox(height: SizedBoxBeforeList),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: SizedBox(
//               height: availableHeightForContent, // Use the calculated height
//               child: _emergencyContacts.isEmpty
//                   ? const Center(
//                       child: Text(
//                         'No emergency contacts added yet.',
//                         style: TextStyle(color: AppColors.textSecondary),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: _emergencyContacts.length,
//                       itemBuilder: (context, index) {
//                         final contact = _emergencyContacts[index];
//                         return Card(
//                           margin: const EdgeInsets.only(bottom: 10),
//                           elevation: 2,
//                           color: AppColors.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               backgroundColor: const Color.fromARGB(
//                                 255,
//                                 33,
//                                 30,
//                                 30,
//                               ),
//                               child: Text(
//                                 contact.name[0].toUpperCase(),
//                                 style: const TextStyle(color: AppColors.white),
//                               ),
//                             ),
//                             title: Text(
//                               contact.name,
//                               style: AppTextStyles.bodyBold.copyWith(
//                                 color: AppColors.white,
//                               ),
//                             ),
//                             subtitle: Text(
//                               '${contact.phoneNumber} (${contact.relationship})',
//                               style: const TextStyle(
//                                 color: AppColors.textSecondary,
//                               ),
//                             ),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.edit,
//                                     color: AppColors.textSecondary,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             AddEditContactScreen(
//                                               contactToEdit: contact,
//                                               onSave: (updatedContact) {
//                                                 setState(() {
//                                                   final index =
//                                                       _emergencyContacts
//                                                           .indexWhere(
//                                                             (c) =>
//                                                                 c.id ==
//                                                                 updatedContact
//                                                                     .id,
//                                                           );
//                                                   if (index != -1) {
//                                                     _emergencyContacts[index] =
//                                                         updatedContact;
//                                                   }
//                                                 });
//                                                 ScaffoldMessenger.of(
//                                                   context,
//                                                 ).showSnackBar(
//                                                   const SnackBar(
//                                                     content: Text(
//                                                       'Contact updated!',
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.delete,
//                                     color: Colors.redAccent,
//                                   ),
//                                   onPressed: () => _deleteContact(contact.id),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ),
//           // const SizedBox(height: SizedBoxAfterList),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _saveEmergencyContacts,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.accent,
//                   foregroundColor: AppColors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   'Save Contacts & Continue',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:safeguard/components/layout.dart';
// import 'package:safeguard/screens/homepage/add_edit_contact_screen.dart'; // Ensure this import is correct
// import 'package:safeguard/theme/theme.dart';
// import 'package:safeguard/widgets/custom_button.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:contacts_service/contacts_service.dart'; // Import contacts_service

// // Define a simple model for an Emergency Contact
// class EmergencyContact {
//   String id; // Unique ID for list keys
//   String name;
//   String phoneNumber;
//   String relationship;

//   EmergencyContact({
//     required this.id,
//     required this.name,
//     required this.phoneNumber,
//     required this.relationship,
//   });
// }

// class EmergencyContactSetupScreen extends StatefulWidget {
//   const EmergencyContactSetupScreen({super.key});

//   @override
//   State<EmergencyContactSetupScreen> createState() =>
//       _EmergencyContactSetupScreenState();
// }

// class _EmergencyContactSetupScreenState
//     extends State<EmergencyContactSetupScreen> {
//   final List<EmergencyContact> _emergencyContacts = [];

//   // Function to request contacts permission
//   Future<bool> _requestContactsPermission() async {
//     PermissionStatus permission = await Permission.contacts.status;
//     if (permission != PermissionStatus.granted) {
//       permission = await Permission.contacts.request();
//     }
//     return permission == PermissionStatus.granted;
//   }

//   // Function to add contact from phonebook
//   Future<void> _addFromPhonebook() async {
//     if (await _requestContactsPermission()) {
//       try {
//         final Contact? contact =
//             await ContactsService.openDeviceContactPicker();
//         if (contact != null) {
//           final String name = contact.displayName ?? 'Unknown Contact';
//           final String phoneNumber = contact.phones?.isNotEmpty == true
//               ? contact.phones!.first.value ?? ''
//               : '';

//           if (phoneNumber.isNotEmpty) {
//             setState(() {
//               _emergencyContacts.add(
//                 EmergencyContact(
//                   id: DateTime.now().toIso8601String(), // Simple unique ID
//                   name: name,
//                   phoneNumber: phoneNumber,
//                   relationship:
//                       'Friend', // Default relationship for imported contacts
//                 ),
//               );
//             });
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Contact "$name" added from phonebook!')),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Selected contact has no phone number.'),
//               ),
//             );
//           }
//         } else {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(const SnackBar(content: Text('No contact selected.')));
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error picking contact: $e')));
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Contacts permission denied.')),
//       );
//       // Optionally, guide the user to app settings
//       openAppSettings();
//     }
//   }

//   void _deleteContact(String id) {
//     setState(() {
//       _emergencyContacts.removeWhere((contact) => contact.id == id);
//     });
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('Contact deleted.')));
//   }

//   void _saveEmergencyContacts() {
//     if (_emergencyContacts.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please add at least one emergency contact.'),
//         ),
//       );
//       return;
//     }
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Saved ${_emergencyContacts.length} emergency contacts!'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double statusBarHeight = MediaQuery.of(context).padding.top;
//     final double bottomNavBarHeight = MediaQuery.of(context).padding.bottom;

//     const double topSizedBoxHeight = 10.0;
//     const double headerTextSectionHeight = 28.0 + 8.0 + 16.0 + 32.0;
//     const double buttonsSectionHeight = 50.0 + 24.0 + 24.0;
//     const double SizedBoxBeforeList = 12.0;
//     const double SizedBoxAfterList = 40.0;
//     const double saveButtonSectionHeight = 20.0;

//     final double fixedWidgetsTotalHeight =
//         topSizedBoxHeight +
//         headerTextSectionHeight +
//         buttonsSectionHeight +
//         SizedBoxBeforeList +
//         SizedBoxAfterList +
//         saveButtonSectionHeight;

//     final double availableHeightForContent =
//         screenHeight -
//         statusBarHeight -
//         bottomNavBarHeight -
//         fixedWidgetsTotalHeight;

//     return Layout(
//       imagePath: 'assets/background.png',
//       backgroundColor: AppColors.primary,
//       padding: EdgeInsets.zero,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 120),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Emergency Contacts",
//                   style: AppTextStyles.heading1.copyWith(
//                     color: AppColors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Add contacts who will be notified in case of an emergency.",
//                   style: AppTextStyles.body.copyWith(
//                     color: AppColors.white.withOpacity(0.8),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomButton(
//                         text: "Contacts",
//                         icon: Icons.contacts,
//                         backgroundColor: AppColors.green,
//                         textColor: AppColors.white,
//                         borderColor: AppColors.green,
//                         onPressed:
//                             _addFromPhonebook, // This will now open the contact picker
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomButton(
//                         text: "Add Manually",
//                         icon: Icons.person_add,
//                         backgroundColor: AppColors.green,
//                         textColor: AppColors.white,
//                         borderColor: AppColors.green,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AddEditContactScreen(
//                                 onSave: (newContact) {
//                                   setState(() {
//                                     _emergencyContacts.add(newContact);
//                                   });
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text('Contact added!'),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Added Contacts (${_emergencyContacts.length})",
//                     style: AppTextStyles.heading2.copyWith(
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: SizedBox(
//               height: availableHeightForContent,
//               child: _emergencyContacts.isEmpty
//                   ? const Center(
//                       child: Text(
//                         'No emergency contacts added yet.',
//                         style: TextStyle(color: AppColors.textSecondary),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: _emergencyContacts.length,
//                       itemBuilder: (context, index) {
//                         final contact = _emergencyContacts[index];
//                         return Card(
//                           margin: const EdgeInsets.only(bottom: 10),
//                           elevation: 2,
//                           color: AppColors.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               backgroundColor: const Color.fromARGB(
//                                 255,
//                                 33,
//                                 30,
//                                 30,
//                               ),
//                               child: Text(
//                                 contact.name[0].toUpperCase(),
//                                 style: const TextStyle(color: AppColors.white),
//                               ),
//                             ),
//                             title: Text(
//                               contact.name,
//                               style: AppTextStyles.bodyBold.copyWith(
//                                 color: AppColors.white,
//                               ),
//                             ),
//                             subtitle: Text(
//                               '${contact.phoneNumber} (${contact.relationship})',
//                               style: const TextStyle(
//                                 color: AppColors.textSecondary,
//                               ),
//                             ),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.edit,
//                                     color: AppColors.textSecondary,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             AddEditContactScreen(
//                                               contactToEdit: contact,
//                                               onSave: (updatedContact) {
//                                                 setState(() {
//                                                   final index =
//                                                       _emergencyContacts
//                                                           .indexWhere(
//                                                             (c) =>
//                                                                 c.id ==
//                                                                 updatedContact
//                                                                     .id,
//                                                           );
//                                                   if (index != -1) {
//                                                     _emergencyContacts[index] =
//                                                         updatedContact;
//                                                   }
//                                                 });
//                                                 ScaffoldMessenger.of(
//                                                   context,
//                                                 ).showSnackBar(
//                                                   const SnackBar(
//                                                     content: Text(
//                                                       'Contact updated!',
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.delete,
//                                     color: Colors.redAccent,
//                                   ),
//                                   onPressed: () => _deleteContact(contact.id),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _saveEmergencyContacts,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.accent,
//                   foregroundColor: AppColors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   'Save Contacts & Continue',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:safeguard/components/layout.dart';
// import 'package:safeguard/screens/homepage/add_edit_contact_screen.dart'; // Ensure this import is correct
// import 'package:safeguard/theme/theme.dart';
// import 'package:safeguard/widgets/custom_button.dart';
// import 'package:permission_handler/permission_handler.dart';
// // import 'package:contacts_service/contacts_service.dart'; // Import contacts_service
// // ignore: depend_on_referenced_packages
// import 'package:contacts_service_plus/contacts_service_plus.dart';

// // Define a simple model for an Emergency Contact
// class EmergencyContact {
//   String id; // Unique ID for list keys
//   String name;
//   String phoneNumber;
//   String relationship;

//   EmergencyContact({
//     required this.id,
//     required this.name,
//     required this.phoneNumber,
//     required this.relationship,
//   });
// }

// class EmergencyContactSetupScreen extends StatefulWidget {
//   const EmergencyContactSetupScreen({super.key});

//   @override
//   State<EmergencyContactSetupScreen> createState() =>
//       _EmergencyContactSetupScreenState();
// }

// class _EmergencyContactSetupScreenState
//     extends State<EmergencyContactSetupScreen> {
//   final List<EmergencyContact> _emergencyContacts = [];

//   // Function to request contacts permission
//   Future<bool> _requestContactsPermission() async {
//     PermissionStatus permission = await Permission.contacts.status;
//     if (permission != PermissionStatus.granted) {
//       permission = await Permission.contacts.request();
//     }
//     return permission == PermissionStatus.granted;
//   }

//   // Function to add contact from phonebook
//   Future<void> _addFromPhonebook() async {
//     if (await _requestContactsPermission()) {
//       try {
//         final Contact? contact =
//             await ContactsService.openDeviceContactPicker();
//         if (contact != null) {
//           final String name = contact.displayName ?? 'Unknown Contact';
//           final String phoneNumber = contact.phones?.isNotEmpty == true
//               ? contact.phones!.first.value ?? ''
//               : '';

//           if (phoneNumber.isNotEmpty) {
//             setState(() {
//               _emergencyContacts.add(
//                 EmergencyContact(
//                   id: DateTime.now().toIso8601String(), // Simple unique ID
//                   name: name,
//                   phoneNumber: phoneNumber,
//                   relationship:
//                       'Friend', // Default relationship for imported contacts
//                 ),
//               );
//             });
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Contact "$name" added from phonebook!')),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Selected contact has no phone number.'),
//               ),
//             );
//           }
//         } else {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(const SnackBar(content: Text('No contact selected.')));
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error picking contact: $e')));
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Contacts permission denied.')),
//       );
//       // Optionally, guide the user to app settings
//       openAppSettings();
//     }
//   }

//   void _deleteContact(String id) {
//     setState(() {
//       _emergencyContacts.removeWhere((contact) => contact.id == id);
//     });
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('Contact deleted.')));
//   }

//   void _saveEmergencyContacts() {
//     if (_emergencyContacts.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please add at least one emergency contact.'),
//         ),
//       );
//       return;
//     }
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Saved ${_emergencyContacts.length} emergency contacts!'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     const double horizontalPadding = 20.0; // Standardized horizontal padding

//     return Layout(
//       imagePath: 'assets/background.png',
//       backgroundColor: AppColors.primary,
//       padding: EdgeInsets
//           .zero, // Layout's padding is zero, we'll add it to the inner Column
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Adjusted top spacing for better visual balance
//           SizedBox(
//             height: MediaQuery.of(context).padding.top + 40,
//           ), // Dynamic top padding + fixed space
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Emergency Contacts",
//                   style: AppTextStyles.heading1.copyWith(
//                     color: AppColors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Add contacts who will be notified in case of an emergency.",
//                   style: AppTextStyles.body.copyWith(
//                     color: AppColors.white.withOpacity(0.8),
//                   ),
//                 ),
//                 const SizedBox(height: 32), // Space after description
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomButton(
//                         text: "Contacts",
//                         icon: Icons.contacts,
//                         backgroundColor: AppColors.green,
//                         textColor: AppColors.white,
//                         borderColor: AppColors.green,
//                         onPressed:
//                             _addFromPhonebook, // This will now open the contact picker
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomButton(
//                         text: "Add Manually",
//                         icon: Icons.person_add,
//                         backgroundColor: AppColors.green,
//                         textColor: AppColors.white,
//                         borderColor: AppColors.green,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AddEditContactScreen(
//                                 onSave: (newContact) {
//                                   setState(() {
//                                     _emergencyContacts.add(newContact);
//                                   });
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text('Contact added!'),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24), // Space after buttons
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Added Contacts (${_emergencyContacts.length})",
//                     style: AppTextStyles.heading2.copyWith(
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12), // Space before the list
//               ],
//             ),
//           ),
//           // Removed Expanded and added shrinkWrap/physics for ListView.builder
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
//             child: _emergencyContacts.isEmpty
//                 ? const Center(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                         vertical: 40.0,
//                       ), // Add some vertical padding for empty state
//                       child: Text(
//                         'No emergency contacts added yet.',
//                         style: TextStyle(color: AppColors.textSecondary),
//                       ),
//                     ),
//                   )
//                 : ListView.builder(
//                     shrinkWrap:
//                         true, // Important: Makes ListView only take necessary height
//                     physics:
//                         const NeverScrollableScrollPhysics(), // Important: Prevents ListView from having its own scroll
//                     itemCount: _emergencyContacts.length,
//                     itemBuilder: (context, index) {
//                       final contact = _emergencyContacts[index];
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         elevation: 2,
//                         color: AppColors.primary,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: const Color.fromARGB(
//                               255,
//                               33,
//                               30,
//                               30,
//                             ),
//                             child: Text(
//                               contact.name[0].toUpperCase(),
//                               style: const TextStyle(color: AppColors.white),
//                             ),
//                           ),
//                           title: Text(
//                             contact.name,
//                             style: AppTextStyles.bodyBold.copyWith(
//                               color: AppColors.white,
//                             ),
//                           ),
//                           subtitle: Text(
//                             '${contact.phoneNumber} (${contact.relationship})',
//                             style: const TextStyle(
//                               color: AppColors.textSecondary,
//                             ),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(
//                                   Icons.edit,
//                                   color: AppColors.textSecondary,
//                                 ),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           AddEditContactScreen(
//                                             contactToEdit: contact,
//                                             onSave: (updatedContact) {
//                                               setState(() {
//                                                 final index = _emergencyContacts
//                                                     .indexWhere(
//                                                       (c) =>
//                                                           c.id ==
//                                                           updatedContact.id,
//                                                     );
//                                                 if (index != -1) {
//                                                   _emergencyContacts[index] =
//                                                       updatedContact;
//                                                 }
//                                               });
//                                               ScaffoldMessenger.of(
//                                                 context,
//                                               ).showSnackBar(
//                                                 const SnackBar(
//                                                   content: Text(
//                                                     'Contact updated!',
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.redAccent,
//                                 ),
//                                 onPressed: () => _deleteContact(contact.id),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//           const SizedBox(height: 24), // Space before the save button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _saveEmergencyContacts,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.accent,
//                   foregroundColor: AppColors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   'Save Contacts & Continue',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20), // Bottom padding
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:safeguard/components/layout.dart';
import 'package:safeguard/screens/homepage/add_edit_contact_screen.dart';
// import 'package:safeguard/screens/home_screen.dart'; // Import the home screen
import 'package:safeguard/screens/homepage/home_page_screen.dart';
import 'package:safeguard/theme/theme.dart';
import 'package:safeguard/widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service_plus/contacts_service_plus.dart';

// Define a simple model for an Emergency Contact
class EmergencyContact {
  String id; // Unique ID for list keys
  String name;
  String phoneNumber;
  String relationship;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.relationship,
  });
}

class EmergencyContactSetupScreen extends StatefulWidget {
  const EmergencyContactSetupScreen({super.key});

  @override
  State<EmergencyContactSetupScreen> createState() =>
      _EmergencyContactSetupScreenState();
}

class _EmergencyContactSetupScreenState
    extends State<EmergencyContactSetupScreen> {
  final List<EmergencyContact> _emergencyContacts = [];

  // Function to request contacts permission
  Future<bool> _requestContactsPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      permission = await Permission.contacts.request();
    }
    return permission == PermissionStatus.granted;
  }

  // Function to add contact from phonebook
  Future<void> _addFromPhonebook() async {
    if (await _requestContactsPermission()) {
      try {
        final Contact? contact =
            await ContactsService.openDeviceContactPicker();
        if (contact != null) {
          final String name = contact.displayName ?? 'Unknown Contact';
          final String phoneNumber = contact.phones?.isNotEmpty == true
              ? contact.phones!.first.value ?? ''
              : '';

          if (phoneNumber.isNotEmpty) {
            setState(() {
              _emergencyContacts.add(
                EmergencyContact(
                  id: DateTime.now().toIso8601String(), // Simple unique ID
                  name: name,
                  phoneNumber: phoneNumber,
                  relationship:
                      'Friend', // Default relationship for imported contacts
                ),
              );
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Contact "$name" added from phonebook!')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Selected contact has no phone number.'),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No contact selected.')));
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking contact: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contacts permission denied.')),
      );
      // Optionally, guide the user to app settings
      openAppSettings();
    }
  }

  void _deleteContact(String id) {
    setState(() {
      _emergencyContacts.removeWhere((contact) => contact.id == id);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Contact deleted.')));
  }

  void _saveEmergencyContacts() {
    if (_emergencyContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one emergency contact.'),
        ),
      );
      return;
    }

    // Navigate to Home Screen with the emergency contacts
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(emergencyContacts: _emergencyContacts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 20.0; // Standardized horizontal padding
    return Layout(
      imagePath: 'assets/background.png',
      backgroundColor: AppColors.primary,
      padding: EdgeInsets
          .zero, // Layout's padding is zero, we'll add it to the inner Column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Adjusted top spacing for better visual balance
          SizedBox(
            height: MediaQuery.of(context).padding.top + 40,
          ), // Dynamic top padding + fixed space
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Emergency Contacts",
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Add contacts who will be notified in case of an emergency.",
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 32), // Space after description
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "Contacts",
                        icon: Icons.contacts,
                        backgroundColor: AppColors.green,
                        textColor: AppColors.white,
                        borderColor: AppColors.green,
                        onPressed:
                            _addFromPhonebook, // This will now open the contact picker
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: "Add Manually",
                        icon: Icons.person_add,
                        backgroundColor: AppColors.green,
                        textColor: AppColors.white,
                        borderColor: AppColors.green,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditContactScreen(
                                onSave: (newContact) {
                                  setState(() {
                                    _emergencyContacts.add(newContact);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Contact added!'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24), // Space after buttons
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Added Contacts (${_emergencyContacts.length})",
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12), // Space before the list
              ],
            ),
          ),
          // Removed Expanded and added shrinkWrap/physics for ListView.builder
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: _emergencyContacts.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 40.0,
                      ), // Add some vertical padding for empty state
                      child: Text(
                        'No emergency contacts added yet.',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap:
                        true, // Important: Makes ListView only take necessary height
                    physics:
                        const NeverScrollableScrollPhysics(), // Important: Prevents ListView from having its own scroll
                    itemCount: _emergencyContacts.length,
                    itemBuilder: (context, index) {
                      final contact = _emergencyContacts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        elevation: 2,
                        color: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color.fromARGB(
                              255,
                              33,
                              30,
                              30,
                            ),
                            child: Text(
                              contact.name[0].toUpperCase(),
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ),
                          title: Text(
                            contact.name,
                            style: AppTextStyles.bodyBold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          subtitle: Text(
                            '${contact.phoneNumber} (${contact.relationship})',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.textSecondary,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddEditContactScreen(
                                            contactToEdit: contact,
                                            onSave: (updatedContact) {
                                              setState(() {
                                                final index = _emergencyContacts
                                                    .indexWhere(
                                                      (c) =>
                                                          c.id ==
                                                          updatedContact.id,
                                                    );
                                                if (index != -1) {
                                                  _emergencyContacts[index] =
                                                      updatedContact;
                                                }
                                              });
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Contact updated!',
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () => _deleteContact(contact.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 24), // Space before the save button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveEmergencyContacts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save Contacts & Continue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }
}
