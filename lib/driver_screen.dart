// ignore_for_file: unused_field, prefer_final_fields, library_private_types_in_public_api, deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/widgets/custom_app_bar.dart';

class DriverScreen extends StatefulWidget {
  final String userEmail;

  const DriverScreen({super.key, required this.userEmail});

  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(37.7749, -122.4194); 
  Set<Marker> _markers = {};

  bool isOnline = false;
  double totalEarnings = 0.0;
  int totalTrips = 0;

  String? selectedCar = ''; 
  List<String> cars = ["Toyota Corolla", "Honda Civic"];

  bool _showingTripRequest = false; 
  late Timer _tripRequestTimer;

  @override
  void initState() {
    super.initState();
    _startTripRequestTimer();
  }

  @override
  void dispose() {
    _tripRequestTimer.cancel(); 
    super.dispose();
  }

  void _toggleOnlineStatus() {
    setState(() {
      isOnline = !isOnline;
    });
  }

  void _startTripRequestTimer() {
    _tripRequestTimer = Timer.periodic(Duration(seconds: 20), (timer) {
      if (isOnline && !_showingTripRequest) {
        _showTripRequest(context);
      }
    });
  }

  void _showTripRequest(BuildContext context) {
    setState(() {
      _showingTripRequest = true;
    });

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
                            setState(() {
                              _showingTripRequest = false;
                            });
                            Navigator.pop(context); 
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          ),
                          child: Text('Aceptar Viaje', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showingTripRequest = false;
                            });
                            Navigator.pop(context); 
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
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Rider App',
        userEmail: 'conductor',
        onLogout: () {},
      ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        "Ganancias Totales: \$${totalEarnings.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        "Total de Viajes: $totalTrips",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (isOnline) {
                            _toggleOnlineStatus();
                          } else {
                            _showCarSelectionDialog(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isOnline ? Color(0xFF34C759) : Color(0xFF8E8E93),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.2),
                        ),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: Text(
                            isOnline ? "Desconectar" : "Conectar",
                            key: ValueKey<bool>(isOnline),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCarSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecciona tu vehículo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: cars.map((car) {
              return ListTile(
                title: Text(car),
                onTap: () {
                  setState(() {
                    selectedCar = car;
                  });
                  Navigator.pop(context);
                  _toggleOnlineStatus();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
