// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class ReservaScreen extends StatefulWidget {
  const ReservaScreen({super.key});

  @override
  _ReservaScreenState createState() => _ReservaScreenState();
}

class _ReservaScreenState extends State<ReservaScreen> {
  final TextEditingController _origenController = TextEditingController();
  final List<TextEditingController> _destinosControllers = [];
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  late GoogleMapController _mapController;
  final LatLng _initialPosition = LatLng(-33.45694, -70.64827); 
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _destinosControllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserva', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0462FF),
        centerTitle: true,
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
              _setMarkers(); 
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
                    TextField(
                      controller: _origenController,
                      decoration: InputDecoration(
                        labelText: 'Origen',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.location_on, color: Color(0xFF0462FF)),
                      ),
                      onChanged: (text) {
                        _setMarkers(); 
                      },
                    ),
                    const SizedBox(height: 10),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _destinosControllers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _destinosControllers[index],
                                    decoration: InputDecoration(
                                      labelText: 'Destino ${index + 1}',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      prefixIcon: Icon(Icons.location_on, color: Color(0xFF0462FF)),
                                    ),
                                    onChanged: (text) {
                                      _setMarkers(); 
                                    },
                                  ),
                                ),
                                if (index > 0) 
                                  IconButton(
                                    icon: Icon(Icons.remove_circle, color: Colors.red),
                                    onPressed: () {
                                      _eliminarDestino(index);
                                    },
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),

                    ElevatedButton.icon(
                      onPressed: _agregarDestino,
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text(
                        'Agregar Destino',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0462FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: _fechaController,
                      decoration: InputDecoration(
                        labelText: 'Fecha del viaje',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF0462FF)),
                      ),
                      readOnly: true, 
                      onTap: () => _seleccionarFecha(context),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: _horaController,
                      decoration: InputDecoration(
                        labelText: 'Hora del viaje',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.access_time, color: Color(0xFF0462FF)),
                      ),
                      readOnly: true, 
                      onTap: () => _seleccionarHora(context),
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
                onPressed: _solicitarReserva,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0462FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Solicitar Reserva',
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

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fechaController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _seleccionarHora(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _horaController.text = picked.format(context);
      });
    }
  }

  void _setMarkers() {
    _markers.clear();

    if (_origenController.text.isNotEmpty) {
      _markers.add(Marker(
        markerId: MarkerId('origen'),
        position: _initialPosition, 
        infoWindow: InfoWindow(title: 'Origen: ${_origenController.text}'),
      ));
    }

    for (var i = 0; i < _destinosControllers.length; i++) {
      if (_destinosControllers[i].text.isNotEmpty) {
        _markers.add(Marker(
          markerId: MarkerId('destino$i'),
          position: _initialPosition, 
          infoWindow: InfoWindow(title: 'Destino ${i + 1}: ${_destinosControllers[i].text}'),
        ));
      }
    }

    setState(() {}); 
  }

  void _solicitarReserva() {
    final origen = _origenController.text;
    final destinos = _destinosControllers.map((controller) => controller.text).toList();
    final fecha = _fechaController.text;
    final hora = _horaController.text;

    if (origen.isEmpty || destinos.any((destino) => destino.isEmpty) || fecha.isEmpty || hora.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, completa todos los campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _mostrarConfirmacion(context);
  }

  void _mostrarConfirmacion(BuildContext context) {
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
                "¡Reserva Confirmada!",
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
            "¡Tu solicitud de reserva ha sido procesada!\n\nEstarás notificado cuando sea la hora de tu viaje o debes estar en la ubicación indicada a la hora especificada.",
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
