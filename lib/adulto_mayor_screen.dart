// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';

class ServicioAdultoMayorScreen extends StatefulWidget {
  const ServicioAdultoMayorScreen({super.key});

  @override
  _ServicioAdultoMayorScreenState createState() =>
      _ServicioAdultoMayorScreenState();
}

class _ServicioAdultoMayorScreenState extends State<ServicioAdultoMayorScreen> {
  final _formKey = GlobalKey<FormState>();

  // Variables para almacenar los datos del formulario
  String? _personaSeleccionada;
  String? _metodoPago;
  String? _tipoVehiculo;
  String? _origen;
  String? _destino;

  // Lista de opciones para los métodos de pago, tipo de vehículo, etc.
  List<String> opcionesPersona = ['Usuario', 'Adulto Mayor'];
  List<String> opcionesMetodoPago = ['Efectivo', 'Tarjeta'];
  List<String> opcionesTipoVehiculo = ['Sedán', 'SUV', 'Camioneta'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicio de Adulto Mayor"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seleccione para quién es el servicio:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _personaSeleccionada,
                  items: opcionesPersona
                      .map((persona) => DropdownMenuItem<String>(
                            value: persona,
                            child: Text(persona),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _personaSeleccionada = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: '¿Para quién es el servicio?',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Seleccione el método de pago:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _metodoPago,
                  items: opcionesMetodoPago
                      .map((metodo) => DropdownMenuItem<String>(
                            value: metodo,
                            child: Text(metodo),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _metodoPago = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Método de pago',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Seleccione el tipo de vehículo:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _tipoVehiculo,
                  items: opcionesTipoVehiculo
                      .map((vehiculo) => DropdownMenuItem<String>(
                            value: vehiculo,
                            child: Text(vehiculo),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _tipoVehiculo = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Tipo de vehículo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Punto de origen:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ingrese punto de origen',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _origen = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Punto de destino:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ingrese punto de destino',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _destino = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Aquí se procesarían los datos
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('¡Solicitud Enviada!'),
                            content: Text('Su solicitud de servicio ha sido registrada correctamente.'),
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
                  child: Text('Enviar Solicitud'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
