import 'package:app_tienda/modelos/producto.dart';
import 'package:flutter/material.dart';

class ProviderFormularioProducto extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Producto tempProducto;

  ProviderFormularioProducto(this.tempProducto);

  void actualizarImagen(String path) {
    tempProducto.imagen = path;
    notifyListeners(); 
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}