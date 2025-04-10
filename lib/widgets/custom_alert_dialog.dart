import 'package:flutter/material.dart';
import 'package:rider/theme/app_colors.dart';
import 'package:rider/theme/app_text_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomAlertDialog({
    required this.title,
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: backgroundColor,
            child: Icon(icon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.title,
          ),
        ],
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.body,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: onPressed,
            child: Center(
              child: Text(
                'Aceptar',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
