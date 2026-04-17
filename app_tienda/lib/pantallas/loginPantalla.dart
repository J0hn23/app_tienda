import 'package:app_tienda/providers/providerAutorizacionFireBase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPantalla extends StatelessWidget {
  final email = TextEditingController(); //paco@paco.es
  final pass = TextEditingController(); //paco123

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ProviderAutorizacionFirebase>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              'Bienvenido a tu tienda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 125),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.email),
                hintText: 'paco@paco.es',
              ),
            ),
            SizedBox(height: 75),
            TextField(
              controller: pass,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(Icons.lock),
                hintText: 'paco123',
              ),
            ),
            SizedBox(height: 75),
            ElevatedButton(
              onPressed: () async {
                try {
                  await auth.login(email.text, pass.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuario logueado correctamente')),
                  );
                  await Future.delayed(Duration(seconds: 3));
                  Navigator.pushReplacementNamed(context, 'home');
                } catch (e) {
                  String mensaje = '';
                  if (e is FirebaseAuthException) {
                    if (e.code == 'user-not-found') {
                      mensaje = "Usuario no existe";
                    } else if (e.code == 'wrong-password') {
                      mensaje = "Contraseña incorrecta";
                    }
                    ScaffoldMessenger.of(context,).showSnackBar(SnackBar(content: Text(mensaje)));
                  }
                }
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 9, 100, 36),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                minimumSize: Size(200, 50),
                side: BorderSide(color: Colors.green),
              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18),
                selectionColor: Colors.green,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'registro');
              },
              child: Text(
                'Regístrarse',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
