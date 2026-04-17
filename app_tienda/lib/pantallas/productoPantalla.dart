import 'dart:io';
import 'package:app_tienda/providers/providerFormulario.dart';
import 'package:app_tienda/servicios/productosServicioFirebase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductoPantalla extends StatelessWidget {
  const ProductoPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final productoServicioFirebase = Provider.of<ProductoServicioFirebase>(
      context,
    );

    return ChangeNotifierProvider(
      create: (_) => ProviderFormularioProducto(
        productoServicioFirebase.productoSeleccionado,
      ),
      child: _ProductoPantalla(
        productoServicioFirebase: productoServicioFirebase,
      ),
    );
  }
}
Future<void> seleccionImagen(BuildContext context) async {

  final provider = Provider.of<ProviderFormularioProducto>(context, listen: false);

  final picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);

  if (photo == null) return;

  provider.actualizarImagen(photo.path);
}
class _ProductoPantalla extends StatelessWidget {
    const
  _ProductoPantalla({super.key, required this.productoServicioFirebase});

  final ProductoServicioFirebase productoServicioFirebase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            //productoServicioFirebase.clearSelectedImage();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), //
          child: Column(
            children: [
              SizedBox(height: 20),
              _ImagenProducto(context,productoServicioFirebase),
              SizedBox(height: 20),
              _FormularioProducto(context,productoServicioFirebase),
              SizedBox(height: 20),
              _BotonesProducto(context,productoServicioFirebase),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ImagenProducto(BuildContext context, ProductoServicioFirebase productoServicioFirebase) {
    final formularioProducto = Provider.of<ProviderFormularioProducto>(context);
    final tempProduct = formularioProducto.tempProducto;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: construirImagen(tempProduct.imagen),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: () async {
              await seleccionImagen(context);
            },
            child: const Text("Cambiar imagen"),
          ),
        ),
      ],
    );
  }

  Widget _FormularioProducto(BuildContext context, ProductoServicioFirebase productoServicioFirebase) {
    final formularioProducto = Provider.of<ProviderFormularioProducto>(context);
    final tempProduct = formularioProducto.tempProducto;

    return Form(
      key: formularioProducto.formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: tempProduct.nombre,
            onChanged: (value) => tempProduct.nombre = value,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 3 || value.length > 30) {
                  return 'El nombre es obligatorio y debe tener entre 3 y 30 caracteres';
                }
                return null;
              },
            decoration: InputDecoration(
              labelText: "Nombre",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            initialValue: tempProduct.precio.toString(),
            onChanged: (value) => tempProduct.precio = int.tryParse(value) ?? 0,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El precio es obligatorio';
              }
              final precio = int.tryParse(value);
              if (precio == null || precio <= 0) {
                return 'El precio debe ser un número positivo';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Precio",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SwitchListTile(
            title: Text('Disponible'),
            value: tempProduct.disponible ?? false,

            onChanged: (value) {
              tempProduct.disponible = value;
              formularioProducto.toggleDisponible(value);
            },
            activeThumbColor: const Color.fromARGB(255, 131, 163, 132),        
            activeTrackColor: const Color.fromARGB(255, 79, 146, 77), 
          )
        ],
      ),
    );
  }

  Widget _BotonesProducto(BuildContext context, ProductoServicioFirebase productoServicioFirebase) {
    final formularioProducto = Provider.of<ProviderFormularioProducto>(context);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
                print(formularioProducto.tempProducto.imagen);
                if (!formularioProducto.isValidForm()) return;

                final productoServicioFirebase =
                    Provider.of<ProductoServicioFirebase>(context, listen: false);

                final respuesta = await productoServicioFirebase
                    .saveOrCreateProduct(formularioProducto.tempProducto);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Producto guardado ID: $respuesta')),
                );

                Navigator.pop(context);
              },
            child: Text("Guardar cambios"),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }



 Future<void> seleccionImagen(BuildContext context) async {
  final formularioProducto =
      Provider.of<ProviderFormularioProducto>(context, listen: false);

  final picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);

  if (photo == null) return;

  formularioProducto.actualizarImagen(photo.path); 
}

  Widget construirImagen(String? url) {
    if (url == null || url.isEmpty) {
      return const Text("Sin imagen");
    }

    if (url.startsWith('http')) {
      return Image.network(url, fit: BoxFit.cover);
      print('Imagen desde URL: $url');
    }

    if (url.startsWith('/data') || url.startsWith('/storage')) {
      return Image.file(File(url), fit: BoxFit.cover);
      print('Imagen data');
    }

    if (url.startsWith('assets')) {
      return Image.asset(url, fit: BoxFit.cover);
      print('Imagen asset');
    }

    return const Text("Imagen no válida");
  }
}
