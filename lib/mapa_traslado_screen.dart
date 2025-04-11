// Archivo: mapa_traslado_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapaTrasladoScreen extends StatefulWidget {
  const MapaTrasladoScreen({super.key});

  @override
  State<MapaTrasladoScreen> createState() => _MapaTrasladoScreenState();
}

class _MapaTrasladoScreenState extends State<MapaTrasladoScreen> {
  late GoogleMapController _mapController;
  LatLng _initialPosition = const LatLng(-33.45694, -70.64827);
  final Set<Marker> _markers = {};

  String? origen;
  String? destino;
  String? servicio;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  Future<void> _checkLocationStatus() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      _getCurrentLocation();
    } else {
      await Geolocator.openLocationSettings();
    }
  }

  Future<void> _getCurrentLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _markers.add(Marker(
        markerId: const MarkerId("origen"),
        position: _initialPosition,
        infoWindow: const InfoWindow(title: "Tu ubicación"),
      ));
    });
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(_initialPosition, 14));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    origen = args?["origen"];
    destino = args?["destino"];
    servicio = args?["servicio"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmar ${servicio ?? 'traslado'}"),
        backgroundColor: const Color(0xFF0462FF),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 14),
            markers: _markers,
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (origen != null) Text("Origen: $origen"),
                    if (destino != null) Text("Destino: $destino"),
                    if (servicio == "mascotas") ...[
                      const SizedBox(height: 8),
                      Text("Tipo: \${args?['tipoMascota']}"),
                      Text("Canil: \${args?['vaEnCanil'] == 'true' ? 'Sí' : 'No'}"),
                    ],
                    if (servicio == "farmacia") ...[
                      const SizedBox(height: 8),
                      Text("Con receta: \${args?['conReceta'] == 'true' ? 'Sí' : 'No'}"),
                    ]
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // TODO: integrar con backend (ej: Nico Pilsen)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0462FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Confirmar Viaje", style: TextStyle(fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }
}
