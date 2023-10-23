import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/widgets/delete_button.dart';

class QRScanner extends StatefulWidget {
  const QRScanner(this.context, {key = const Key('QRView')}) : super(key: key);
  final BuildContext context;

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  _QRScannerState();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isPopped = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _buildQrView(widget.context)),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    // var scanArea = (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 150.0
    //     : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      // overlay: QrScannerOverlayShape(
      //     borderColor: Colors.white54,
      //     borderRadius: 4,
      //     borderLength: 0,
      //     borderWidth: 10,
      //     cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (!isPopped) {
        isPopped = true;
        Navigator.pop(context, result!.code);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission to Camera')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

Future<String?> openScanner(context) async {
  final _width = MediaQuery.of(context).size.width;
  final _height = MediaQuery.of(context).size.height * 0.5;
  var result = await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Material(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(bottom: 20),
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppBar(
                  elevation: 0,
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  title: const Text(
                    'Escanea codigo de barras',
                    textAlign: TextAlign.start,
                  ),
                  actions: [
                    IconButton(
                      iconSize: 34.0,
                      color: Colors.white,
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context, 'cancel'),
                    ),
                  ],
                ),
                //Spacer(),
                Stack(
                  children: [
                    Container(
                      width: _height,
                      height: _height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: QRScanner(context)),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: _height * 0.8,
                          height: _height * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              style: BorderStyle.solid,
                              width: 20.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(30.0),
                //   child: SizedBox(
                //     width: _width,
                //     height: _width,
                //     child: QRScanner(context),
                //   ),
                // ),
                // Spacer(),
                Container(height: 50),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'Utilice su camara para escanear el codigo de barras.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                // Container(height: 50),
                // Container(
                //   margin: EdgeInsets.only(bottom: 30),
                //   child: DeleteButton(
                //     text: '   ELIMINAR SELECCION   ',
                //     onPressed: () {
                //       Navigator.of(context).pop(Bobina(
                //         id: '',
                //         codproducto: '',
                //         nombre: '',
                //         nroSerie: '',
                //       ));
                //     },
                //   ),
                // ),
                Spacer(),
              ],
            ),
          ),
        );
      });
  if (result == null || result == 'cancel') return '';

  return result.toString();
}
