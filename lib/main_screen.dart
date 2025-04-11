import 'package:flutter/material.dart';
import 'package:rider/adulto_mayor_screen.dart';
import 'package:rider/entregas_screen.dart';
import 'package:rider/farmacia_screen.dart';
import 'package:rider/mascotas_screen.dart';
import 'package:rider/no_conduzca_screen.dart';
import 'package:rider/reserva_screen.dart';
import 'package:rider/revision_tecnica_screen.dart';
import 'package:rider/taller_screen.dart';
import 'package:rider/traslado_ciudad_screen.dart';
import 'package:rider/traslados_screen.dart';
import 'package:rider/history_screen.dart';
import 'package:rider/account_screen.dart';

class ViajesScreen extends StatelessWidget {
  final String userEmail;

  const ViajesScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(0),
  child: AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
  ),
),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Hola, ${_formatearNombre(userEmail)} 👋',
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
    const CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage('assets/logo.png'), // Tu logo aquí
    ),
  ],
),
              const Text('¿Qué necesitas hoy?',
                  style: TextStyle(fontSize: 18, color: Colors.black54)),
              const SizedBox(height: 24),

              _buildSectionTitle('Forma de Reservar'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildCard(context, 'Traslados', Icons.directions_car,
                      'Solicita un viaje desde tu ubicación actual a un destino específico.',
                      const TrasladosScreen())),
                  const SizedBox(width: 12),
                  Expanded(child: _buildCard(context, 'Reserva', Icons.calendar_today,
                      'Agenda un viaje con fecha y hora definida.',
                      const ReservaScreen())),
                ],
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Entregas'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildCard(context, 'Entregas', Icons.local_shipping,
                      'Envía objetos o documentos a otra dirección.',
                      const RiderEntregaScreen())),
                  const SizedBox(width: 12),
                  Expanded(child: _buildCard(context, 'Puerta a Puerta', Icons.home,
                      'Servicio directo entre dos ubicaciones.',
                      const RiderEntregaScreen())),
                  const SizedBox(width: 12),
                  Expanded(child: _buildCard(context, 'Farmacia', Icons.local_pharmacy,
                      'Solicita el retiro de medicamentos desde una farmacia.',
                      const ServicioFarmaciaScreen())),
                ],
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Otros Servicios'),
const SizedBox(height: 12),
SizedBox(
  height: 100,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
      _buildMiniCard(context, 'Pet Friendly', Icons.pets, const ServicioMascotasScreen(), highlight: true),
      _buildMiniCard(context, 'Taller', Icons.build, const TallerScreen()),
      _buildMiniCard(context, 'No Conduzca', Icons.emoji_people, const SiNoDeboConducirScreen()),
      _buildMiniCard(context, 'Revisión Técnica', Icons.car_repair, const RevisionTecnicaScreen()),
      _buildMiniCard(context, 'Adulto Mayor', Icons.elderly, const ServicioAdultoMayorScreen()),
      _buildMiniCard(context, 'Otras Ciudades', Icons.location_city, const TrasladoCiudadScreen()),
    ],
  ),
),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HistorialScreen(userEmail: userEmail)),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CuentaScreen(userEmail: userEmail)),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Viajes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cuenta'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String description, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Theme.of(context).primaryColor),
            const SizedBox(height: 12),
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 6),
            //Text(description,
              //  style: const TextStyle(fontSize: 12, color: Colors.black54),
                //textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniCard(BuildContext context, String title, IconData icon, Widget screen, {bool highlight = false}) {
  final bgColor = highlight ? Colors.green.shade100 : Colors.orange.shade100;
  final iconColor = highlight ? Colors.green : Colors.orange;

  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    },
    child: Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: iconColor),
          const SizedBox(height: 6),
          Text(title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

  String _formatearNombre(String email) {
    return email.split('@').first.replaceFirstMapped(RegExp(r'^.'), (m) => m[0]!.toUpperCase());
  }
}
