import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rider/main.dart'; // importa appThemeNotifier
import 'package:rider/theme/app_theme.dart';
import 'package:rider/widgets/custom_alert_dialog.dart';
import 'package:rider/main_screen.dart';
import 'package:rider/driver_screen.dart';
import 'package:rider/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signInWithEmail() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _handleUserLogin(credential.user);
    } catch (e) {
      _showError("Correo o contraseña incorrectos");
    }
  }

Future<void> _signInWithGoogle() async {
  try {
    final googleUser = await GoogleSignIn().signIn();
    print('GOOGLE USER: $googleUser'); // 👈 VERIFICA ESTO EN LA CONSOLA
    final googleAuth = await googleUser?.authentication;

    if (googleUser != null && googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _handleUserLogin(userCredential.user);
    }
  } catch (e) {
    print('GOOGLE SIGN-IN ERROR: $e'); // 👈 Imprime si falla
    _showError("No se pudo iniciar sesión con Google");
  }
}

  Future<void> _signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken;
        final credential = FacebookAuthProvider.credential(accessToken!.token);
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        _handleUserLogin(userCredential.user);
      } else {
        _showError("Login cancelado");
      }
    } catch (e) {
      _showError("No se pudo iniciar sesión con Facebook");
    }
  }

  Future<void> _handleUserLogin(User? user) async {
    if (user == null) return;

    final correo = user.email ?? "usuario";
    final role = correo == 'conductor@rider.com' ? 'conductor' : 'usuario';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('logged_email', correo);

    if (role == 'usuario') {
      appThemeNotifier.value = AppTheme.userTheme;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ViajesScreen(userEmail: correo)),
      );
    } else {
      appThemeNotifier.value = AppTheme.driverTheme;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DriverScreen(userEmail: correo)),
      );
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: "¡Error!",
        message: message,
        icon: Icons.error,
        backgroundColor: Colors.red,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/logo.png', height: 120),
                const SizedBox(height: 40),

                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signInWithEmail,
                  child: const Text('Ingresar'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Color(0xFF0462FF),
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(),
                const Text("O ingresa con"),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/google.png', height: 40),
                      onPressed: _signInWithGoogle,
                    ),
                    const SizedBox(width: 24),
                    IconButton(
                      icon: Image.asset('assets/icons/facebook.png', height: 40),
                      onPressed: _signInWithFacebook,
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  },
                  child: const Text('¿No tienes cuenta? Regístrate'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
