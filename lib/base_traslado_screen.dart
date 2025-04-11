import 'package:flutter/material.dart';

class BaseTrasladoScreen extends StatelessWidget {
  final String titulo;
  final Widget? widgetExtra;
  final VoidCallback? onConfirmar;

  const BaseTrasladoScreen({
    super.key,
    required this.titulo,
    this.widgetExtra,
    this.onConfirmar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Punto de origen', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildUbicacionField('Seleccionar ubicación de inicio'),

            const SizedBox(height: 16),
            const Text('Destino', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildUbicacionField('Seleccionar ubicación de destino'),

            if (widgetExtra != null) ...[
              const SizedBox(height: 24),
              widgetExtra!,
            ],

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirmar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: theme.primaryColor,
                ),
                child: const Text('Confirmar Solicitud'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUbicacionField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.location_on),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
