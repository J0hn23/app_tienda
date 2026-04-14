import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



void main() => runApp(AppState());



//Hay que crear la calsa appState para usar el multiprovider y asi poder usar el provider en toda la app, no solo en una pantalla concreta
//y en el void main iniciar la app por appstate y en su hijo inicio Myapp
class AppState extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers:[
          ChangeNotifierProvider(create: (_) => ProductsServices(),) //este es el provider que sera escuchado por la calase que diga abajo

      ],
      child: MyApp(), //esta es la clase que tendra acceso a el , es decir toda la app
    );
  } 
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi tienda',
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginPantalla(),
        'home': (_) => HomePantalla(),
        
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.lightGreen,
      ),
    );
  }
}



  

