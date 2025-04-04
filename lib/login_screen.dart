// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rider/main_screen.dart';
import 'package:rider/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  
final Map<String, Map<String, dynamic>> users = {
    'usuario': {
      'password': '123456',
      'role': 'usuario',
      'certificado': null, 
      'descuento': 0.0,
    },
    'conductor': {
      'password': '123456',
      'role': 'conductor',
      'certificado': null,
      'descuento': 0.0,
    },
    'estudiante': {
      'password': '123456',
      'role': 'usuario',
      'certificado': 'estudiante',
      'descuento': 0.10, 
    },
    'bombero': {
      'password': '123456',
      'role': 'usuario',
      'certificado': 'bombero',
      'descuento': 0.10,
    },
    'adulto_mayor': {
      'password': '123456',
      'role': 'usuario',
      'certificado': 'adulto mayor',
      'descuento': 0.10,
    },
    'discapacitado': {
      'password': '123456',
      'role': 'usuario',
      'certificado': 'discapacitado',
      'descuento': 0.10,
    },
  };

  void _login() {
    String correo   = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (correo.isEmpty || password.isEmpty) {
      _showMessage("Por favor, complete todos los campos");
      return;
    }

    if (users.containsKey(correo) && users[correo]!['password'] == password) {
      String role = users[correo]!['role']!;
      _showMessage("Inicio de sesión exitoso");

      if (role == 'usuario') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ViajesScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ViajesScreen()),
        );
      }
    } else {
      _showMessage("Correo o contraseña incorrectos");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF0462FF), width: 3),
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF0462FF)),
                  ),
                  prefixIcon: Icon(Icons.email, color: Color(0xFF0462FF)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF0462FF)),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF0462FF)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0462FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Ingresar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0462FF)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
