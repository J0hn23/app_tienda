import 'dart:convert';
import 'dart:io';

import 'package:app_tienda/modelos/producto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductoServicioFirebase extends ChangeNotifier {

  final List<Producto> listaProductos = [];
  final String _baseUrl =
      'https://tienda-productos-b7ff7-default-rtdb.europe-west1.firebasedatabase.app';

  bool isLoading = true;
  bool isSaving = false;

  late Producto productoSeleccionado;

  ProductoServicioFirebase() {
    loadProducts();
  }

  
  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_baseUrl/productos.json');

    final respuestaFirebase = await http.get(url);

    final Map<String, dynamic> productosMap =
        json.decode(respuestaFirebase.body);

    listaProductos.clear(); // 🔥 IMPORTANTE (evita duplicados)

    productosMap.forEach((key, value) {
      final producto = Producto.fromMap(value);
      producto.id = key;
      listaProductos.add(producto);
    });

    isLoading = false;
    notifyListeners();
  }

  // 🔥 GUARDAR O CREAR
  Future<String?> saveOrCreateProduct(Producto producto) async {
    isSaving = true;
    notifyListeners();

    if (producto.id == null) {
      await createProduct(producto);
    } else {
      await updateProduct(producto);
    }

    isSaving = false;
    notifyListeners();

    return producto.id;
  }

  // 🔥 ACTUALIZAR PRODUCTO
  Future<String> updateProduct(Producto producto) async {
    final url = Uri.parse('$_baseUrl/productos/${producto.id}.json');

    await http.put(
      url,
      body: producto.toJson(),
    );

    final index =
        listaProductos.indexWhere((element) => element.id == producto.id);

    if (index != -1) {
      listaProductos[index] = producto; // 🔥 actualiza local
    }

    notifyListeners(); // 🔥 refresca UI

    return producto.id!;
  }

  // 🔥 CREAR PRODUCTO
  Future<String> createProduct(Producto producto) async {
    final url = Uri.parse('$_baseUrl/productos.json');

    final response = await http.post(
      url,
      body: producto.toJson(),
    );

    final decodedData = json.decode(response.body);

    producto.id = decodedData['name'];

    listaProductos.add(producto); // 🔥 añade local

    notifyListeners(); // 🔥 refresca UI

    return producto.id!;
  }
}