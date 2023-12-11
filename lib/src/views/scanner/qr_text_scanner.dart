import 'package:flutter/material.dart';

class QRTextScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRTextScannerState();
}

class _QRTextScannerState extends State<QRTextScanner> {
  final _textController = TextEditingController();

  FocusNode _textFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _textFocus.requestFocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ListTile(
        title: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 6, bottom: 6),
          child: TextField(
            textCapitalization: TextCapitalization.characters,
            controller: _textController,
            focusNode: _textFocus,
            decoration: InputDecoration(
              fillColor: Colors.white,
              label: const Text('Ingreso codigo'),
              suffixIcon: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();

                  _textController.text = '';
                },
                icon: const Icon(Icons.cancel),
              ),
              contentPadding: const EdgeInsets.only(
                bottom: 10.0,
                left: 10.0,
                right: 10.0,
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                Navigator.pop(context, _textController.text);
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

Future<String?> openTextScanner(context) async {
  double alto = 150;
  double ancho = 400;

  var result = await showDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      // transitionDuration: const Duration(milliseconds: 200),
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(2),
          contentPadding: EdgeInsets.all(0),
          title: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text(
              'Escanea codigo de barras',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            actions: [
              IconButton(
                iconSize: 34.0,
                color: Colors.white,
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context, 'cancel');
                },
              ),
            ],
          ),
          content: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              child: Material(
                child: Container(
                  width: ancho,
                  height: alto,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: QRTextScanner(),
                ),
              ),
            ),
          ),
        );
      });
  if (result == null || result == 'cancel') return '';

  return result.toString();
}
