// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';

class ServicioMascotasScreen extends StatefulWidget {
  const ServicioMascotasScreen({super.key});

  @override
  _ServicioMascotasScreenState createState() => _ServicioMascotasScreenState();
}

class _ServicioMascotasScreenState extends State<ServicioMascotasScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _metodoPago;
  String? _tipoVehiculo;
  String? _origen;
  String? _destino;
  String? _nombreMascota;
  String? _tipoMascota;
  String? _tamanoMascota;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicio de Mascotas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text("Datos del Servicio de Mascotas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre de la Mascota',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de la mascota';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _nombreMascota = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tipo de Mascota (Perro, Gato, etc.)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el tipo de mascota';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _tipoMascota = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tamaño de la Mascota (Pequeño, Mediano, Grande)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el tamaño de la mascota';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _tamanoMascota = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Punto de Origen',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el punto de origen';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _origen = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Punto de Destino',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el punto de destino';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _destino = value;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Método de Pago',
                  border: OutlineInputBorder(),
                ),
                value: _metodoPago,
                onChanged: (String? newValue) {
                  setState(() {
                    _metodoPago = newValue;
                  });
                },
                items: <String>['Efectivo', 'Tarjeta de Crédito', 'Transferencia']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un método de pago';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Tipo de Vehículo',
                  border: OutlineInputBorder(),
                ),
                value: _tipoVehiculo,
                onChanged: (String? newValue) {
                  setState(() {
                    _tipoVehiculo = newValue;
                  });
                },
                items: <String>['Automóvil', 'Furgoneta', 'Camioneta']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un tipo de vehículo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Procesar la solicitud
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('¡Solicitud Enviada!'),
                          content: Text('Tu solicitud para el servicio de transporte de mascotas ha sido procesada.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Enviar Solicitud'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
