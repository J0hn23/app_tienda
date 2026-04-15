import 'package:app_tienda/modelos/producto.dart';
import 'package:app_tienda/pantallas/productoPantalla.dart';
import 'package:app_tienda/servicios/productosServicioFirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tienda/widgets/productoCard.dart';

class HomePantalla extends StatelessWidget {
  const HomePantalla({super.key});

  @override
  Widget build(BuildContext context) {

    final providerProductoFirebase = Provider.of<ProductoServicioFirebase>(context);
    //final contextoPadre=context;

    if (providerProductoFirebase.isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );    
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Tu tienda'),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            
            await FirebaseAuth.instance.signOut();
 
            Navigator.pushReplacementNamed(context, 'login');
          }
        ),
      ),
      body:  
      ListView.builder(
        itemCount: providerProductoFirebase.listaProductos.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ProductoCard(producto: providerProductoFirebase.listaProductos[index]),
          onTap: () { 
            providerProductoFirebase.productoSeleccionado =providerProductoFirebase.listaProductos[index].copyWith(providerProductoFirebase.listaProductos[index].disponible,
               providerProductoFirebase.listaProductos[index].imagen, 
               providerProductoFirebase.listaProductos[index].nombre, 
               providerProductoFirebase.listaProductos[index].precio, 
               providerProductoFirebase.listaProductos[index].id);
              
              Navigator.push(context,MaterialPageRoute(builder: (_) => ProductoPantalla()));
              // Navigator.pushReplacementNamed(contextoPadre, 'producto');
            //Navigator.of(contextoPadre).pushNamed('producto');
             // Navigator.pushNamed(contextoPadre, 'producto');
            //el contextopadre es porque el navigator coge el context del itembuilder y no el de la pantalla, y el provider esta en el contexto de la pantalla, no en el del itembuilder, entonces para que el navigator funcione con el provider, tengo que coger el contexto de la pantalla y no el del itembuilder, por eso creo una variable contextoPadre y le asigno el context de la pantalla, y luego uso esa variable en el navigator
          }
        ),
      ),
  
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 15, 139, 36),   // color de fondo
        foregroundColor: const Color.fromARGB(255, 135, 228, 154),
        child: Icon(Icons.add),
        onPressed: () {
          //aqui añadimos un nuevo producto, creanodo uno nuevo 
          providerProductoFirebase.productoSeleccionado=Producto(disponible: true, nombre: 'nuevo', precio: 0, imagen: '');//el id lo dara firebase al hacer el post
          Navigator.push(context,MaterialPageRoute(builder: (_) => ProductoPantalla()));
        },
        
      ),  
            
      );
    
  }
}