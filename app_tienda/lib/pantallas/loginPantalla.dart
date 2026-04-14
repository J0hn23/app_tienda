import 'package:app_tienda/providers/providerAutorizacionFireBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPantalla extends StatelessWidget {
  final email = TextEditingController();//paco@paco.es
  final pass = TextEditingController();//paco123

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ProviderAutorizacionFirebase>(context);
    

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 150,),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.email),
                hintText: 'paco@paco.es',
              ),
            ),
            SizedBox(height: 100,),
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
            SizedBox(height: 100,),
            ElevatedButton(
              onPressed: () async {
                 try {
                    await auth.login(email.text, pass.text);

                    Navigator.pushReplacementNamed(context, 'home');

                  } catch (e) {
                    print('Error en el login: $e');
                  }
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
}
}