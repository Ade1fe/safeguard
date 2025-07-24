// location_screen.dart
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<GetLocation> {
  loc.LocationData? _currentPosition;
  String? _address;
  final loc.Location location = loc.Location();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _currentPosition = null;
      _address = null;
    });

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          _showSnackBar('Location service is disabled. Please enable it.');
          _updateLoadingState(false);
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          _showSnackBar('Location permission denied. Cannot fetch location.');
          _updateLoadingState(false);
          return;
        }
      }

      final pos = await location.getLocation().timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Location request timed out."),
      );

      if (pos.latitude != null && pos.longitude != null) {
        setState(() => _currentPosition = pos);
        await _getAddress(pos.latitude!, pos.longitude!);
      } else {
        _showSnackBar('Failed to get precise location data.');
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    } finally {
      _updateLoadingState(false);
    }
  }

  Future<void> _getAddress(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _address =
              "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      } else {
        setState(() => _address = "Address not found");
      }
    } catch (e) {
      setState(() => _address = "Error fetching address");
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _updateLoadingState(bool loading) {
    if (mounted) {
      setState(() => _isLoading = loading);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Location")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _currentPosition == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Could not fetch location."),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _fetchLocation,
                        child: const Text("Retry Location"),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Here's your location:",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Latitude: ${_currentPosition!.latitude}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Longitude: ${_currentPosition!.longitude}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    if (_address != null)
                      Text(
                        "Address: $_address",
                        style: const TextStyle(fontSize: 16),
                      ),
                    if (_address == null)
                      const Text(
                        "Fetching address...",
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _fetchLocation,
                      child: const Text("Refresh Location"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
