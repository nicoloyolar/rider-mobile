import 'package:flutter/material.dart';

class Viaje {
  final String origen;
  final String destino;
  final String fecha;
  final String hora;
  final double costo;
  final String estado;

  Viaje({
    required this.origen,
    required this.destino,
    required this.fecha,
    required this.hora,
    required this.costo,
    required this.estado,
  });
}

class ViajeCard extends StatelessWidget {
  final Viaje viaje;

  const ViajeCard({super.key, required this.viaje});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${viaje.origen} -> ${viaje.destino}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${viaje.fecha}, ${viaje.hora}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Costo: \$${viaje.costo.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF0462FF),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Estado: ${viaje.estado}',
              style: TextStyle(
                fontSize: 14,
                color: viaje.estado == 'Completado'
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
