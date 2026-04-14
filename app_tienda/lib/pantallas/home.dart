import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePantalla extends StatelessWidget {
  const HomePantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            
            await FirebaseAuth.instance.signOut();

           // Navigator.pushNamedAndRemoveUntil(context,'login',(route) => false);  
            Navigator.pushReplacementNamed(context, 'login');
          }
        ),
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}