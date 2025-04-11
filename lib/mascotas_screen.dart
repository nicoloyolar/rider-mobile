import 'package:flutter/material.dart';

class ServicioMascotasScreen extends StatefulWidget {
  const ServicioMascotasScreen({super.key});

  @override
  State<ServicioMascotasScreen> createState() => _ServicioMascotasScreenState();
}

class _ServicioMascotasScreenState extends State<ServicioMascotasScreen> {
  final TextEditingController _origenController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();

  String? _tipoMascota;
  bool _vaEnCanil = false;

  void _continuar() {
    final origen = _origenController.text.trim();
    final destino = _destinoController.text.trim();

    if (origen.isEmpty || destino.isEmpty || _tipoMascota == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes ingresar origen, destino y tipo de mascota'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/mapaTraslado',
      arguments: {
        'origen': origen,
        'destino': destino,
        'tipoMascota': _tipoMascota!,
        'vaEnCanil': _vaEnCanil.toString(),
      },
    );
  }

  Widget _tarjetaMascota(String tipo, IconData icono) {
    final bool seleccionado = _tipoMascota == tipo;
    return GestureDetector(
      onTap: () => setState(() => _tipoMascota = tipo),
      child: Container(
        decoration: BoxDecoration(
          color: seleccionado ? const Color(0xFF0462FF) : Colors.white,
          border: Border.all(
            color: seleccionado ? const Color(0xFF0462FF) : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icono, color: seleccionado ? Colors.white : Colors.black),
            const SizedBox(width: 12),
            Text(
              tipo,
              style: TextStyle(
                fontSize: 16,
                color: seleccionado ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traslado de Mascotas'),
        backgroundColor: const Color(0xFF0462FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _origenController,
              decoration: const InputDecoration(
                labelText: 'Dirección de origen',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _destinoController,
              decoration: const InputDecoration(
                labelText: 'Dirección de destino',
                prefixIcon: Icon(Icons.flag),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Tipo de mascota:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _tarjetaMascota('Perro', Icons.pets)),
                const SizedBox(width: 12),
                Expanded(child: _tarjetaMascota('Gato', Icons.pets_outlined)),
              ],
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text('¿Va en canil?'),
              value: _vaEnCanil,
              onChanged: (value) => setState(() => _vaEnCanil = value ?? false),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _continuar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0462FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
