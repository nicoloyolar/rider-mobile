// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SeleccionRiderWidget extends StatefulWidget {
  final Function(String) onRiderSelected;

  const SeleccionRiderWidget({super.key, required this.onRiderSelected});

  @override
  _SeleccionRiderWidgetState createState() => _SeleccionRiderWidgetState();
}

class _SeleccionRiderWidgetState extends State<SeleccionRiderWidget> {
  String riderSeleccionado = 'Vehículo tradicional';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecciona tu Rider',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _opcionRider('Vehículo tradicional', 'Rider básico', 0),
        _opcionRider('Alta gama', 'Rider París (+1.000 pesos)', 1000),
        _opcionRider('Mayor capacidad', 'Rider XL (desde 5.000 pesos)', 5000),
      ],
    );
  }

  Widget _opcionRider(String titulo, String descripcion, int extraCosto) {
    return GestureDetector(
      onTap: () {
        setState(() {
          riderSeleccionado = titulo;
        });
        widget.onRiderSelected(titulo);
      },
      child: Card(
        elevation: riderSeleccionado == titulo ? 5 : 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                riderSeleccionado == titulo ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: riderSeleccionado == titulo ? Colors.blue : Colors.grey,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    descripcion,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  if (extraCosto > 0)
                    Text(
                      '+ $extraCosto pesos',
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
