// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';

class ServicioFarmaciaScreen extends StatefulWidget {
  const ServicioFarmaciaScreen({super.key});

  @override
  _ServicioFarmaciaScreenState createState() => _ServicioFarmaciaScreenState();
}

class _ServicioFarmaciaScreenState extends State<ServicioFarmaciaScreen> {
  bool conReceta = false;
  final TextEditingController _origenController = TextEditingController();
  final TextEditingController _paradaController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();

  void _confirmarPedido() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Column(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF0462FF),
                child: Icon(Icons.check_circle, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 10),
              const Text("¡Pedido Confirmado!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            conReceta
                ? "Recuerda facilitar el dinero previo o realizar la transferencia para la compra del medicamento."
                : "Contacta al conductor a través de WhatsApp para coordinar la compra del medicamento.",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Aceptar", style: TextStyle(color: Color(0xFF0462FF))),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField({required String label, required IconData icon, required TextEditingController controller, bool readOnly = false}) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(icon, color: const Color(0xFF0462FF)),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          filled: true,
          fillColor: Colors.white,
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmacia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0462FF),
        centerTitle: true,
      ),
      body: Center( 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "¿El medicamento requiere receta médica?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Sí"),
                      value: true,
                      groupValue: conReceta,
                      onChanged: (value) => setState(() => conReceta = value!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text("No"),
                      value: false,
                      groupValue: conReceta,
                      onChanged: (value) => setState(() => conReceta = value!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: "Origen",
                icon: Icons.location_on,
                controller: _origenController,
                readOnly: true,
              ),
              const SizedBox(height: 10),
              if (conReceta)
                _buildInputField(
                  label: "Parada (Farmacia)",
                  icon: Icons.local_pharmacy,
                  controller: _paradaController,
                ),
              const SizedBox(height: 10),
              _buildInputField(
                label: "Destino",
                icon: Icons.home,
                controller: _destinoController,
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: _confirmarPedido,
                icon: const Icon(Icons.local_hospital, color: Colors.white, size: 24),
                label: const Text(
                  "Solicitar Rider Farmacia",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  backgroundColor: const Color(0xFF0462FF),
                  elevation: 4, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
