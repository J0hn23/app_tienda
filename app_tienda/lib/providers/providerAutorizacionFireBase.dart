import 'package:app_tienda/servicios/autentificacionServicioFirebase.dart';
import 'package:flutter/material.dart';

class ProviderAutorizacionFirebase extends ChangeNotifier {
 final AutentificacionServicioFirebase _autorizacionDelServicio = AutentificacionServicioFirebase();

  bool isLoading = false;

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

   
      await _autorizacionDelServicio.login(email, password);

   
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _autorizacionDelServicio.logout();
  }

  Future<void> register(String email, String password) async {
    isLoading = true;
    notifyListeners();

   
      await _autorizacionDelServicio.register(email, password);

   
    isLoading = false;
    notifyListeners();
  }


}
