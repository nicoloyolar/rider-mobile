import 'package:flutter/material.dart';
import 'package:rider/theme/app_theme.dart';
import 'login_screen.dart';
import 'package:rider/formulario_traslado_screen.dart';
import 'package:rider/mapa_traslado_screen.dart';

final ValueNotifier<ThemeData> appThemeNotifier = ValueNotifier(AppTheme.userTheme); // default

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: appThemeNotifier,
      builder: (context, theme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const LoginScreen(),
          routes: {
            '/formularioTraslado': (context) => const FormularioTrasladoScreen(titulo: 'Nuevo Viaje'),
            '/mapaTraslado': (context) => const MapaTrasladoScreen(),
          },
        );
      },
    );
  }
}
