// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rider/verification_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _image;
  File? _certificate;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _emergencyPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickCertificate() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _certificate = File(pickedFile.path);
      });
    }
  }

  Future<void> _registerUser() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Las contraseñas no coinciden")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titlePadding: EdgeInsets.all(20),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFF0462FF),
              child: Icon(Icons.check_circle, color: Colors.white, size: 40),
            ),
            SizedBox(height: 10),
            Text(
              "¡Solicitud Enviada!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        content: Text(
          "Estamos revisando tu solicitud. Recibirás una respuesta en un máximo de 48 horas. Si hay algún problema, te notificaremos en la aplicación.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0462FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  'Aceptar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    await Future.delayed(Duration(seconds: 2));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Correo y SMS enviados")),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerificationScreen()),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Bienvenido ${user.displayName}")),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerificationScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al iniciar sesión con Google")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF0462FF),
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.camera_alt, size: 40, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),

                _buildTextField(_nameController, Icons.person, 'Nombre Completo'),
                const SizedBox(height: 15),
                _buildTextField(_emailController, Icons.email, 'Correo Electrónico'),
                const SizedBox(height: 15),
                _buildTextField(_phoneController, Icons.phone, 'Teléfono'),
                const SizedBox(height: 15),
                _buildTextField(_emergencyNameController, Icons.person, 'Contacto de Emergencia'),
                const SizedBox(height: 15),
                _buildTextField(_emergencyPhoneController, Icons.phone, 'Teléfono de Emergencia'),
                const SizedBox(height: 15),
                _buildTextField(_passwordController, Icons.lock, 'Contraseña', obscureText: true),
                const SizedBox(height: 15),
                _buildTextField(_confirmPasswordController, Icons.lock, 'Confirmar Contraseña', obscureText: true),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: _pickCertificate,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF0462FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        _certificate != null ? "Certificado Cargado" : "Subir Certificado",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0462FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _signInWithGoogle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Iniciar sesión con Google',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '¿Ya tienes una cuenta? Inicia sesión',
                    style: TextStyle(
                      color: Color(0xFF0462FF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon, String label, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF0462FF)),
        ),
        prefixIcon: Icon(icon, color: Color(0xFF0462FF)),
      ),
    );
  }
}
