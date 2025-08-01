// import 'package:flutter/material.dart';
// import 'package:safeguard/components/layout.dart';
// import 'package:safeguard/screens/homepage/add_edit_contact_screen.dart';
// // import 'package:safeguard/screens/home_screen.dart'; // Import the home screen
// import 'package:safeguard/screens/homepage/home_page_screen.dart';
// import 'package:safeguard/theme/theme.dart';
// import 'package:safeguard/widgets/custom_button.dart';
// import 'package:permission_handler/permission_handler.dart';
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

//     // Navigate to Home Screen with the emergency contacts
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => HomeScreen(emergencyContacts: _emergencyContacts),
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
// import 'package:flutter/material.dart';
// import 'package:safeguard/components/layout.dart';
// import 'package:safeguard/screens/homepage/add_edit_contact_screen.dart';
// import 'package:safeguard/screens/homepage/home_page_screen.dart'; // Import the home screen
// import 'package:safeguard/theme/theme.dart';
// import 'package:safeguard/widgets/custom_button.dart';
// import 'package:permission_handler/permission_handler.dart';
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
//     // Navigate to Home Screen with the emergency contacts
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => HomeScreen(emergencyContacts: _emergencyContacts),
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
//       child: SingleChildScrollView(
//         // Wrap the entire content in SingleChildScrollView
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Adjusted top spacing for better visual balance
//             SizedBox(
//               height: MediaQuery.of(context).padding.top + 40,
//             ), // Dynamic top padding + fixed space
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: horizontalPadding,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Emergency Contacts",
//                     style: AppTextStyles.heading1.copyWith(
//                       color: AppColors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Add contacts who will be notified in case of an emergency.",
//                     style: AppTextStyles.body.copyWith(
//                       color: AppColors.white.withOpacity(0.8),
//                     ),
//                   ),
//                   const SizedBox(height: 32), // Space after description
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: horizontalPadding,
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomButton(
//                           text: "Contacts",
//                           icon: Icons.contacts,
//                           backgroundColor: AppColors.green,
//                           textColor: AppColors.white,
//                           borderColor: AppColors.green,
//                           onPressed:
//                               _addFromPhonebook, // This will now open the contact picker
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: CustomButton(
//                           text: "Add Manually",
//                           icon: Icons.person_add,
//                           backgroundColor: AppColors.green,
//                           textColor: AppColors.white,
//                           borderColor: AppColors.green,
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => AddEditContactScreen(
//                                   onSave: (newContact) {
//                                     setState(() {
//                                       _emergencyContacts.add(newContact);
//                                     });
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text('Contact added!'),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24), // Space after buttons
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Added Contacts (${_emergencyContacts.length})",
//                       style: AppTextStyles.heading2.copyWith(
//                         color: AppColors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12), // Space before the list
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: horizontalPadding,
//               ),
//               child: _emergencyContacts.isEmpty
//                   ? const Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 40.0,
//                         ), // Add some vertical padding for empty state
//                         child: Text(
//                           'No emergency contacts added yet.',
//                           style: TextStyle(color: AppColors.textSecondary),
//                         ),
//                       ),
//                     )
//                   : ListView.builder(
//                       shrinkWrap:
//                           true, // Important: Makes ListView only take necessary height
//                       physics:
//                           const NeverScrollableScrollPhysics(), // Important: Prevents ListView from having its own scroll
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
//             const SizedBox(height: 24), // Space before the save button
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: horizontalPadding,
//               ),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saveEmergencyContacts,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.accent,
//                     foregroundColor: AppColors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'Save Contacts & Continue',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20), // Bottom padding
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:safeguard/components/layout.dart';
import 'package:safeguard/screens/homepage/add_edit_contact_screen.dart';
import 'package:safeguard/screens/homepage/home_page_screen.dart'; // Import the home screen
import 'package:safeguard/theme/theme.dart';
import 'package:safeguard/widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

// Define a simple model for an Emergency Contact
class EmergencyContact {
  String id; // Firestore document ID
  String name;
  String phoneNumber;
  String relationship;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.relationship,
  });

  // Factory constructor to create an EmergencyContact from a Firestore DocumentSnapshot
  factory EmergencyContact.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return EmergencyContact(
      id: doc.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      relationship: data['relationship'] ?? '',
    );
  }

  // Method to convert an EmergencyContact object to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'relationship': relationship,
      'createdAt':
          FieldValue.serverTimestamp(), // Add a timestamp for ordering/tracking
    };
  }
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
  bool _isLoadingContacts = true; // New state for loading contacts

  @override
  void initState() {
    super.initState();
    _fetchEmergencyContacts(); // Fetch contacts when the screen initializes
  }

  Future<void> _fetchEmergencyContacts() async {
    setState(() {
      _isLoadingContacts = true;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('emergencyContacts')
            .orderBy('createdAt', descending: false) // Order by creation time
            .get();

        setState(() {
          _emergencyContacts.clear();
          _emergencyContacts.addAll(
            snapshot.docs.map((doc) => EmergencyContact.fromFirestore(doc)),
          );
        });
      }
    } catch (e) {
      debugPrint('Error fetching emergency contacts: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load contacts: $e')));
      }
    } finally {
      setState(() {
        _isLoadingContacts = false;
      });
    }
  }

  Future<bool> _requestContactsPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      permission = await Permission.contacts.request();
    }
    return permission == PermissionStatus.granted;
  }

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
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              // Add to Firestore first to get the ID
              DocumentReference docRef = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('emergencyContacts')
                  .add({
                    'name': name,
                    'phoneNumber': phoneNumber,
                    'relationship': 'Friend', // Default for imported
                    'createdAt': FieldValue.serverTimestamp(),
                  });

              // Create local object with Firestore ID
              final newContact = EmergencyContact(
                id: docRef.id,
                name: name,
                phoneNumber: phoneNumber,
                relationship: 'Friend',
              );

              setState(() {
                _emergencyContacts.add(newContact);
              });
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Contact "$name" added from phonebook!'),
                  ),
                );
              }
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Selected contact has no phone number.'),
                ),
              );
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No contact selected.')),
            );
          }
        }
      } catch (e) {
        debugPrint('Error picking contact: $e');
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error picking contact: $e')));
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contacts permission denied.')),
        );
        openAppSettings();
      }
    }
  }

  void _deleteContact(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('emergencyContacts')
          .doc(id)
          .delete();

      setState(() {
        _emergencyContacts.removeWhere((contact) => contact.id == id);
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Contact deleted.')));
      }
    } catch (e) {
      debugPrint('Error deleting contact: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete contact: $e')));
      }
    }
  }

  void _handleSaveContact(EmergencyContact contact) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      if (contact.id.isEmpty) {
        // This is a new contact, add to Firestore
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('emergencyContacts')
            .add(contact.toFirestore());
        contact.id = docRef.id; // Update local object with Firestore ID
        setState(() {
          _emergencyContacts.add(contact);
        });
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Contact added!')));
        }
      } else {
        // This is an existing contact, update in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('emergencyContacts')
            .doc(contact.id)
            .update(contact.toFirestore());
        setState(() {
          final index = _emergencyContacts.indexWhere(
            (c) => c.id == contact.id,
          );
          if (index != -1) {
            _emergencyContacts[index] = contact;
          }
        });
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Contact updated!')));
        }
      }
    } catch (e) {
      debugPrint('Error saving contact: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save contact: $e')));
      }
    }
  }

  void _saveEmergencyContactsAndContinue() {
    if (_emergencyContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one emergency contact.'),
        ),
      );
      return;
    }
    // Navigate to Home Screen. Contacts will be fetched by HomeScreen itself.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const HomeScreen(), // HomeScreen will fetch its own contacts
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
      child: SingleChildScrollView(
        // Wrap the entire content in SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 40,
            ), // Dynamic top padding + fixed space
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
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
                                  onSave:
                                      _handleSaveContact, // Pass the unified save handler
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
            _isLoadingContacts
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.green,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: _emergencyContacts.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.0),
                              child: Text(
                                'No emergency contacts added yet.',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
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
                                      style: const TextStyle(
                                        color: AppColors.white,
                                      ),
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
                                                    onSave: _handleSaveContact,
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
                                        onPressed: () =>
                                            _deleteContact(contact.id),
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
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveEmergencyContactsAndContinue,
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
      ),
    );
  }
}
