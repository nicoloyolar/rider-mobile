import 'package:flutter/material.dart';
import 'package:rider/theme/app_text_styles.dart';

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
    Color estadoColor = viaje.estado == 'Completado'
        ? Colors.green
        : Colors.orange;

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
              '${viaje.origen} → ${viaje.destino}',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: 10),
            Text(
              '${viaje.fecha}, ${viaje.hora}',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 10),
            Text(
              'Costo: \$${viaje.costo.toStringAsFixed(0)}',
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor, // <- actualizado
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Estado: ${viaje.estado}',
              style: AppTextStyles.caption.copyWith(color: estadoColor),
            ),
          ],
        ),
      ),
    );
  }
}
