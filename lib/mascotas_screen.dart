// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ServicioMascotasScreen extends StatefulWidget {
  const ServicioMascotasScreen({super.key});

  @override
  State<ServicioMascotasScreen> createState() => _ServicioMascotasScreenState();
}

class _ServicioMascotasScreenState extends State<ServicioMascotasScreen> {
  final TextEditingController _origenController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();

  String? _tipoMascota;
  bool _vaEnCanil = false;

  LatLng _initialPosition = LatLng(-33.45694, -70.64827);
  late GoogleMapController _mapController;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  Future<void> _checkLocationStatus() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      await Geolocator.openLocationSettings();
    }
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: MarkerId('ubicacion_actual'),
          position: _initialPosition,
          infoWindow: InfoWindow(title: 'Ubicación actual'),
        ),
      );
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_initialPosition, 14),
    );
  }

  void _solicitarTrasladoMascota() {
    final origen = _origenController.text.trim();
    final destino = _destinoController.text.trim();

    if (origen.isEmpty || destino.isEmpty || _tipoMascota == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes ingresar origen, destino y tipo de mascota'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Traslado solicitado'),
        content: Text(
          'Tipo: $_tipoMascota\nCanil: \${_vaEnCanil ? "Sí" : "No"}\nOrigen: \$origen\nDestino: \$destino',
        ),
        actions: [
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaMascota(String tipo, IconData icono) {
    final bool seleccionado = _tipoMascota == tipo;
    return GestureDetector(
      onTap: () {
        setState(() {
          _tipoMascota = tipo;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: seleccionado ? const Color(0xFF0462FF) : Colors.white,
          border: Border.all(
            color: seleccionado ? const Color(0xFF0462FF) : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icono, color: seleccionado ? Colors.white : Colors.black),
            const SizedBox(width: 12),
            Text(
              tipo,
              style: TextStyle(
                fontSize: 16,
                color: seleccionado ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traslado de Mascotas'),
        backgroundColor: const Color(0xFF0462FF),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14,
            ),
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
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _origenController,
                      decoration: const InputDecoration(
                        labelText: 'Dirección de origen',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _destinoController,
                      decoration: const InputDecoration(
                        labelText: 'Dirección de destino',
                        prefixIcon: Icon(Icons.flag),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Tipo de mascota:'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _tarjetaMascota('Perro', Icons.pets)),
                        const SizedBox(width: 12),
                        Expanded(child: _tarjetaMascota('Gato', Icons.pets_outlined)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      title: const Text('¿Va en canil?'),
                      value: _vaEnCanil,
                      onChanged: (value) {
                        setState(() {
                          _vaEnCanil = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _solicitarTrasladoMascota,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0462FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Solicitar Traslado',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}