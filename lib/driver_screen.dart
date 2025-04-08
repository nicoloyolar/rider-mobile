// ignore_for_file: unused_field, prefer_final_fields, library_private_types_in_public_api, deprecated_member_use

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

  void _toggleOnlineStatus() {
    setState(() {
      isOnline = !isOnline;
    });
  }

  void _showCarSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecciona un Auto"),
          content: SizedBox(
            width: double.maxFinite, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: "Toyota Corolla",
                      groupValue: selectedCar,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCar = value;
                        });
                      },
                    ),
                    Text("Toyota Corolla"),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: "Honda Civic",
                      groupValue: selectedCar,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCar = value;
                        });
                      },
                    ),
                    Text("Honda Civic"),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (selectedCar != null && selectedCar!.isNotEmpty) {
                  _selectCar(selectedCar!);
                  Navigator.pop(context); 
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Por favor, selecciona un auto")),
                  );
                }
              },
              child: Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }

  void _selectCar(String selectedCar) {

    setState(() {
      isOnline = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Rider App',  
        userEmail: 'conductor',  
        onLogout: () {
        },
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
                        style: TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.w500, 
                          color: Colors.black87, 
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        "Total de Viajes: $totalTrips",
                        style: TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.w500, 
                          color: Colors.black87, 
                        ),
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
                    Text(
                      "Billetera",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "\$5.000", 
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 8),
                    Text("Viajes Realizados: $totalTrips"),
                    SizedBox(height: 8),
                    Text("Ganancias Totales: \$${totalEarnings.toStringAsFixed(2)}"),
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
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0462FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Iniciar Viaje',
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
