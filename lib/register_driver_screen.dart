// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class DriverRegisterScreen extends StatefulWidget {
  const DriverRegisterScreen({super.key});

  @override
  _DriverRegisterScreenState createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {
  File? _driverPhoto;
  File? _vehiclePhoto;
  File? _idCard;
  File? _license;
  File? _permit;
  File? _technicalReview;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _emergencyPhoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(Function(File?) setImage) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        setImage(File(pickedFile.path));
      });
    }
  }

  Future<void> _registerDriver() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty ||
        _phoneController.text.isEmpty || _emergencyNameController.text.isEmpty ||
        _emergencyPhoneController.text.isEmpty || _driverPhoto == null ||
        _vehiclePhoto == null || _idCard == null || _license == null ||
        _permit == null || _technicalReview == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor completa todos los campos y sube las imágenes requeridas.")),
      );
      return;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Registro exitoso. En revisión.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Registro de Conductores"),
        backgroundColor: Color(0xFF0462FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => _pickImage((image) => _driverPhoto = image),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF0462FF),
                    backgroundImage: _driverPhoto != null ? FileImage(_driverPhoto!) : null,
                    child: _driverPhoto == null ? Icon(Icons.camera_alt, size: 40, color: Colors.white) : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(_nameController, Icons.person, 'Nombre Completo'),
              _buildTextField(_emailController, Icons.email, 'Correo Electrónico'),
              _buildTextField(_phoneController, Icons.phone, 'Teléfono'),
              _buildTextField(_emergencyNameController, Icons.person, 'Contacto de Emergencia'),
              _buildTextField(_emergencyPhoneController, Icons.phone, 'Teléfono de Emergencia'),
              const SizedBox(height: 20),
              _buildImageUploadButton("Foto del Vehículo", _vehiclePhoto, (image) => _vehiclePhoto = image),
              _buildImageUploadButton("Cédula de Identidad", _idCard, (image) => _idCard = image),
              _buildImageUploadButton("Licencia de Conducir", _license, (image) => _license = image),
              _buildImageUploadButton("Permiso de Circulación", _permit, (image) => _permit = image),
              _buildImageUploadButton("Revisión Técnica", _technicalReview, (image) => _technicalReview = image),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _registerDriver,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
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
      ),
    );
  }

  Widget _buildImageUploadButton(String label, File? file, Function(File?) setImage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () => _pickImage(setImage),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF0462FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              file != null ? "$label Cargado" : "Subir $label",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
