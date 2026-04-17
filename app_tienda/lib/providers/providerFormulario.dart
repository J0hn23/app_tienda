import 'dart:io';

import 'package:app_tienda/modelos/producto.dart';
import 'package:flutter/material.dart';

class ProviderFormularioProducto extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Producto tempProducto;
  

  ProviderFormularioProducto(this.tempProducto);

  File nuevaImagen=new File('');

  void actualizarImagen(String path) {
    nuevaImagen=File.fromUri( Uri(path:path));
    print(nuevaImagen.path);
    tempProducto.imagen = path;
    notifyListeners(); 
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void toggleDisponible(bool value) {
  tempProducto.disponible = value;
  notifyListeners();
}
}