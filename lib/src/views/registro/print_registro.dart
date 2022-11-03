import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:webtest/src/cubit/registro_detalle_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/models/fallo_maquina_model.dart';
import 'package:webtest/src/models/registro_produccion.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/widgets/loading.dart';

class PrintRegistro extends StatelessWidget {
  static const routeName = '/registro_print';
  const PrintRegistro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)?.settings.arguments as String;

    context.read<RegistroDetalleCubit>().PRO_registro(id);

    return Scaffold(
      appBar: AppBar(title: Text('Imprimir registro')),
      body: BlocConsumer<RegistroDetalleCubit, RegistroDetalleState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state == null) return Text('State error');

          if (state is RegistroDetalleInitial) {
            return _MessageSearch(mensaje: 'Comenzando busqueda del registro');
          } else if (state is RegistroDetalleLoading) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _LoadingRegistro(),
            );
          } else if (state is RegistroDetalleError) {
            return _MessageSearch(mensaje: state.message);
          } else if (state is RegistroDetalleLoaded) {
            return PdfPreview(
              initialPageFormat: PdfPageFormat.a4,
              build: (format) => _generatePdf(format, state.registro),
            );
          } else {
            return const _MessageSearch(
                mensaje:
                    'Algo salio mal obteniendo el registro de produccion.');
          }
        },
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, RegistroProduccion registro) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        pageFormat: format.portrait,
        build: (context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'REGISTRO DE PRODUCCION',
                    style: const pw.TextStyle(fontSize: 14),
                  )
                ],
              ),
              _divider(),
              pw.Spacer(),
              pw.Row(
                children: [
                  _infoContent('OPERARIO:',
                      '${registro.legajoOperario!} - ${registro.operario!}',
                      flex: 2),
                  _infoContent('FECHA:', '${registro.fecha!} ${registro.hora!}',
                      flex: 1),
                  _infoContent('ESTADO:', registro.estado!, flex: 1),
                ],
              ),
              pw.Row(
                children: [
                  _infoContent('MAQUINA:', registro.maquina!),
                  _infoContent('PRODUCTO:',
                      '${registro.codProducto!} - ${registro.producto!}'),
                ],
              ),
              pw.Row(
                children: [
                  _infoContent('CONTADOR INICIAL:', registro.contadorInicial!),
                  _infoContent('LOTE:', registro.lote!),
                  _infoContent('CONTADOR FINAL:', registro.contadorFinal!),
                ],
              ),
              pw.Spacer(),
              pw.Row(
                children: [
                  _infoTitulo(label: 'MATERIA PRIMA UTILIZADA', flex: 1),
                ],
              ),
              _divider(),

              (registro.maquina!.contains('BUDIN'))
                  ? pw.Column(children: [
// BUDIN
                      pw.Row(
                        children: [
                          _adhesivoTitulo(label: 'Adhesivo trasero No:'),
                          _adhesivoDetalle(
                            value: registro.adhesivoTrasero1!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoTrasero2!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoTrasero3!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoTrasero4!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoTrasero5!,
                          ),
                        ],
                      ),
                      _divider(),
                      pw.Row(
                        children: [
                          _adhesivoTitulo(label: 'Adhesivo delantero No:'),
                          _adhesivoDetalle(
                            value: registro.adhesivoDelantero1!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoDelantero2!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoDelantero3!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoDelantero4!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoDelantero5!,
                          ),
                        ],
                      ),
// BOBINA PAPEL - BUDIN
                      _divider(),
                      pw.Row(
                        children: [
                          _bobinaTitulo(label: 'Bobina papel:'),
                          _bobinaDetalle(
                            nro: '1',
                            value: (registro.bobina1 == null ||
                                    registro.bobina1!.nroSerie == null)
                                ? ' '
                                : registro.bobina1!.nroSerie!,
                            checked: registro.bobina1!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '2',
                            value: (registro.bobina2 == null ||
                                    registro.bobina2!.nroSerie == null)
                                ? ' '
                                : registro.bobina2!.nroSerie!,
                            checked: registro.bobina2!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '3',
                            value: (registro.bobina3 == null ||
                                    registro.bobina3!.nroSerie == null)
                                ? ' '
                                : registro.bobina3!.nroSerie!,
                            checked: (registro.bobina3 == null ||
                                    registro.bobina3!.checked == null)
                                ? false
                                : registro.bobina3!.checked!,
                          ),
                        ],
                      ),
                      _divider(),
                      pw.Row(
                        children: [
                          _bobinaTitulo(label: ''),
                          _bobinaDetalle(
                            nro: '4',
                            value: (registro.bobina4 == null ||
                                    registro.bobina4!.nroSerie == null)
                                ? ' '
                                : registro.bobina4!.nroSerie!,
                            checked: (registro.bobina4 == null ||
                                    registro.bobina4!.checked == null)
                                ? false
                                : registro.bobina4!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '5',
                            value: (registro.bobina5 == null ||
                                    registro.bobina5!.nroSerie == null)
                                ? ' '
                                : registro.bobina5!.nroSerie!,
                            checked: (registro.bobina5 == null ||
                                    registro.bobina5!.checked == null)
                                ? false
                                : registro.bobina5!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '6',
                            value: (registro.bobina6 == null ||
                                    registro.bobina6!.nroSerie == null)
                                ? ' '
                                : registro.bobina6!.nroSerie!,
                            checked: (registro.bobina6 == null ||
                                    registro.bobina6!.checked == null)
                                ? false
                                : registro.bobina6!.checked!,
                          ),
                        ],
                      ),
                      // END BOBINA PAPEL - BUDIN

                      _divider(),
                    ])
                  : pw.Column(children: [
                      //////// ACA VA EL ELSE
                      pw.Row(
                        children: [
                          _adhesivoTitulo(label: 'Adhesivo fondo No:'),
                          _adhesivoDetalle(
                            value: registro.adhesivoFondo1!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoFondo2!,
                          ),
                          _adhesivoTitulo(label: 'Adhesivo Corrugado No:'),
                          _adhesivoDetalle(
                            value: registro.adhesivoCorrugado!,
                          ),
                        ],
                      ),
                      _divider(),
                      pw.Row(
                        children: [
                          _adhesivoTitulo(label: 'Adhesivo lateral No:'),
                          _adhesivoDetalle(
                            value: registro.adhesivoLateral1!,
                          ),
                          _adhesivoDetalle(
                            value: registro.adhesivoLateral2!,
                          ),
                          _adhesivoTitulo(label: 'Desmoldante No:'),
                          _adhesivoDetalle(
                            value: registro.desmoldante!,
                          ),
                        ],
                      ),
                      _divider(),
                      // BOBINA FONDO - DULCE BISCOCHO
                      pw.Row(
                        children: [
                          _bobinaTitulo(label: 'Bobina fondo:'),
                          _bobinaDetalle(
                            nro: '1',
                            value: (registro.bobinaFondo1 == null ||
                                    registro.bobinaFondo1!.nroSerie == null)
                                ? ' '
                                : registro.bobinaFondo1!.nroSerie!,
                            checked: (registro.bobinaFondo1 == null ||
                                    registro.bobinaFondo1!.checked == null)
                                ? false
                                : registro.bobinaFondo1!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '2',
                            value: (registro.bobinaFondo2 == null ||
                                    registro.bobinaFondo2!.nroSerie == null)
                                ? ' '
                                : registro.bobinaFondo2!.nroSerie!,
                            checked: (registro.bobinaFondo2 == null ||
                                    registro.bobinaFondo2!.checked == null)
                                ? false
                                : registro.bobinaFondo2!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '3',
                            value: (registro.bobinaFondo3 == null ||
                                    registro.bobinaFondo3!.nroSerie == null)
                                ? ' '
                                : registro.bobinaFondo3!.nroSerie!,
                            checked: (registro.bobinaFondo3 == null ||
                                    registro.bobinaFondo3!.checked == null)
                                ? false
                                : registro.bobinaFondo3!.checked!,
                          ),
                        ],
                      ),
                      // END BOBINA FONDO - DULCE BISCOCHO
                      _divider(),
                      // BOBINA LATERAL - DULCE BISCOCHO
                      pw.Row(
                        children: [
                          _bobinaTitulo(label: 'Bobina lateral:'),
                          _bobinaDetalle(
                            nro: '1',
                            value: (registro.bobinaLateral1 == null ||
                                    registro.bobinaLateral1!.nroSerie == null)
                                ? ' '
                                : registro.bobinaLateral1!.nroSerie!,
                            checked: (registro.bobinaLateral1 == null ||
                                    registro.bobinaLateral1!.checked == null)
                                ? false
                                : registro.bobinaLateral1!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '2',
                            value: (registro.bobinaLateral2 == null ||
                                    registro.bobinaLateral2!.nroSerie == null)
                                ? ' '
                                : registro.bobinaLateral2!.nroSerie!,
                            checked: (registro.bobinaLateral2 == null ||
                                    registro.bobinaLateral2!.checked == null)
                                ? false
                                : registro.bobinaLateral2!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '3',
                            value: (registro.bobinaLateral3 == null ||
                                    registro.bobinaLateral3!.nroSerie == null)
                                ? ' '
                                : registro.bobinaLateral3!.nroSerie!,
                            checked: (registro.bobinaLateral3 == null ||
                                    registro.bobinaLateral3!.checked == null)
                                ? false
                                : registro.bobinaLateral3!.checked!,
                          ),
                        ],
                      ),
                      // END BOBINA LATERAL - DULCE BISCOCHO
                      _divider(),
                      // BOBINA CONO - DULCE BISCOCHO
                      pw.Row(
                        children: [
                          _bobinaTitulo(label: 'Bobina cono:'),
                          _bobinaDetalle(
                            nro: '1',
                            value: (registro.bobinaCono1 == null ||
                                    registro.bobinaCono1!.nroSerie == null)
                                ? ' '
                                : registro.bobinaCono1!.nroSerie!,
                            checked: (registro.bobinaCono1 == null ||
                                    registro.bobinaCono1!.checked == null)
                                ? false
                                : registro.bobinaCono1!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '2',
                            value: (registro.bobinaCono2 == null ||
                                    registro.bobinaCono2!.nroSerie == null)
                                ? ' '
                                : registro.bobinaCono2!.nroSerie!,
                            checked: (registro.bobinaCono2 == null ||
                                    registro.bobinaCono2!.checked == null)
                                ? false
                                : registro.bobinaCono2!.checked!,
                          ),
                          _bobinaDetalle(
                            nro: '3',
                            value: (registro.bobinaCono3 == null ||
                                    registro.bobinaCono3!.nroSerie == null)
                                ? ' '
                                : registro.bobinaCono3!.nroSerie!,
                            checked: (registro.bobinaCono3 == null ||
                                    registro.bobinaCono3!.checked == null)
                                ? false
                                : registro.bobinaCono3!.checked!,
                          ),
                        ],
                      ),
                      // END BOBINA CONO - DULCE BISCOCHO

                      _divider(),
                    ]),

              //         ],
              //       );
              //     },
              //   ),

              //   index: 0,
              // );

              // pdf.addPage(

              //   pw.Page(

              //     pageFormat: format,
              //     build: (context) {
              //       return pw.Column(
              //         children: [

              pw.Spacer(),
              pw.Row(
                children: [
                  _infoTitulo(label: 'CONTROLES', flex: 3),
                  _infoTitulo(label: 'FALLOS DE LA MAQUINA', flex: 5),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Column(
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.only(left: 1, right: 1),
                          child: (registro.maquina!.contains('BUDIN'))
                              ? _controlesBUDIN(registro)
                              : _controlesNOBUDIN(registro),
                        )
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Column(
                        children: [
                          pw.Container(
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                _divider(),
                                _headerFallos(),
                                _divider(),
                                _listFallos(fallos: registro.fallosMaquina!),
                              ],
                            ),
                          ),
                          _divider(),
                          pw.Row(
                            children: [
                              pw.Expanded(child: pw.Container()),
                              _hours(
                                fallos: registro.fallosMaquina!,
                              ),
                              pw.SizedBox(width: 5),
                            ],
                          ),
                        ],
                      )),
                ],
              ),

              pw.Spacer(),
              pw.Row(
                children: [
                  _infoContent(
                      'CANTIDAD CAJAS FABRICADAS:', registro.cantidadCajas!,
                      flex: 1),
                  _infoContent(
                      'CANTIDAD MOLDES FABRICADOS:', registro.cantidadMoldes!,
                      flex: 1),
                ],
              ),
              pw.Spacer(),
              // pw.Row(
              //   children: [
              //     _infoContent('', '', flex: 3),
              //     _infoContent(
              //         '____________________________', 'Firma y aclaración',
              //         flex: 1),
              //   ],
              // ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  _divider() {
    return pw.Divider(thickness: 0.3, height: 0.8);
  }

  _infoContent(String label, String value, {int flex = 1}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(
        height: 30,
        margin: const pw.EdgeInsets.symmetric(vertical: 1),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              label,
              style: const pw.TextStyle(fontSize: 9),
            ),
            pw.Text(
              value,
              style: const pw.TextStyle(fontSize: 11),
            )
          ],
        ),
      ),
    );
  }

  _infoTitulo({required String label, required int flex}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(
        height: 30,
        margin: const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        child: pw.Row(
          children: [
            pw.Spacer(),
            pw.Container(
              child: pw.Text(
                label,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 12),
              ),
            ),
            pw.Spacer(),
          ],
        ),
      ),
    );
  }

  _adhesivoTitulo({required String label}) {
    return pw.Container(
      height: 25,
      width: 150,
      margin: const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: const pw.TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  _adhesivoDetalle({required String value}) {
    return pw.Expanded(
      child: pw.Container(
        height: 25,
        margin: const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Spacer(),
            pw.Text(
              value,
              style: const pw.TextStyle(fontSize: 11),
            ),
            pw.Spacer(),
          ],
        ),
      ),
    );
  }

  _bobinaTitulo({required String label}) {
    return pw.Container(
      height: 28,
      width: 100,
      margin: const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: const pw.TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  _bobinaDetalle(
      {required String nro, required String value, required bool checked}) {
    return pw.Expanded(
      child: pw.Container(
        height: 28,
        margin: const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Spacer(),
            pw.Text(
              nro,
              style: const pw.TextStyle(fontSize: 9),
            ),
            pw.Row(
              children: [
                pw.Text(
                  value,
                  style: const pw.TextStyle(fontSize: 11),
                ),
                pw.Text(
                  (checked) ? ' - #' : '',
                  style: pw.TextStyle(fontSize: 11),
                ),
              ],
            ),
            pw.Spacer(),
            pw.Spacer(),
          ],
        ),
      ),
    );
  }

  _gridcell({required String label, required int flex}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(
        height: 30,
        padding: const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        child: pw.Row(
          children: [
            pw.Spacer(),
            pw.Container(
              child: pw.Text(
                label,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 11),
              ),
            ),
            pw.Spacer(),
          ],
        ),
      ),
    );
  }

  _gridhead({required String label, required int flex}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(
        height: 30,
        padding: const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                label,
                textAlign: pw.TextAlign.left,
                style: const pw.TextStyle(fontSize: 11),
              ),
            ]),
      ),
    );
  }

  _controlesBUDIN(RegistroProduccion registro) {
    return pw.Column(
      children: [
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'CRUCE', flex: 5),
            _gridcell(label: registro.cruce_1!, flex: 2),
            _gridcell(label: registro.cruce_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'RULO/PESTAÑA', flex: 5),
            _gridcell(label: registro.rulo_1!, flex: 2),
            _gridcell(label: registro.rulo_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'PEGADO TRASERO', flex: 5),
            _gridcell(label: registro.pegado_trasero_1!, flex: 2),
            _gridcell(label: registro.pegado_trasero_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'PEGADO DELANTERO', flex: 5),
            _gridcell(label: registro.pegado_delantero_1!, flex: 2),
            _gridcell(label: registro.pegado_delantero_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'CANTIDAD DE CONO', flex: 5),
            _gridcell(label: registro.cant_cono_1!, flex: 2),
            _gridcell(label: registro.cant_cono_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'GRAFICA', flex: 5),
            _gridcell(label: registro.grafica_1!, flex: 2),
            _gridcell(label: registro.grafica_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'TROQUELADO', flex: 5),
            _gridcell(label: registro.troquelado_1!, flex: 2),
            _gridcell(label: registro.troquelado_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'MATERIAS EXTRAÑAS', flex: 5),
            _gridcell(label: registro.materias_1!, flex: 2),
            _gridcell(label: registro.materias_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'PPR3', flex: 5),
            _gridcell(label: registro.ppr3_1!, flex: 2),
            _gridcell(label: registro.ppr3_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'PPR4', flex: 5),
            _gridcell(label: registro.ppr4_1!, flex: 2),
            _gridcell(label: registro.ppr4_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'PPR6', flex: 5),
            _gridcell(label: registro.ppr6_1!, flex: 2),
            _gridcell(label: registro.ppr6_2!, flex: 2)
          ],
        ),
      ],
    );
  }

  _controlesNOBUDIN(RegistroProduccion registro) {
    return pw.Column(
      children: [
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'ALTURA', flex: 5),
            _gridcell(label: registro.altura_1!, flex: 2),
            _gridcell(label: registro.altura_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'TERMINACIÓN SUPERIOR', flex: 5),
            _gridcell(label: registro.terminacion_superior_1!, flex: 2),
            _gridcell(label: registro.terminacion_superior_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'CRUCE', flex: 5),
            _gridcell(label: registro.cruce_1!, flex: 2),
            _gridcell(label: registro.cruce_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'PEGADO', flex: 5),
            _gridcell(label: registro.pegado_1!, flex: 2),
            _gridcell(label: registro.pegado_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'CANTIDAD DE CONO', flex: 5),
            _gridcell(label: registro.cant_cono_1!, flex: 2),
            _gridcell(label: registro.cant_cono_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'GRAFICA', flex: 5),
            _gridcell(label: registro.grafica_1!, flex: 2),
            _gridcell(label: registro.grafica_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'MICROPERFORADO', flex: 5),
            _gridcell(label: registro.microperforado_1!, flex: 2),
            _gridcell(label: registro.microperforado_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'MATERIAS EXTRAÑAS', flex: 5),
            _gridcell(label: registro.materias_1!, flex: 2),
            _gridcell(label: registro.materias_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'PPR3', flex: 5),
            _gridcell(label: registro.ppr3_1!, flex: 2),
            _gridcell(label: registro.ppr3_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'PPR4', flex: 5),
            _gridcell(label: registro.ppr4_1!, flex: 2),
            _gridcell(label: registro.ppr4_2!, flex: 2)
          ],
        ),
        _divider(),
        pw.Row(
          children: [
            _gridhead(label: 'PPR6', flex: 5),
            _gridcell(label: registro.ppr6_1!, flex: 2),
            _gridcell(label: registro.ppr6_2!, flex: 2)
          ],
        ),
      ],
    );
  }

  _hours({
    required List<FalloMaquina> fallos,
  }) {
    int? minutos = 0;
    int? horasMin = 480;

    if (fallos.length > 0) {
      minutos = fallos.map((fallo) => fallo.tiempo).reduce((a, b) => a! + b!);
    }
    int time = horasMin - minutos!;

    final duration = Duration(minutes: time);
    final zero = DateTime(minutos);
    final dateTime = zero.add(duration);

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Container(
          height: 25,
          // width: 300,
          padding: const pw.EdgeInsets.symmetric(horizontal: 5),
          child: pw.Row(
            children: [
              pw.Text(
                'Horas trabajadas: ',
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(fontSize: 11),
              ),
              pw.Text(
                dateTime.hour.toString() +
                    'h ' +
                    dateTime.minute.toString() +
                    'min',
                textAlign: pw.TextAlign.right,
                style: const pw.TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 1)
      ],
    );
  }

  _headerFallos() {
    return pw.Container(
      padding: const pw.EdgeInsets.only(left: 1, right: 1),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 4,
            child: pw.Container(
              height: 28,
              padding: const pw.EdgeInsets.symmetric(horizontal: 5),
              child: pw.Center(
                child: pw.Text(
                  'FALLO',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              height: 30,
              padding: const pw.EdgeInsets.symmetric(horizontal: 5),
              child: pw.Center(
                child: pw.Text(
                  'TIEMPO',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 5,
            child: pw.Container(
              height: 30,
              padding: const pw.EdgeInsets.symmetric(horizontal: 5),
              child: pw.Center(
                child: pw.Text(
                  'OBSERVACIONES',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _listFallos({
    required List<FalloMaquina> fallos,
  }) {
    if (fallos.length == 0) {
      return pw.Container(
        height: 280,
        child: pw.Padding(
          padding: pw.EdgeInsets.all(15.0),
          child: pw.Center(
            child: pw.Text('No hay fallos cargados'),
          ),
        ),
      );
    }
    return pw.Container(
      height: 280,
      child: pw.ListView.separated(
        itemCount: fallos.length,
        //shrinkWrap: true,
        itemBuilder: (context, index) {
          FalloMaquina fallo = fallos[index];
          return _row(fallo: fallos[index]);
        },
        separatorBuilder: (context, index) => _divider(),
      ),
    );
  }

  _row({
    required FalloMaquina fallo,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(left: 1, right: 1),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 4,
            child: pw.Container(
              height: 30,
              padding: const pw.EdgeInsets.symmetric(horizontal: 3),
              child: pw.Center(
                child: pw.Text(
                  fallo.codigo! + ' - ' + fallo.fallo!,
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              height: 30,
              padding: const pw.EdgeInsets.symmetric(horizontal: 3),
              child: pw.Center(
                child: pw.Text(
                  fallo.tiempo!.toString() + '\'',
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 5,
            child: pw.Container(
              //height: altoCelda,
              constraints: pw.BoxConstraints(
                minHeight: 30,
              ),
              padding: const pw.EdgeInsets.symmetric(horizontal: 5),
              child: pw.Center(
                child: pw.Text(
                  fallo.observaciones!,
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageSearch extends StatelessWidget {
  const _MessageSearch({
    Key? key,
    required this.mensaje,
  }) : super(key: key);

  final String? mensaje;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          child: Text(
            mensaje!,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _LoadingRegistro extends StatelessWidget {
  const _LoadingRegistro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingSpinner(
          color: Theme.of(context).primaryColor,
          text: 'Buscando registro de produccion',
          height: 3,
        ),
      ],
    );
  }
}
