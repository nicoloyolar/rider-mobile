// ignore_for_file: unused_field, library_private_types_in_public_api, prefer_final_fields

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

  void _mostrarExito() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF0462FF),
                child: const Icon(Icons.check_circle, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 10),
              const Text(
                "¡Reserva Exitosa!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: const Text(
            "Tu cita en el taller ha sido agendada correctamente. No olvides proporcionar el dinero para el servicio y los documentos del vehículo.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0462FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Center(
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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Si bebe no conduzca", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0462FF),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Selecciona el tipo de vehículo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                _buildDropdownField(
                  label: "Tipo de vehículo",
                  icon: Icons.directions_car,
                  value: _tipoVehiculo.isEmpty ? null : _tipoVehiculo,
                  items: ["Auto", "Moto", "Camioneta"],
                  onChanged: (String? newValue) {
                    setState(() {
                      _tipoVehiculo = newValue!;
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
                        icon: const Icon(Icons.calendar_today, color: Colors.white),
                        label: Text(
                          _fechaSeleccionada == null ? "Elegir Fecha" : "${_fechaSeleccionada!.toLocal()}".split(' ')[0],
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0462FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _seleccionarHora(context),
                        icon: const Icon(Icons.access_time, color: Colors.white),
                        label: Text(
                          _horaSeleccionada == null ? "Elegir Hora" : _horaSeleccionada!.format(context),
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0462FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Método de pago", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                _buildDropdownField(
                  label: "Método de pago",
                  icon: Icons.payment,
                  value: _metodoPago.isEmpty ? null : _metodoPago,
                  items: ["Efectivo", "Tarjeta", "Transferencia"],
                  onChanged: (String? newValue) {
                    setState(() {
                      _metodoPago = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFF0462FF),
                    ),
                    onPressed: _mostrarExito,
                    child: const Text("Confirmar Reserva", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
