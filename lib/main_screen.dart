import 'package:flutter/material.dart';
import 'package:rider/account_screen.dart';
import 'package:rider/adulto_mayor_screen.dart';
import 'package:rider/entregas_screen.dart';
import 'package:rider/farmacia_screen.dart';
import 'package:rider/history_screen.dart';
import 'package:rider/mascotas_screen.dart';
import 'package:rider/no_conduzca_screen.dart';
import 'package:rider/reserva_screen.dart';
import 'package:rider/revision_tecnica_screen.dart';
import 'package:rider/taller_screen.dart';
import 'package:rider/traslado_ciudad_screen.dart';
import 'package:rider/traslados_screen.dart';
import 'package:rider/widgets/custom_app_bar.dart'; 

class ViajesScreen extends StatelessWidget {
  final String userEmail;

  const ViajesScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Rider App',  
        userEmail: userEmail,  
        onLogout: () {
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Forma de Reservar'),
            _buildServiceGrid(context, [
              _buildServiceCard(context, 'Traslados', Icons.directions_car),
              _buildServiceCard(context, 'Reserva', Icons.calendar_today),
            ], isTall: true), 

            const SizedBox(height: 20),

            _buildSectionTitle('Entregas'),
            _buildServiceGrid(context, [
              _buildServiceCard(context, 'Entregas', Icons.local_shipping),
              _buildServiceCard(context, 'Puerta a Puerta', Icons.home),
              _buildServiceCard(context, 'Farmacia', Icons.local_pharmacy),
            ], crossAxisCount: 3, isTall: false), 

            const SizedBox(height: 20),

            _buildSectionTitle('Otros Servicios'),
            _buildServiceGrid(context, [
              _buildServiceCard(context, 'Taller', Icons.build),
              _buildServiceCard(context, 'Si bebe no conduzca', Icons.child_care),
              _buildServiceCard(context, 'Revisión Técnica', Icons.car_repair),
              _buildServiceCard(context, 'Traslado a otras ciudades', Icons.pets),
              _buildServiceCard(context, 'Adulto Mayor', Icons.pets),
              _buildServiceCard(context, 'Mascotas', Icons.pets),
            ], isTall: true),

            const SizedBox(height: 20),

            _buildSectionTitle('Reservas'),
            _buildServiceGrid(context, [
              _buildServiceCard(context, 'Calendario de Reservas', Icons.calendar_month),
            ], isTall: true), 
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF0462FF),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0462FF),
        ),
      ),
    );
  }

  Widget _buildServiceGrid(BuildContext context, List<Widget> cards, {int crossAxisCount = 2, bool isTall = true}) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), 
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: isTall ? 1.2 : 0.8, 
      children: cards,
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (title == 'Traslados') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TrasladosScreen()),
            );
          } else if (title == 'Reserva') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReservaScreen()),
            );
          } else if (title == 'Entregas') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RiderEntregaScreen()),
            );
          } else if (title == 'Puerta a Puerta') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RiderEntregaScreen()),
            );
          } else if (title == 'Farmacia') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicioFarmaciaScreen()),
            );
          } else if (title == 'Taller') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TallerScreen()),
            );
          } else if (title == 'Si bebe no conduzca') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SiNoDeboConducirScreen()),
            );
          } else if (title == 'Revisión Técnica') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RevisionTecnicaScreen()),
            );
          } else if (title == 'Traslado a otras ciudades') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TrasladoCiudadScreen()),
            );
          } else if (title == 'Adulto Mayor') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicioAdultoMayorScreen()),
            );
          } else if (title == 'Mascotas') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicioMascotasScreen()),
            );
          } 
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Color(0xFF0462FF)),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}