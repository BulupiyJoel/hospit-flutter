import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:hospit/utils/firebase_config.dart'; // Import pour la configuration Firebase
import 'package:hospit/utils/show_information.dart'; // Import pour afficher des messages (Snackbar, Dialog, etc.)
import 'package:latlong2/latlong.dart'; // Import pour la gestion des coordonnées GPS (latitude et longitude)
import 'package:location/location.dart'; // Import pour accéder aux services de localisation de l'appareil

class MapHospital extends StatefulWidget {
  const MapHospital({super.key});

  @override
  _MapHospitalState createState() => _MapHospitalState();
}

class _MapHospitalState extends State<MapHospital> {
  final MapController _mapController = MapController(); // Contrôleur de la carte FlutterMap
  LatLng? _currentLocation; // Stocke la position actuelle de l'utilisateur (latitude et longitude)
  final Location _location = Location(); // Instance de l'objet Location pour gérer la localisation

  // Fonction pour initialiser la localisation de l'utilisateur
  Future<void> _initializeLocation() async {
    if (!await _checkRequestPermissions()) return; // Vérifie et demande les permissions
    final locationData = await _location.getLocation(); // Récupère les données de localisation
    setState(() {
      _currentLocation =
          LatLng(locationData.latitude!, locationData.longitude!); // Met à jour l'état avec la position
    });
  }

  // Fonction pour vérifier et demander les permissions de localisation
  Future<bool> _checkRequestPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled(); // Vérifie si le service de localisation est activé
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService(); // Demande l'activation du service
      if (!serviceEnabled) return false; // Si l'utilisateur refuse, retourne false
    }

    PermissionStatus permissionGranted = await _location.hasPermission(); // Vérifie les permissions
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission(); // Demande les permissions
      if (permissionGranted != PermissionStatus.granted) return false; // Si l'utilisateur refuse, retourne false
    }
    return true; // Si tout est OK, retourne true
  }

  // Fonction pour centrer la carte sur la position actuelle de l'utilisateur
  Future<void> _userCurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15.0); // Déplace la carte et ajuste le zoom
    } else {
      showMessage(context, "Localisation actuelle non disponible"); // Affiche un message d'erreur
    }
  }

  // Récupération des hôpitaux depuis Firestore
  final Stream<QuerySnapshot> hospitals =
      firebaseFirestore.collection("hospital").snapshots(); // Flux de données des hôpitaux

  @override
  void initState() {
    super.initState();
    _initializeLocation(); // Initialise la localisation au démarrage du widget
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: hospitals, // Écoute le flux de données des hôpitaux
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return _buildScaffold(
              const Text("Erreur de chargement des hôpitaux")); // Gestion des erreurs
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildScaffold(
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.lightGreen), // Indicateur de chargement
                  SizedBox(width: 10),
                  Text("Patientez...")
                ],
              ),
            ),
          ); // Affichage pendant le chargement des données
        }

        // Conversion des documents Firestore en marqueurs pour la carte
        List<Marker> hospitalMarkers = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;

          // Conversion explicite des coordonnées (important car Firestore peut stocker des nombres comme String)
          final double lat = double.parse(data["lat"].toString());
          final double lng = double.parse(data["long"].toString());

          return Marker(
            point: LatLng(lat, lng), // Position du marqueur
            width: 50,
            height: 50,
            child: const Icon(Icons.local_hospital_outlined,
                color: Colors.red, size: 40), // Icône du marqueur
          );
        }).toList();

        return Scaffold(
          appBar: AppBar(title: const Text("Carte des Hôpitaux")),
          body: FlutterMap(
            mapController: _mapController, // Assignation du contrôleur de carte
            options: MapOptions(
              initialCenter: _currentLocation ?? const LatLng(-1.2878, 29.8666), // Centre initial de la carte (si _currentLocation est null, on utilise une position par défaut)
              initialZoom: 13, // Niveau de zoom initial
              onTap: (_, point) { // Gestion des clics sur la carte
                showMessage(context,
                    "Vous avez cliqué sur ${point.latitude}, ${point.longitude}"); // Affiche les coordonnées du clic
                print("Lat : ${point.latitude}\nLong : ${point.longitude}"); // Affiche les coordonnées dans la console
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png", // URL des tuiles de la carte (OpenStreetMap)
              ),
              CurrentLocationLayer( // Ajoute un marqueur pour la position actuelle de l'utilisateur
                style: const LocationMarkerStyle(
                  marker: DefaultLocationMarker(
                    child: Icon(Icons.location_pin, color: Colors.white),
                  ),
                  markerSize: Size(35, 35),
                ),
              ),
              MarkerLayer(markers: hospitalMarkers), // Ajoute les marqueurs des hôpitaux
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _userCurrentLocation, // Appelle la fonction pour centrer la carte
            backgroundColor: Colors.blue,
            child: const Icon(Icons.my_location, size: 30, color: Colors.white), // Icône du bouton
          ),
        );
      },
    );
  }

  // Fonction pour construire le Scaffold (structure de base de l'écran)
  Scaffold _buildScaffold(Widget body) {
    return Scaffold(
      appBar: AppBar(title: const Text("Carte des Hôpitaux")),
      body: Center(child: body), // Centre le contenu
    );
  }
}