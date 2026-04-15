import 'package:app_tienda/servicios/productosServicioFirebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductoPantalla extends StatelessWidget {
  const ProductoPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 228, 154),
      appBar: AppBar(
        title: Text('Detalle del producto'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      body: ProductoForm(),
    );
  }
}

class ProductoForm extends StatelessWidget {
  ProductoForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final providerProductoFirebase = Provider.of<ProductoServicioFirebase>(
      context,
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: conseguirImagen(providerProductoFirebase),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 107, 27),
                        foregroundColor: const Color.fromARGB(
                          255,
                          95,
                          192,
                          103,
                        ),
                        elevation: 5,
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        minimumSize: Size(50, 30),
                      ),
                      onPressed: () {
                        conseguirImagen(providerProductoFirebase);
                      },

                      child: Text("Añadir imagen"),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              TextFormField(
                controller: TextEditingController(
                  text: providerProductoFirebase.productoSeleccionado.nombre,
                ),
                style: TextStyle(
                  fontSize: 25,
                  color: const Color.fromARGB(255, 3, 4, 12),
                ),
                decoration: InputDecoration(
                  labelText: "Nombre del producto",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 15),

              TextFormField(
                controller: TextEditingController(
                  text: providerProductoFirebase.productoSeleccionado.precio
                      .toString(),
                ),
                style: TextStyle(
                  fontSize: 25,
                  color: const Color.fromARGB(255, 1, 1, 2),
                ),
                decoration: InputDecoration(
                  labelText: "Precio",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 20, 107, 27),
                    foregroundColor: const Color.fromARGB(255, 95, 192, 103),
                    elevation: 5,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    minimumSize: Size(60, 40),
                  ),
                  onPressed: () {
                    // TODO: subir datos
                  },
                  child: Text("Subir producto"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image conseguirImagen(var providerProductoFirebase) {
    return providerProductoFirebase.productoSeleccionado.imagen != null &&
            providerProductoFirebase.productoSeleccionado.imagen != ''
        ? Image.network(
            providerProductoFirebase.productoSeleccionado.imagen!,
            fit: BoxFit.cover,
          )
        : Image.asset('assets/interrogacion.gif', fit: BoxFit.cover);
  }
}
