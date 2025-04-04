// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class RevisionTecnicaScreen extends StatefulWidget {
  const RevisionTecnicaScreen({super.key});

  @override
  _RevisionTecnicaScreenState createState() => _RevisionTecnicaScreenState();
}

class _RevisionTecnicaScreenState extends State<RevisionTecnicaScreen> {
  String? tipoVehiculo;
  String? seleccionServicio;
  DateTime? fechaSeleccionada;
  TimeOfDay? horaSeleccionada;

  void _seleccionarFecha() async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (fecha != null) {
      setState(() {
        fechaSeleccionada = fecha;
      });
    }
  }

  void _seleccionarHora() async {
    TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (hora != null) {
      setState(() {
        horaSeleccionada = hora;
      });
    }
  }

  void _mostrarMensajeRecordatorio() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Recordatorio"),
          content: Text(
            "Recuerda proporcionar el dinero para la revisión técnica y los documentos del vehículo al conductor."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Entendido"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Revisión Técnica")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selecciona la fecha:"),
            ElevatedButton(
              onPressed: _seleccionarFecha,
              child: Text(fechaSeleccionada == null
                  ? "Elegir fecha"
                  : "${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}"),
            ),
            SizedBox(height: 10),
            Text("Selecciona la hora:"),
            ElevatedButton(
              onPressed: _seleccionarHora,
              child: Text(horaSeleccionada == null
                  ? "Elegir hora"
                  : horaSeleccionada!.format(context)),
            ),
            SizedBox(height: 10),
            Text("Selecciona el tipo de vehículo:"),
            DropdownButton<String>(
              value: tipoVehiculo,
              hint: Text("Elige una opción"),
              items: ["Automóvil", "Moto", "Camioneta", "Otro"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  tipoVehiculo = newValue;
                });
              },
            ),
            SizedBox(height: 10),
            Text("Selecciona el servicio:"),
            DropdownButton<String>(
              value: seleccionServicio,
              hint: Text("Elige una opción"),
              items: [
                "Solo llevar al taller",
                "Llevar y devolver"
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  seleccionServicio = newValue;
                  _mostrarMensajeRecordatorio();
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (fechaSeleccionada != null && horaSeleccionada != null && tipoVehiculo != null && seleccionServicio != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Servicio de revisión técnica programado exitosamente."))
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Por favor, completa todos los campos."))
                    );
                  }
                },
                child: Text("Confirmar Servicio"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
