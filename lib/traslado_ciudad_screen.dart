// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TrasladoCiudadScreen extends StatefulWidget {
  const TrasladoCiudadScreen({super.key});

  @override
  _TrasladoCiudadScreenState createState() => _TrasladoCiudadScreenState();
}

class _TrasladoCiudadScreenState extends State<TrasladoCiudadScreen> {
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();
  TextEditingController origenController = TextEditingController();
  TextEditingController destinoController = TextEditingController();
  String metodoPago = 'Efectivo';
  String tipoTraslado = 'Persona';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traslado de Ciudad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: fechaController,
              decoration: InputDecoration(
                hintText: 'Selecciona la fecha',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                DateTime selectedDate = DateTime.now();
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    fechaController.text = "${picked.toLocal()}".split(' ')[0];
                  });
                }
              },
            ),
            SizedBox(height: 10),
            Text('Hora:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: horaController,
              decoration: InputDecoration(
                hintText: 'Selecciona la hora',
                suffixIcon: Icon(Icons.access_time),
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay selectedTime = TimeOfDay.now();
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null && picked != selectedTime) {
                  setState(() {
                    horaController.text = picked.format(context);
                  });
                }
              },
            ),
            SizedBox(height: 10),
            Text('Método de Pago:', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: metodoPago,
              onChanged: (String? newValue) {
                setState(() {
                  metodoPago = newValue!;
                });
              },
              items: <String>['Efectivo', 'Tarjeta', 'Transferencia']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Tipo de Traslado:', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: tipoTraslado,
              onChanged: (String? newValue) {
                setState(() {
                  tipoTraslado = newValue!;
                });
              },
              items: <String>['Persona', 'Vehículo']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Punto de Origen:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: origenController,
              decoration: InputDecoration(
                hintText: 'Introduce el punto de origen',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 10),
            Text('Punto de Destino:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: destinoController,
              decoration: InputDecoration(
                hintText: 'Introduce el punto de destino',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí podrías agregar la lógica para enviar los datos
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmación'),
                      content: Text('Traslado programado exitosamente.'),
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
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
              ),
              child: Text('Confirmar Traslado'),
            ),
          ],
        ),
      ),
    );
  }
}
