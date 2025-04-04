// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';

class SiNoDeboConducirScreen extends StatefulWidget {
  const SiNoDeboConducirScreen({super.key});

  @override
  _SiNoDeboConducirScreenState createState() => _SiNoDeboConducirScreenState();
}

class _SiNoDeboConducirScreenState extends State<SiNoDeboConducirScreen> {
  final _formKey = GlobalKey<FormState>();

  String _metodoPago = '';
  String _tipoVehiculo = '';
  String _origen = '';
  String _destino = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Si No Debo Conducir"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Método de Pago", style: TextStyle(fontSize: 16)),
              TextFormField(
                decoration: InputDecoration(hintText: "Ingrese el método de pago"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el método de pago';
                  }
                  return null;
                },
                onSaved: (value) {
                  _metodoPago = value!;
                },
              ),
              SizedBox(height: 20),

              Text("Tipo de Vehículo", style: TextStyle(fontSize: 16)),
              TextFormField(
                decoration: InputDecoration(hintText: "Ingrese el tipo de vehículo"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el tipo de vehículo';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tipoVehiculo = value!;
                },
              ),
              SizedBox(height: 20),

              Text("Punto de Origen", style: TextStyle(fontSize: 16)),
              TextFormField(
                decoration: InputDecoration(hintText: "Ingrese el punto de origen"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el punto de origen';
                  }
                  return null;
                },
                onSaved: (value) {
                  _origen = value!;
                },
              ),
              SizedBox(height: 20),

              Text("Punto de Destino", style: TextStyle(fontSize: 16)),
              TextFormField(
                decoration: InputDecoration(hintText: "Ingrese el punto de destino"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el punto de destino';
                  }
                  return null;
                },
                onSaved: (value) {
                  _destino = value!;
                },
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Procesar la información
                    _mostrarExito(context);
                  }
                },
                child: Text("Confirmar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                "¡Solicitud Exitosa!",
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
            "Tu solicitud ha sido enviada correctamente. Te contactaremos pronto.",
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
}
