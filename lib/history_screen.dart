import 'package:flutter/material.dart';
import 'package:rider/widgets/custom_app_bar.dart';
import 'package:rider/widgets/viajes_card.dart';

class HistorialScreen extends StatelessWidget {
  final String userEmail;

  HistorialScreen({super.key, required this.userEmail});

  final List<Viaje> viajes = [
    Viaje(
      origen: 'Avenida Libertador, Buenos Aires',
      destino: 'Calle Figueroa Alcorta, Buenos Aires',
      fecha: '2025-04-06',
      hora: '08:30 AM',
      costo: 4.500,
      estado: 'Completado',
    ),
    Viaje(
      origen: 'Av. 9 de Julio, Buenos Aires',
      destino: 'Av. Corrientes, Buenos Aires',
      fecha: '2025-04-05',
      hora: '10:00 AM',
      costo: 3.200,
      estado: 'Completado',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Historial de Viajes',
        userEmail: userEmail,
        onLogout: () {},
      ),
      body: ListView.builder(
        itemCount: viajes.length,
        itemBuilder: (context, index) {
          final viaje = viajes[index];
          return ViajeCard(viaje: viaje); // Usamos el widget ViajeCard
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF0462FF),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              // Navegar a ViajesScreen
              break;
            case 2:
              // Navegar a CuentaScreen
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Viajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cuenta',
          ),
        ],
      ),
    );
  }
}
