// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:rider/widgets/custom_alert_dialog.dart';
import 'package:rider/theme/app_colors.dart';

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

  String? _origen;
  String? _parada;
  String? _destino;

  void _seleccionarFecha(BuildContext context) async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (fecha != null) {
      setState(() => _fechaSeleccionada = fecha);
    }
  }

  void _seleccionarHora(BuildContext context) async {
    TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (hora != null) {
      setState(() => _horaSeleccionada = hora);
    }
  }

  void _abrirMapaTraslado(String tipo) async {
    if (_tipoVehiculo == null || _modoServicio == null || _fechaSeleccionada == null || _horaSeleccionada == null || _metodoPago == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa primero toda la información antes de seleccionar ubicaciones.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final result = await Navigator.pushNamed(
      context,
      '/mapaTraslado',
      arguments: {'tipo': tipo},
    ) as Map<String, String>?;

    if (result != null) {
      setState(() {
        _origen = result['origen'];
        _destino = result['destino'];
        _parada = result['parada'];
      });
    }
  }

  void _calcularCosto() {
    double costoBase = 100.0;
    if (_tipoVehiculo == "Moto") costoBase = 50.0;
    if (_tipoVehiculo == "Camioneta") costoBase = 120.0;
    if (_modoServicio == "Traslado y devolución") costoBase *= 1.5;
    setState(() => _costoServicio = costoBase.toStringAsFixed(2));
  }

  void _mostrarExito() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "¡Reserva Exitosa!",
          message: "Tu cita en el taller ha sido agendada correctamente. No olvides proporcionar el dinero para el servicio y los documentos del vehículo.",
          icon: Icons.check_circle,
          backgroundColor: AppColors.userPrimary,
          onPressed: () => Navigator.pop(context),
        );
      },
    );
  }

  Widget _buildUbicacionField(String label, String? valor, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.userPrimary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(valor ?? 'Seleccionar $label',
                      style: TextStyle(
                        color: valor == null ? AppColors.textSecondary : AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servicio de Taller", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.userPrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDropdownField("Tipo de vehículo", Icons.directions_car, _tipoVehiculo, ["Auto", "Moto", "Camioneta"], (val) {
                setState(() => _tipoVehiculo = val);
                _calcularCosto();
              }),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _seleccionarFecha(context),
                      icon: const Icon(Icons.calendar_today),
                      label: Text(_fechaSeleccionada == null ? "Elegir Fecha" : "${_fechaSeleccionada!.toLocal()}".split(' ')[0]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.userPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _seleccionarHora(context),
                      icon: const Icon(Icons.access_time),
                      label: Text(_horaSeleccionada == null ? "Elegir Hora" : _horaSeleccionada!.format(context)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.userPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildDropdownField("Tipo de servicio", Icons.work, _modoServicio, ["Solo traslado al taller", "Traslado y devolución"], (val) {
                setState(() => _modoServicio = val);
                _calcularCosto();
              }),
              const SizedBox(height: 10),
              if (_modoServicio != null)
                Column(
                  children: [
                    _buildUbicacionField("Origen", _origen, onTap: () => _abrirMapaTraslado("taller")),
                    if (_modoServicio == "Traslado y devolución")
                      _buildUbicacionField("Parada (Taller)", _parada, onTap: () => _abrirMapaTraslado("taller")),
                    _buildUbicacionField("Destino", _destino, onTap: () => _abrirMapaTraslado("taller")),
                  ],
                ),
              const SizedBox(height: 10),
              _buildDropdownField("Método de pago", Icons.payment, _metodoPago, ["Efectivo", "Tarjeta", "Transferencia"], (val) {
                setState(() => _metodoPago = val);
              }),
              const SizedBox(height: 10),
              Text("Costo estimado: \$$_costoServicio", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _mostrarExito,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.userPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Confirmar Reserva', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, IconData icon, String? value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
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
                      Icon(icon, color: AppColors.userPrimary),
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
}