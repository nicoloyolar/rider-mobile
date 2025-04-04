import 'package:flutter/material.dart';
import 'package:rider/account_screen.dart';
import 'package:rider/main_screen.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historial', 
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Color(0xFF0462FF), 
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'No se han encontrado registros de viajes.',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ViajesScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CuentaScreen()),
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
}