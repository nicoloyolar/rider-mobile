
import 'package:flutter/material.dart';

class FormularioTrasladoScreen extends StatefulWidget {
  final String titulo;
  final Widget? extraInputs;

  const FormularioTrasladoScreen({
    super.key,
    required this.titulo,
    this.extraInputs,
  });

  @override
  State<FormularioTrasladoScreen> createState() => _FormularioTrasladoScreenState();
}

class _FormularioTrasladoScreenState extends State<FormularioTrasladoScreen> {
  final TextEditingController _origenController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();

  void _continuar() {
    if (_origenController.text.isEmpty || _destinoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor completa origen y destino."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navegación hacia la pantalla de mapa (se puede adaptar para cada servicio)
    Navigator.pushNamed(
      context,
      '/mapaTraslado',
      arguments: {
        'origen': _origenController.text,
        'destino': _destinoController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        backgroundColor: const Color(0xFF0462FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInput('Dirección de Origen', _origenController, Icons.location_on),
            const SizedBox(height: 12),
            _buildInput('Dirección de Destino', _destinoController, Icons.flag),
            const SizedBox(height: 20),
            if (widget.extraInputs != null) widget.extraInputs!,
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _continuar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0462FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Continuar", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF0462FF)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
