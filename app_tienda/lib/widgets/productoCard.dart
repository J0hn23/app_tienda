import 'package:app_tienda/modelos/producto.dart';
import 'package:flutter/material.dart';

class ProductoCard extends StatelessWidget {
  const ProductoCard({super.key, required this.producto});

  final Producto producto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _bordeCarta(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _FondoWidget(url:producto.imagen),
            _DetallesProducto(details: producto.nombre),
            Positioned(top: 0, right: 0, child: _EtiquetaPrecio(price: producto.precio)),
            //TODO: Mostrar de forma condicional depenent de si el producte està disponible o no
            Positioned(top: 0, left: 0, child: _Disponibilidad(available: producto.disponible)),
          ],
        ),
      ),
    );




  }
}

BoxDecoration _bordeCarta() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 10,
          ),
        ],
        );


class _FondoWidget extends StatelessWidget {
  final String? url;

  const _FondoWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url==null 
        ? Image(image:AssetImage('assets/jar-loading.gif'), fit: BoxFit.cover )
        :FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _DetallesProducto extends StatelessWidget {
  
  final String details;

  const _DetallesProducto({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.infinity,
        height: 80,
       // decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              details,
              style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 37, 55, 216),
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
          ],
        ),
      ),
    );
  }
}

class _EtiquetaPrecio extends StatelessWidget {
  
  final int price;

  const _EtiquetaPrecio({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            price.toString()+ ' €',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
    );
  }
}


class _Disponibilidad extends StatelessWidget {
  
  final bool? available;

  const _Disponibilidad({Key? key, required this.available}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: available == true ? Colors.indigo : Colors.red,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            available == true ? 'Disponible' : 'No disponible',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}