import 'package:app_tienda/providers/providerAutorizacionFireBase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistroPantalla extends StatelessWidget {
  //const RegistroPantalla({super.key});

  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ProviderAutorizacionFirebase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuario'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Introduzca sus datos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 150),
            Text(
              'Email:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Introduce aquí tu email",
                icon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 100),
            Text(
              'Password:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: pass,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Introduce aquí tu contraseña",
                icon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () async {
                try {
                  auth.register(email.text, pass.text);

                  Navigator.pushReplacementNamed(context, 'home');
                } catch (e) {
                  String mensaje = "Error";

                  if (e is FirebaseAuthException) {
                    if (e.code == 'email-already-in-use') {
                      mensaje = "El email ya está registrado";
                    } else if (e.code == 'weak-password') {
                      mensaje = "Contraseña demasiado débil";
                    }
                  }

                  ScaffoldMessenger.of( context,).showSnackBar(SnackBar(content: Text(mensaje)));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 9, 100, 36),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                minimumSize: Size(200, 50),
              ),
              child: Text(
                "Subir",
                style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
