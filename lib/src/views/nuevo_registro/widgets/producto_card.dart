import 'package:flutter/material.dart';
import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/modal.dart';
import 'package:webtest/src/utils/utils.dart';

class ProductoCard extends StatefulWidget {
  ProductoCard({Key? key}) : super(key: key);

  @override
  _ProductoCardState createState() => _ProductoCardState();
}

class _ProductoCardState extends State<ProductoCard> {
  final double radious = 5;

  @override
  Widget build(BuildContext context) {
    final prefs = AppPreferences();
    print('prefs.producto: ${prefs.productoNombre}');
    String maq = (prefs.productoId.isEmpty)
        ? 'CONFIGURE UN PRODUCTO'
        : prefs.productoNombre;
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          final prefs = AppPreferences();
          Bobina? prod = await Modal.seleccionarProducto(context) as Bobina?;
          if (prod != null) {
            setState(() {
              prefs.productoId = prod.codproducto!;
              prefs.productoNombre = prod.nombre!;
            });
          }
        },
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Utils.borderApp,
            color: Colors.grey[200],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PRODUCTO PRODUCIDO:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              if (maq.isNotEmpty)
                Text(
                  maq,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
