import 'dart:convert';

import 'package:app_tienda/modelos/producto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductoServicioFirebase extends ChangeNotifier{


  final List<Producto>listaProductos = [];
  final _baseUrl='https://tienda-productos-b7ff7-default-rtdb.europe-west1.firebasedatabase.app/';
  bool isLoading = true;
  bool isSaving=false;
  Producto productoTemporal = Producto(nombre: '', precio: 0, imagen: '', disponible: null);
  late Producto productoSeleccionado;

  ProductoServicioFirebase() { //Al crear la instancia de esta clase, se llama a la funcion loadProducts para cargar los productos desde firebase
    this.loadProducts();
  }
  
  Future<void> loadProducts() async {

    isLoading = true;
    notifyListeners();


    //final url = Uri.https(_baseUrl, 'productos.json');//Se crea la url
    final url = Uri.parse('$_baseUrl/productos.json');

    final respuestaFirebase = await http.get(url);//obtengo la respuesta de la url, que es un string con el json

    final Map<String, dynamic> productosMap = json.decode(respuestaFirebase.body);//decodifico el json a un mapa de dart 

    productosMap.forEach((key, value) {
      final productoTemporal = Producto.fromMap(value);
      productoTemporal.id = key;
      listaProductos.add(productoTemporal);
    });

    print(listaProductos[0].nombre);

    isLoading = false;
    notifyListeners();  
  }


  




}