// ignore_for_file: library_private_types_in_public_api, unused_field, use_build_context_synchronously, deprecated_member_use, unused_local_variable, non_constant_identifier_names, empty_catches

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

import 'package:rider/widgets/custom_alert_dialog.dart'; 

class TrasladosScreen extends StatefulWidget {
  const TrasladosScreen({super.key});

  @override
  _TrasladosScreenState createState() => _TrasladosScreenState();
}

class _TrasladosScreenState extends State<TrasladosScreen> {
  final TextEditingController _origenController = TextEditingController();
  final List<TextEditingController> _destinosControllers = [];
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(-33.45694, -70.64827);
  final bool _isLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    
    _destinosControllers.add(TextEditingController());
    _checkLocationStatus();
  }

  Future<void> _checkLocationStatus() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      _requestLocationService();
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _requestLocationService() async {
    bool isLocationEnabled = await Geolocator.openLocationSettings();
    if (isLocationEnabled) {
      _getCurrentLocation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Los servicios de ubicación deben estar activados para usar esta función.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    bool hasPermission = await _checkLocationPermission();
    if (!hasPermission) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude); 
    });

    await _getAddressFromCoordinates(_initialPosition.latitude, _initialPosition.longitude);

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_initialPosition, 14),
    );

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: _initialPosition,
          infoWindow: InfoWindow(title: 'Tu ubicación actual'),
        ),
      );
    });
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Los permisos de ubicación son necesarios para usar esta función.'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Los permisos de ubicación están denegados permanentemente. Actívalos manualmente en la configuración.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

 Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      var geocoding = GeocodingPlatform.instance;

      if (geocoding != null) {
        List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(latitude, longitude);
        
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0]; 
          String address = '${place.street}, ${place.locality}, ${place.country}';

          setState(() {
            _origenController.text = address;
          });
        } else {
        }
      } else {
      }
    } catch (e) {

    }
  }

  void _agregarAutoMarcador(LatLng posicion) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('auto_${_markers.length}'), 
          position: posicion, 
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), 
          infoWindow: InfoWindow(title: 'Auto disponible'),
        ),
      );
    });

    Future.delayed(Duration(seconds: 5), () {
      _aceptarViaje(posicion);
    });
  }

  void _aceptarViaje(LatLng posicionAuto) {
    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == 'auto_$posicionAuto');
      _markers.add(
        Marker(
          markerId: MarkerId('auto_$posicionAuto'),
          position: posicionAuto,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), 
          infoWindow: InfoWindow(title: 'Auto aceptó el viaje'),
        ),
      );
    });

    _mostrarInformacionConductor(context);
  }

  void _mostrarInformacionConductor(BuildContext context) {
    String selectedVehicle = 'Rider';
    String selectedPayment = 'Tarjeta';
    double precioViaje = 5.000;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.40,
              minChildSize: 0.12,
              maxChildSize: 0.85,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color(0xFF0462FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tiempo estimado: 8 min',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center, 
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage('assets/logo.png'),
                                ),
                                const SizedBox(width: 12), 
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Juan Pérez',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 6),
                                      Text('Viajes: 120', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: List.generate(7, (index) {
                                          return Icon(
                                            index < 6 ? Icons.star : Icons.star_half,
                                            color: Colors.amber,
                                            size: 18,
                                          );
                                        }),
                                      ),
                                      const SizedBox(height: 6),
                                      Text('Calificación: 6.5', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Precio del viaje: \$${precioViaje.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                          children: [
                            _infoItem(Icons.credit_card, 'Pago', selectedPayment),
                            _infoItem(Icons.directions_car, 'Vehículo', selectedVehicle),
                            _infoItem(Icons.assignment_ind, 'Patente', 'GH-KT-23'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                          children: [
                            _infoItem(Icons.location_on, 'Distancia', '5.2 km'),
                            _infoItem(Icons.timer, 'Tiempo', '8 min'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                  title: "¡Confirmación de Cancelación!",
                                  message: "Se le cobrará una multa de \$1,000 por cancelar el viaje. ¿Está seguro de continuar?",
                                  icon: Icons.warning,
                                  backgroundColor: Colors.orange, 
                                  onPressed: () {
                                    Navigator.pop(context); 
                                  },
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          ),
                          child: Text('Cancelar Viaje', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    ).then((_) {
      Future.delayed(Duration(seconds: 10), () {
        _mostrarViajeEnCurso(context);
      });
    });
  }

  Widget _infoItem(IconData icon, String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blue, size: 24), 
        const SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _mostrarViajeEnCurso(BuildContext context) {
    String selectedVehicle = 'Rider';
    String selectedPayment = 'Tarjeta';
    double currentDistance = 5.2;
    double currentTime = 8;
    double currentSpeed = 50;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.40,
              minChildSize: 0.12,
              maxChildSize: 0.85,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Color(0xFF0462FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Tiempo restante: ${currentTime.toStringAsFixed(0)} min',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Divider(),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on, color: Colors.blue, size: 22),
                            const SizedBox(width: 8),
                            Text(
                              'En ruta a: $selectedVehicle',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Divider(),
                        const SizedBox(height: 15),
                        Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage('assets/logo.png'),
                                ),
                                const SizedBox(width: 12), 
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Juan Pérez',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 6),
                                      Text('Viajes: 120', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: List.generate(7, (index) {
                                          return Icon(
                                            index < 6 ? Icons.star : Icons.star_half,
                                            color: Colors.amber,
                                            size: 18,
                                          );
                                        }),
                                      ),
                                      const SizedBox(height: 6),
                                      Text('Calificación: 6.5', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        LinearProgressIndicator(
                          value: (currentDistance / 10),
                          backgroundColor: Colors.grey[300],
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    ).then((_) {
      Future.delayed(Duration(seconds: 10), () {
        return CustomAlertDialog(
          title: "¡Viaje Exitoso!",
          message: "Tu viaje ha finalizado. ¡Muchas Gracias! Si tienes alguna pregunta, no dudes en contactarnos.",
          icon: Icons.check_circle,
          backgroundColor: const Color(0xFF0462FF),
          onPressed: () {
            Navigator.pop(context);
          },
        );
      });
    });
  }

  LatLng _generarUbicacionAleatoria(LatLng centro) {
    double radio = 0.01; 
    double lat = centro.latitude + (Random().nextDouble() * 2 - 1) * radio;
    double lng = centro.longitude + (Random().nextDouble() * 2 - 1) * radio;
    return LatLng(lat, lng);
  }

  void _agregarDestino() {
    setState(() {
      _destinosControllers.add(TextEditingController());
    });
  }

  void _eliminarDestino(int index) {
    setState(() {
      _destinosControllers.removeAt(index);
    });
  }

  void _solicitarTraslado() {
    final origen = _origenController.text;
    final destinos = _destinosControllers.map((controller) => controller.text).toList();

    if (origen.isEmpty || destinos.any((destino) => destino.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, ingresa un origen y todos los destinos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14,
            ),
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    SizedBox(
                      height: 45,
                      child: TextField(
                        controller: _origenController,
                        decoration: InputDecoration(
                          labelText: 'Origen',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.location_on, color: Color(0xFF0462FF)),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          hintText: 'Dirección de origen',
                        ),
                        readOnly: true,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 6), 
                    Column(
                      children: List.generate(_destinosControllers.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6), 
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 45,
                                  child: TextField(
                                    controller: _destinosControllers[index],
                                    decoration: InputDecoration(
                                      labelText: 'Destino ${index + 1}',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      prefixIcon: Icon(Icons.location_on, color: Color(0xFF0462FF)),
                                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                    ),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              if (index > 0)
                                IconButton(
                                  icon: Icon(Icons.remove_circle, color: Colors.red),
                                  onPressed: () {
                                    _eliminarDestino(index);
                                  },
                                ),
                              if (index == _destinosControllers.length - 1) 
                                IconButton(
                                  icon: Icon(Icons.add_circle, color: Color(0xFF0462FF), size: 28),
                                  onPressed: _agregarDestino,
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
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
                    DropdownButtonFormField<String>(
                      value: 'Default',
                      onChanged: (String? newValue) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        prefixIcon: Icon(Icons.directions_car), 
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Default',
                          child: Text('Seleccione el tipo de Rider'),
                        ),
                        DropdownMenuItem(
                          value: 'Rider',
                          child: Text('Rider'),
                        ),
                        DropdownMenuItem(
                          value: 'Rider París',
                          child: Text('Rider París (+\$1,000)'),
                        ),
                        DropdownMenuItem(
                          value: 'Rider XL',
                          child: Text('Rider XL (base \$5,000)'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16), 
                    DropdownButtonFormField<String>(
                      value: 'Default',
                      onChanged: (String? newValue) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        prefixIcon: Icon(Icons.payment), 
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Default',
                          child: Text('Seleccione el método de pago'),
                        ),
                        DropdownMenuItem(
                          value: 'Tarjeta',
                          child: Text('Tarjeta'),
                        ),
                        DropdownMenuItem(
                          value: 'Efectivo',
                          child: Text('Efectivo'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),  
                    TextField(
                      controller: TextEditingController(text: "10% - Estudiante"), 
                      decoration: InputDecoration(
                        labelText: 'Descuento',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.discount, color: Color(0xFF0462FF)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      ),
                      readOnly: true,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80, 
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
                  children: [
                    SizedBox(height: 8),
                    Text(
                      '\$5,000', 
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
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
                onPressed: () {
                  _solicitarTraslado();
                  _agregarAutoMarcador(_generarUbicacionAleatoria(_initialPosition));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0462FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Solicitar Traslado',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}