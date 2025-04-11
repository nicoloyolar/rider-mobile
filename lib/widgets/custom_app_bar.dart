import 'package:flutter/material.dart';
import 'package:rider/login_screen.dart';
import 'package:rider/theme/app_text_styles.dart';
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
    final Color primary = Theme.of(context).primaryColor;

    return AppBar(
      backgroundColor: primary,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _showLogoutDialog(context),
          tooltip: 'Cerrar sesión',
          color: Colors.white, // ícono blanco sobre fondo primario
        ),
      ],
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.title.copyWith(color: Colors.white)),
            const SizedBox(height: 4),
            Text(
              userEmail,
              style: AppTextStyles.caption.copyWith(color: Colors.white70),
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
          Navigator.pop(context); // Cierra el diálogo
          onLogout();             // Ejecuta el callback real
        },
      );
    },
  );
}
}