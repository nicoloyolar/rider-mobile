import 'package:flutter/material.dart';
import 'package:rider/login_screen.dart';
import 'custom_alert_dialog.dart';  
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userEmail;  
  final VoidCallback onLogout;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.userEmail,  
    required this.onLogout,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0462FF),  
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            _showLogoutDialog(context);
          },
          tooltip: 'Cerrar sesión',
          color: Colors.white,
        ),
      ],
      automaticallyImplyLeading: false,  
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),  
            Text(
              userEmail,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontStyle: FontStyle.italic, 
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Cerrar sesión',
          message: '¿Estás seguro de que deseas cerrar sesión?',
          icon: Icons.exit_to_app,
          backgroundColor: Colors.red,  
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()), 
            );
          },
        );
      },
    );
  }
}
