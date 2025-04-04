import 'package:flutter/material.dart';
import 'package:rider/main_screen.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verificación de Código',
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20,
            fontWeight: FontWeight.bold, 
          ),
        ),
        backgroundColor: Color(0xFF0462FF), 
        foregroundColor: Colors.white, 
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_user,
              size: 80,
              color: Color(0xFF0462FF),
            ),
            const SizedBox(height: 20),

            Text(
              'Ingresa el código de 6 dígitos que recibiste por SMS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF0462FF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF0462FF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF0462FF), width: 2),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
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
                              child: Icon(Icons.verified, color: Colors.white, size: 40),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "¡Cuenta verificada!",
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
                          "Tu cuenta ha sido verificada correctamente. Ahora puedes continuar.",
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
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ViajesScreen()),
                                );
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
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0462FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Continuar',
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
              },
              child: Text(
                'No recibí el código. Reenviar',
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
    );
  }
}