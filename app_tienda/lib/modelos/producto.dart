import 'dart:convert';

class Producto {
  bool? disponible;
  String? imagen;
  String nombre;
  int precio;
  String? id;

  Producto({
    required this.disponible,
    this.imagen,
    required this.nombre,
    required this.precio,
    this.id
  });

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
    disponible: json["disponible"],
    imagen: json["imagen"],
    nombre: json["nombre"],
    precio: json["precio"],
    id: json["id"],
  );


  Map<String, dynamic> toMap() => {
    "disponible": disponible,
    "imagen": imagen,
    "nombre": nombre,
    "precio": precio,
  };

  Producto copyWith(
    bool? disponible,
    String? imagen,
    String? nombre,
    int? precio,
    String? id,
  ) {
    return Producto(
      disponible: disponible ?? this.disponible,
      imagen: imagen ?? this.imagen,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      id: id ?? this.id,
    );
  }

  
}
