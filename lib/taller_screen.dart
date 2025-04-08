// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:rider/widgets/custom_alert_dialog.dart';

class TallerScreen extends StatefulWidget {
  const TallerScreen({super.key});

  @override
  _TallerScreenState createState() => _TallerScreenState();
}

class _TallerScreenState extends State<TallerScreen> {
  String? _tipoVehiculo;
  String? _modoServicio;
  DateTime? _fechaSeleccionada;
  TimeOfDay? _horaSeleccionada;
  String? _metodoPago;
  String _costoServicio = "0"; 

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

  void _calcularCosto() {
    double costoBase = 100.0; 
    if (_tipoVehiculo == "Moto") {
      costoBase = 50.0; 
    } else if (_tipoVehiculo == "Camioneta") {
      costoBase = 120.0; 
    }

    if (_modoServicio == "Traslado y devolución") {
      costoBase *= 1.5; 
    }

    setState(() {
      _costoServicio = costoBase.toStringAsFixed(2);
    });
  }

  void _mostrarExito() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "¡Reserva Exitosa!",
          message:
              "Tu cita en el taller ha sido agendada correctamente. No olvides proporcionar el dinero para el servicio y los documentos del vehículo.",
          icon: Icons.check_circle,
          backgroundColor: const Color(0xFF0462FF),
          onPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servicio de Taller", style: TextStyle(color: Colors.white)),
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
                _buildDropdownField(
                  label: "Tipo de vehículo",
                  icon: Icons.directions_car,
                  value: _tipoVehiculo,
                  items: ["Auto", "Moto", "Camioneta"],
                  onChanged: (String? newValue) {
                    setState(() {
                      _tipoVehiculo = newValue;
                    });
                    _calcularCosto(); 
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
                _buildDropdownField(
                  label: "Tipo de servicio",
                  icon: Icons.work,
                  value: _modoServicio,
                  items: ["Solo traslado al taller", "Traslado y devolución"],
                  onChanged: (String? newValue) {
                    setState(() {
                      _modoServicio = newValue;
                    });
                    _calcularCosto();
                  },
                ),
                const SizedBox(height: 10),
                if (_modoServicio == "Traslado y devolución") ...[
                  _buildInputField(
                    label: "Origen",
                    icon: Icons.location_on,
                    readOnly: true,
                  ),
                  _buildInputField(
                    label: "Parada (Taller)",
                    icon: Icons.location_on,
                    readOnly: true,
                  ),
                  _buildInputField(
                    label: "Destino",
                    icon: Icons.location_on,
                    readOnly: true,
                  ),
                ] else ...[
                  _buildInputField(
                    label: "Origen",
                    icon: Icons.location_on,
                    readOnly: true,
                  ),
                  _buildInputField(
                    label: "Destino",
                    icon: Icons.location_on,
                    readOnly: true,
                  ),
                ],
                const SizedBox(height: 10),
                _buildDropdownField(
                  label: "Método de pago",
                  icon: Icons.payment,
                  value: _metodoPago,
                  items: ["Efectivo", "Tarjeta", "Transferencia"],
                  onChanged: (String? newValue) {
                    setState(() {
                      _metodoPago = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _mostrarExito,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0462FF),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Confirmar Reserva',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(border: InputBorder.none),
              onChanged: onChanged,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(icon, color: Colors.blue),
                      const SizedBox(width: 10),
                      Text(item),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required bool readOnly,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: TextField(
              readOnly: readOnly,
              decoration: InputDecoration(
                hintText: "Seleccionar ubicación",
                border: InputBorder.none,
                icon: Icon(icon, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
