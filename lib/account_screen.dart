import 'package:flutter/material.dart';
import 'package:rider/history_screen.dart';
import 'package:rider/main_screen.dart';
import 'package:rider/widgets/custom_app_bar.dart';

class CuentaScreen extends StatelessWidget {
  final String userEmail;

  const CuentaScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cuenta',  
        userEmail: userEmail,  
        onLogout: () {
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildUserInfo(),
            const SizedBox(height: 20), 

            _buildAccountOption('Perfil', Icons.person),
            _buildAccountOption('Tarjetas Asociadas', Icons.card_giftcard),
            _buildAccountOption('Certifiaciones', Icons.location_on),
            _buildAccountOption('Direcciones Guardadas', Icons.support_agent),
            _buildAccountOption('Soporte', Icons.help_outline),
            _buildAccountOption('Preguntas Frecuentes', Icons.description),
            _buildAccountOption('Términos y Condiciones', Icons.delete, isRed: true),
            _buildAccountOption('Eliminar Cuenta', Icons.logout, isRed: true),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF0462FF),
        unselectedItemColor: Colors.grey,
        currentIndex: 2, 
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HistorialScreen(userEmail: userEmail)),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ViajesScreen(userEmail: userEmail)),
              );
              break;
            case 2:
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

  Widget _buildUserInfo() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre Usuario',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '+56 9 35703311',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(7, (index) {
                      return Icon(
                        Icons.star,
                        color: Colors.amber[500],
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
            ),

            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF0462FF), width: 3),
                color: Colors.white,
              ),
              child: Icon(
                Icons.person,
                size: 50,
                color: Color(0xFF0462FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountOption(String title, IconData icon, {bool isRed = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: isRed ? Colors.red : Color(0xFF0462FF)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isRed ? Colors.red : Colors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: isRed ? Colors.red : Color(0xFF0462FF)),
        onTap: () {
        },
      ),
    );
  }
}