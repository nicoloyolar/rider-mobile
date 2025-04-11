import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/login_screen.dart';
import '/main_screen.dart';
import '/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasInternet = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkInternet();
    _timer = Timer(const Duration(seconds: 2), _navigateNext);
  }

  Future<void> _checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      _hasInternet = result != ConnectivityResult.none;
    });
  }

  Future<void> _navigateNext() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('first_time') ?? true;
  bool showWelcomeScreen = prefs.getBool('show_welcome_screen') ?? true;

  // 🔒 Verificación real con Firebase
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLoggedIn = currentUser != null;
  String email = currentUser?.email ?? 'usuario';

  if (!_hasInternet) return;

  if (isFirstTime || showWelcomeScreen) {
    bool doNotShowAgain = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(
              username: email,
              isOwner: false,
              showNoMoreButton: !isFirstTime,
              onNext: _onNextPressed,
            ),
          ),
        ) ??
        false;

    if (doNotShowAgain) {
      await prefs.setBool('show_welcome_screen', false);
    }
    await prefs.setBool('first_time', false);
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            isLoggedIn ? ViajesScreen(userEmail: email) : const LoginScreen(),
      ),
    );
  }
}

  void _onNextPressed() {
    // 🔁 Simulación temporal:
    const email = 'usuario';

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ViajesScreen(userEmail: email),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.directions_car, size: 100, color: Colors.blueAccent),
              const SizedBox(height: 16.0),
              const CircularProgressIndicator(),
              const SizedBox(height: 24.0),
              if (!_hasInternet)
                const Text(
                  'Sin conexión a Internet. Por favor verifica tu red.',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              else
                const Text(
                  'Cargando Rider Chile... Conecta personas, destinos y soluciones. 🚗',
                  style: TextStyle(fontSize: 16.0, color: Colors.black54),
                  textAlign: TextAlign.center,
                )
            ],
          ),
        ),
      ),
    );
  }
}
