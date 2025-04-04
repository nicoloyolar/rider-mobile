// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiderEntregaScreen extends StatefulWidget {
  const RiderEntregaScreen({super.key});

  @override
  _RiderEntregaScreenState createState() => _RiderEntregaScreenState();
}

class _RiderEntregaScreenState extends State<RiderEntregaScreen> {
  final TextEditingController _origenController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _remitenteNombreController = TextEditingController();
  final TextEditingController _remitenteTelefonoController = TextEditingController();
  final TextEditingController _destinatarioNombreController = TextEditingController();
  final TextEditingController _destinatarioTelefonoController = TextEditingController();
  final TextEditingController _pesoPaqueteController = TextEditingController();

  String _tipoPaquete = 'Documento';
  GoogleMapController? _mapController;
  static const LatLng _initialPosition = LatLng(37.7749, -122.4194);

  void _mostrarExito(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.all(20),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF0462FF),
                child: Icon(Icons.check_circle, color: Colors.white, size: 40),
              ),
              SizedBox(height: 10),
              Text(
                "¡Entrega Solicitada!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: Text(
            "Te mantendremos al tanto. ¡Muchas Gracias! Si tienes alguna pregunta, no dudes en contactarnos.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0462FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Aceptar',
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
        );
      },
    );
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildTextField(_origenController, 'Origen', Icons.my_location),
                    SizedBox(height: 8),
                    _buildTextField(_destinoController, 'Destino', Icons.location_on),
                    SizedBox(height: 8),
                    _buildTextField(_remitenteNombreController, 'Nombre del Remitente', Icons.person),
                    SizedBox(height: 8),
                    _buildTextField(_remitenteTelefonoController, 'Teléfono del Remitente', Icons.phone, keyboardType: TextInputType.phone),
                    SizedBox(height: 8),
                    _buildTextField(_destinatarioNombreController, 'Nombre del Destinatario', Icons.person_outline),
                    SizedBox(height: 8),
                    _buildTextField(_destinatarioTelefonoController, 'Teléfono del Destinatario', Icons.phone_outlined, keyboardType: TextInputType.phone),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _tipoPaquete,
                      onChanged: (String? newValue) {
                        setState(() {
                          _tipoPaquete = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        prefixIcon: Icon(Icons.category),
                      ),
                      items: ['Documento', 'Electrónicos', 'Ropa', 'Alimentos', 'Otros']
                          .map((tipo) => DropdownMenuItem(value: tipo, child: Text(tipo)))
                          .toList(),
                    ),
                    SizedBox(height: 8),
                    _buildTextField(_pesoPaqueteController, 'Peso del Paquete (kg)', Icons.scale, keyboardType: TextInputType.number),
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
                  _mostrarExito(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0462FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Solicitar Entrega',
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

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(icon, color: Color(0xFF0462FF)),
      ),
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 16),
    );
  }

}
