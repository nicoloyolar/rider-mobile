// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ServicioAdultoMayorScreen extends StatefulWidget {
  const ServicioAdultoMayorScreen({super.key});


  @override
  _ServicioAdultoMayorScreenState createState() => _ServicioAdultoMayorScreenState();
}

class _ServicioAdultoMayorScreenState extends State<ServicioAdultoMayorScreen> {
  String? _tipoVehiculo;
  String? _modoServicio;
  DateTime? _fechaSeleccionada;  
  TimeOfDay? _horaSeleccionada;

  void _seleccionarFecha(BuildContext context) async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
      });
    }
  }

  void _seleccionarHora(BuildContext context) async {
    TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (hora != null) {
      setState(() {
        _horaSeleccionada = hora;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Revisión Técnica", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0462FF),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const Text("Selecciona el tipo de vehículo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildDropdownField(
                label: "Tipo de vehículo",
                icon: Icons.directions_car,
                value: _tipoVehiculo,
                items: ["Auto", "Moto", "Camioneta"],
                onChanged: (String? newValue) {
                  setState(() {
                    _tipoVehiculo = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _seleccionarFecha(context),
                      icon: Icon(Icons.calendar_today, color: Colors.white),
                      label: Text(
                        _fechaSeleccionada == null ? "Elegir Fecha" : "${_fechaSeleccionada!.toLocal()}".split(' ')[0],
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0462FF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _seleccionarHora(context),
                      icon: Icon(Icons.access_time, color: Colors.white),
                      label: Text(
                        _horaSeleccionada == null ? "Elegir Hora" : _horaSeleccionada!.format(context),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0462FF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Selecciona el tipo de traslado", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildDropdownField(
                label: "Tipo de traslado",
                icon: Icons.work,
                value: _modoServicio,
                items: ["Persona", "Vehículo"],
                onChanged: (String? newValue) {
                  setState(() {
                    _modoServicio = newValue;
                  });
                },
              ),
              ],
            ),
        ),
      ),
    );
  }
}

Widget _buildDropdownField({
  required String label,
  required IconData icon,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Material(
    elevation: 3,
    borderRadius: BorderRadius.circular(12),
    child: DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF0462FF)),
              const SizedBox(width: 8),
              Text(item),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(fontSize: 16),
    ),
  );
}