import 'package:flutter/material.dart';
import 'package:safeguard/components/layout.dart';
import 'package:safeguard/screens/homepage/emergency_contact_setup_screen.dart';
import 'package:safeguard/screens/homepage/add_edit_contact_screen.dart';
import 'package:safeguard/service/emergency_service.dart';
// import 'package:safeguard/services/emergency_service.dart';
import 'package:safeguard/theme/theme.dart';
import 'package:safeguard/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  final List<EmergencyContact> emergencyContacts;

  const HomeScreen({super.key, required this.emergencyContacts});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<EmergencyContact> _emergencyContacts;
  bool _locationSharingEnabled = true;
  bool _isEmergencyActive = false;
  Map<String, dynamic>? _currentLocation;
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _emergencyContacts = List.from(widget.emergencyContacts);
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    if (!_locationSharingEnabled) return;

    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final location = await EmergencyService.getCurrentLocation();
      setState(() {
        _currentLocation = location;
      });
    } catch (e) {
      debugPrint('Error fetching location: $e');
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  Future<void> _triggerEmergencyAlert() async {
    if (_isEmergencyActive) return;

    setState(() {
      _isEmergencyActive = true;
    });

    // Show confirmation dialog
    final bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          title: const Text(
            '🚨 Emergency Alert',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'This will send an emergency message to ${_emergencyContacts.length} contacts${_locationSharingEnabled ? ' with your location' : ''}.\n\nAre you sure you want to continue?',
            style: const TextStyle(color: AppColors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Send Alert',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await EmergencyService.sendEmergencyAlert(
        contacts: _emergencyContacts,
        context: context,
        includeLocation: _locationSharingEnabled,
      );
    }

    setState(() {
      _isEmergencyActive = false;
    });
  }

  Future<void> _makeEmergencyCall() async {
    await EmergencyService.makeEmergencyCall(
      contacts: _emergencyContacts,
      context: context,
    );
  }

  void _navigateToManageContacts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmergencyContactSetupScreen()),
    ).then((result) {
      // Refresh contacts if needed
      // You might want to implement a way to pass updated contacts back
    });
  }

  void _addNewContact() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditContactScreen(
          onSave: (newContact) {
            setState(() {
              _emergencyContacts.add(newContact);
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Contact added!')));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 20.0;

    return Layout(
      imagePath: 'assets/background.png',
      backgroundColor: AppColors.primary,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          SizedBox(height: MediaQuery.of(context).padding.top + 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SafeGuard",
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Your safety is our priority. Tap the emergency button when you need help.",
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),

          // Emergency Alert Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.redAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: _isEmergencyActive ? null : _triggerEmergencyAlert,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isEmergencyActive
                              ? Icons.hourglass_empty
                              : Icons.warning,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isEmergencyActive ? 'SENDING...' : 'EMERGENCY ALERT',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Quick Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Call",
                    icon: Icons.phone,
                    backgroundColor: AppColors.green,
                    textColor: AppColors.white,
                    borderColor: AppColors.green,
                    onPressed: _makeEmergencyCall,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: "Add Contact",
                    icon: Icons.person_add,
                    backgroundColor: AppColors.accent,
                    textColor: AppColors.white,
                    borderColor: AppColors.accent,
                    onPressed: _addNewContact,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Location Status Section
          if (_locationSharingEnabled)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.white.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Current Location",
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const Spacer(),
                        if (_isLoadingLocation)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.green,
                              ),
                            ),
                          )
                        else
                          IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              color: AppColors.green,
                            ),
                            onPressed: _fetchCurrentLocation,
                            iconSize: 20,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_currentLocation != null) ...[
                      Text(
                        _currentLocation!['address'] ?? 'Address not available',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lat: ${_currentLocation!['latitude']?.toStringAsFixed(6)}, Lng: ${_currentLocation!['longitude']?.toStringAsFixed(6)}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ] else ...[
                      Text(
                        _isLoadingLocation
                            ? 'Getting location...'
                            : 'Location not available',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

          const SizedBox(height: 24),

          // Settings Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.white.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Settings",
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Share Location",
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Switch(
                        value: _locationSharingEnabled,
                        onChanged: (value) {
                          setState(() {
                            _locationSharingEnabled = value;
                          });
                          if (value) {
                            _fetchCurrentLocation();
                          } else {
                            setState(() {
                              _currentLocation = null;
                            });
                          }
                        },
                        activeColor: AppColors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Emergency Contacts List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Emergency Contacts (${_emergencyContacts.length})",
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: _navigateToManageContacts,
                      child: Text(
                        "Manage",
                        style: TextStyle(color: AppColors.accent),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // Contacts List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: _emergencyContacts.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.contacts,
                            size: 48,
                            color: AppColors.white.withOpacity(0.5),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No emergency contacts added yet.',
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add contacts to enable emergency alerts.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _emergencyContacts.length > 3
                        ? 3
                        : _emergencyContacts.length,
                    itemBuilder: (context, index) {
                      final contact = _emergencyContacts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        color: AppColors.primary.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: AppColors.white.withOpacity(0.2),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.green,
                            child: Text(
                              contact.name[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                            '${contact.phoneNumber} • ${contact.relationship}',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          trailing: Icon(Icons.phone, color: AppColors.green),
                        ),
                      );
                    },
                  ),
          ),

          if (_emergencyContacts.length > 3)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: TextButton(
                onPressed: _navigateToManageContacts,
                child: Text(
                  "View all ${_emergencyContacts.length} contacts",
                  style: TextStyle(color: AppColors.accent),
                ),
              ),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
