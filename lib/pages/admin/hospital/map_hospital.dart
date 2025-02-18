import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:hospit/utils/firebase_config.dart';
import 'package:hospit/utils/show_information.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapHospital extends StatefulWidget {
  const MapHospital({super.key});

  @override
  _MapHospitalState createState() => _MapHospitalState();
}

class _MapHospitalState extends State<MapHospital> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  final Location _location = Location();

  Future<void> _initializeLocation() async {
    if (!await _checkRequestPermissions()) return;
    final locationData = await _location.getLocation();
    setState(() {
      _currentLocation =
          LatLng(locationData.latitude!, locationData.longitude!);
    });
  }

  Future<bool> _checkRequestPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return false;
    }
    return true;
  }

  Future<void> _userCurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15.0);
    } else {
      showMessage(context, "Localisation actuelle non disponible");
    }
  }

  // Récupération des hôpitaux
  final Stream<QuerySnapshot> hospitals =
      firebaseFirestore.collection("hospital").snapshots();

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: hospitals,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return _buildScaffold(
              const Text("Erreur de chargement des hôpitaux"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildScaffold(
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.lightGreen),
                  SizedBox(width: 10),
                  Text("Patientez...")
                ],
              ),
            ),
          );
        }

        List<Marker> hospitalMarkers = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;

          // Conversion explicite des coordonnées
          final double lat = double.parse(data["lat"].toString());
          final double lng = double.parse(data["long"].toString());

          return Marker(
            point: LatLng(lat, lng),
            width: 50,
            height: 50,
            child:
                const Icon(Icons.local_hospital_outlined, color: Colors.red, size: 40),
          );
        }).toList();

        return Scaffold(
          appBar: AppBar(title: const Text("Carte des Hôpitaux")),
          body: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? const LatLng(-1.2878, 29.8666),
              initialZoom: 13,
              onTap: (_, point) {
                showMessage(context,
                    "Vous avez cliqué sur ${point.latitude}, ${point.longitude}");
                print("Lat : ${point.latitude}\nLong : ${point.longitude}");
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              CurrentLocationLayer(
                style: const LocationMarkerStyle(
                  marker: DefaultLocationMarker(
                    child: Icon(Icons.location_pin, color: Colors.white),
                  ),
                  markerSize: Size(35, 35),
                ),
              ),
              MarkerLayer(markers: hospitalMarkers),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _userCurrentLocation,
            backgroundColor: Colors.blue,
            child: const Icon(Icons.my_location, size: 30, color: Colors.white),
          ),
        );
      },
    );
  }

  Scaffold _buildScaffold(Widget body) {
    return Scaffold(
      appBar: AppBar(title: const Text("Carte des Hôpitaux")),
      body: Center(child: body),
    );
  }
}
