import 'package:flutter/material.dart';
import 'package:safeguard/screens/homepage/emergency_contact_setup_screen.dart'; // Ensure this import is correct
import 'package:safeguard/theme/theme.dart';
import 'package:safeguard/components/layout.dart'; // Import your custom Layout widget
import 'package:permission_handler/permission_handler.dart';

class AddEditContactScreen extends StatefulWidget {
  final EmergencyContact? contactToEdit;
  final Function(EmergencyContact) onSave;

  const AddEditContactScreen({
    super.key,
    this.contactToEdit,
    required this.onSave,
  });

  @override
  State<AddEditContactScreen> createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedRelationship = 'Family';
  final List<String> _relationships = [
    'Family',
    'Friend',
    'Business',
    'Customer',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.contactToEdit != null) {
      _nameController.text = widget.contactToEdit!.name;
      _phoneController.text = widget.contactToEdit!.phoneNumber;
      _selectedRelationship = widget.contactToEdit!.relationship;
    }
  }

  void _handleSubmit() {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields.')));
      return;
    }

    final newContact = EmergencyContact(
      id: widget.contactToEdit?.id ?? DateTime.now().toIso8601String(),
      name: _nameController.text,
      phoneNumber: _phoneController.text,
      relationship: _selectedRelationship,
    );

    widget.onSave(newContact);
    Navigator.pop(context);
  }

  Future<bool> requestContactsPermission() async {
    if (await Permission.contacts.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.contactToEdit != null;
    return Layout(
      imagePath: 'assets/background.png', // Assuming you have this asset
      backgroundColor: AppColors.primary, // Dark background
      // The padding for the content is handled by the Layout widget's internal SingleChildScrollView
      // We can pass it here, or apply it directly to the Column below.
      // For consistency with the screenshot, let's apply it to the Column.
      padding: EdgeInsets
          .zero, // Layout's padding is zero, we'll add it to the inner Column

      child: Column(
        // This Column is now the direct child of Layout's SingleChildScrollView
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 120), // Push content downward
          // Custom AppBar
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 10),
                Text(
                  isEditing ? 'Edit Contact' : 'Add Contact',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const Text(
                //   'Edit/Add Contact',
                //   style: TextStyle(
                //     color: AppColors.white,
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mobile Number Field
                Text(
                  'Mobile number',
                  style: TextStyle(color: AppColors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: AppColors.white, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Enter mobile number',
                    hintStyle: TextStyle(color: AppColors.white),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white, width: 2),
                    ),
                    suffixIcon: Icon(Icons.person, color: AppColors.white),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
                const SizedBox(height: 30),

                // Contact Name Field (essential for contact, even if not explicitly in image)
                Text(
                  'Contact Name',
                  style: TextStyle(color: AppColors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: AppColors.white, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Enter contact name',
                    hintStyle: TextStyle(color: AppColors.white),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white, width: 2),
                    ),
                    suffixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.white,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
                const SizedBox(height: 30),

                // TAG section
                const Text(
                  'TAG',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: _relationships.map((tag) {
                    return ChoiceChip(
                      label: Text(tag),
                      selected: _selectedRelationship == tag,
                      selectedColor: AppColors.green,
                      backgroundColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      side: const BorderSide(
                        color: AppColors.green,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _selectedRelationship = tag;
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40), // Space before the save button
              ],
            ),
          ),

          // Save Button (fixed at the bottom, but still part of the scrollable content)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.lightgreen, // Purple color from image
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 0, // No shadow
                ),
                child: Text(
                  isEditing ? 'Update' : 'Save',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
