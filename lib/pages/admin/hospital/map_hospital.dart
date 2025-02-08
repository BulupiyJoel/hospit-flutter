import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
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
  LatLng? _destination;
  final Location _location = Location();
  final TextEditingController _locationController = TextEditingController();
  bool isLoading = false;

  List<LatLng> route = [];
  Future<void> _initializeLocation() async {
    if (!await _checkRequestPermissions()) return;
  }

  Future<bool> _checkRequestPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }

      //Check if granted
      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return false;
        }
      }
    }
    return true;
  }

  Future<void> _userCurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15.0);
    } else {
      showMessage(context, "Current Location not available");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("OpenStreetMap"),
      ),
      body: Stack(
        children: [
          FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                  initialCenter: _currentLocation ?? const LatLng(0, 0),
                  initialZoom: 2,
                  minZoom: 0,
                  maxZoom: 100),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                CurrentLocationLayer(
                  style: const LocationMarkerStyle(
                      marker: DefaultLocationMarker(
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.white,
                        ),
                      ),
                      markerSize: Size(35, 35),
                      markerDirection: MarkerDirection.heading),
                )
              ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _userCurrentLocation,
        elevation: 0,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.my_location,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
