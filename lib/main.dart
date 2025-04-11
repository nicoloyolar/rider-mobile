import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:rider/theme/app_theme.dart';
import 'package:rider/login_screen.dart';
import 'package:rider/formulario_traslado_screen.dart';
import 'package:rider/mapa_traslado_screen.dart';
import 'package:rider/splash_screen.dart';

final ValueNotifier<ThemeData> appThemeNotifier = ValueNotifier(AppTheme.userTheme); // default

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          home: const SplashScreen(),
          routes: {
            '/formularioTraslado': (context) => const FormularioTrasladoScreen(titulo: 'Nuevo Viaje'),
            '/mapaTraslado': (context) => const MapaTrasladoScreen(),
          },
        );
      },
    );
  }
}
