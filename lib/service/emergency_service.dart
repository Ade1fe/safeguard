import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:safeguard/screens/homepage/emergency_contact_setup_screen.dart';

class EmergencyService {
  static final loc.Location _location = loc.Location();

  // Get current location using your existing implementation
  static Future<Map<String, dynamic>?> _getCurrentLocationData() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      loc.PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          return null;
        }
      }

      final pos = await _location.getLocation().timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Location request timed out."),
      );

      if (pos.latitude != null && pos.longitude != null) {
        // Get address
        String? address;
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            pos.latitude!,
            pos.longitude!,
          );
          if (placemarks.isNotEmpty) {
            Placemark place = placemarks[0];
            address =
                "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
          }
        } catch (e) {
          address = "Address not available";
        }

        return {
          'latitude': pos.latitude!,
          'longitude': pos.longitude!,
          'address': address ?? "Address not available",
        };
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
    return null;
  }

  // Send emergency SMS to all contacts
  static Future<void> sendEmergencyAlert({
    required List<EmergencyContact> contacts,
    required BuildContext context,
    bool includeLocation = true,
  }) async {
    if (contacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No emergency contacts available')),
      );
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Sending emergency alert..."),
            ],
          ),
        );
      },
    );

    String message =
        "🚨 EMERGENCY ALERT 🚨\n\nI'm in danger and need immediate help! Please call me or contact emergency services.\n\nThis is an automated emergency message from SafeGuard app.";

    // Add location if enabled and available
    if (includeLocation) {
      final locationData = await _getCurrentLocationData();
      if (locationData != null) {
        message += "\n\n📍 My location:\n";
        message += "Address: ${locationData['address']}\n";
        message +=
            "Coordinates: ${locationData['latitude']}, ${locationData['longitude']}\n";
        message +=
            "Google Maps: https://maps.google.com/?q=${locationData['latitude']},${locationData['longitude']}";
      } else {
        message += "\n\n📍 Location: Unable to get current location";
      }
    }

    // Close loading dialog
    Navigator.of(context).pop();

    // Send SMS to each contact
    int successCount = 0;
    for (final contact in contacts) {
      try {
        final Uri smsUri = Uri(
          scheme: 'sms',
          path: contact.phoneNumber,
          queryParameters: {'body': message},
        );

        if (await canLaunchUrl(smsUri)) {
          await launchUrl(smsUri);
          successCount++;
        }
      } catch (e) {
        debugPrint('Error sending SMS to ${contact.name}: $e');
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Emergency alert sent to $successCount of ${contacts.length} contacts',
        ),
        backgroundColor: successCount > 0 ? Colors.green : Colors.red,
      ),
    );
  }

  // Make emergency call to first contact
  static Future<void> makeEmergencyCall({
    required List<EmergencyContact> contacts,
    required BuildContext context,
  }) async {
    if (contacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No emergency contacts available')),
      );
      return;
    }

    final firstContact = contacts.first;
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: firstContact.phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error calling ${firstContact.name}: $e')),
      );
    }
  }

  // Get current location for display purposes
  static Future<Map<String, dynamic>?> getCurrentLocation() async {
    return await _getCurrentLocationData();
  }
}
