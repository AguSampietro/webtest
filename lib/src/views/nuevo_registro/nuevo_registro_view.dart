import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/bobina_cubit.dart';
import 'package:webtest/src/cubit/fallo_cubit.dart';
import 'package:webtest/src/cubit/registro_add_cubit.dart';
import 'package:webtest/src/cubit/registro_detalle_cubit.dart';
import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/models/nro_serie.dart';
import 'package:webtest/src/models/producto.dart';

import 'package:webtest/src/models/fallo_maquina_model.dart';
import 'package:webtest/src/models/fallo.dart';
import 'package:webtest/src/models/registro_produccion.dart';
import 'package:webtest/src/models/turno.dart';
import 'package:webtest/src/services/api_service.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/views/home/home.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/adhesivo_add.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/adhesivo_label.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/bobina_add.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/bobina_label.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/contador_card.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/controles_row.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/deposito_card.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/fallo_maquina_modal.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/fallos_maquina_head.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/fallos_maquina_row.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/maquina_card.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/operario_card.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/modal.dart';
import 'package:webtest/src/utils/sizes.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/producto_card.dart';

import 'package:webtest/src/views/scanner/qr_scanner.dart' as QRScanner;
import 'package:webtest/src/views/scanner/qr_text_scanner.dart';

import 'package:webtest/src/widgets/finish_button.dart';

import '../settings/settings_view.dart';

import 'package:data_table_2/data_table_2.dart';

class NuevoRegistroView extends StatefulWidget {
  static const routeName = '/nuevo_registro';

  const NuevoRegistroView({
    Key? key,
  }) : super(key: key);

  @override
  State<NuevoRegistroView> createState() => _NuevoRegistroViewState();
}

class _NuevoRegistroViewState extends State<NuevoRegistroView> {
  final double radious = 5;
  RegistroProduccion _reg = RegistroProduccion.init();

  Turno _turno = Turno(nombre: '', codigo: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final prefs = AppPreferences();
    if (prefs.idRegistroEdit.isNotEmpty) {
      context
          .read<RegistroDetalleCubit>()
          .PRO_registro(prefs.idRegistroEdit)
          .whenComplete(() {
        final regState = context.read<RegistroDetalleCubit>().state;
        if (regState is RegistroDetalleLoaded) {
          _reg = regState.registro;

          _reg.bobina1 ??= Bobina.init();
          _reg.bobina2 ??= Bobina.init();
          _reg.bobina3 ??= Bobina.init();
          _reg.bobina4 ??= Bobina.init();
          _reg.bobina5 ??= Bobina.init();
          _reg.bobina6 ??= Bobina.init();

          _reg.bobinaCono1 ??= Bobina.init();
          _reg.bobinaCono2 ??= Bobina.init();
          _reg.bobinaCono3 ??= Bobina.init();

          _reg.bobinaFondo1 ??= Bobina.init();
          _reg.bobinaFondo2 ??= Bobina.init();
          _reg.bobinaFondo3 ??= Bobina.init();

          _reg.bobinaLateral1 ??= Bobina.init();
          _reg.bobinaLateral2 ??= Bobina.init();
          _reg.bobinaLateral3 ??= Bobina.init();

          prefs.maquinaId = _reg.idMaquina!;
          prefs.maquinaNombre = _reg.maquina!;
          prefs.operarioId = _reg.legajoOperario!;
          prefs.operarioNombre = _reg.operario!;
          prefs.depositoId = _reg.deposito!;
          prefs.depositoNombre = _reg.depositoNombre!;
          prefs.productoId = _reg.codProducto!;
          prefs.productoNombre = _reg.producto!;

          String? _t = regState.registro.turno;

          if (_t != null) {
            _turno = Turno();
            _turno.codigo = _t;
            _turno.nombre = _t;
          } else {
            _turno.codigo = '';
            _turno.nombre = '';
          }

          context.read<RegistroAddCubit>().ready();

          setState(() {});

          // Utils.confirmAlert(
          //     context, 'Registro cargado', 'El registro se cargo correctamente',
          //     () {
          //   context.read<RegistroAddCubit>().ready();
          //   setState(() {});
          // });
        }
      });
    } else {
      context.read<RegistroAddCubit>().ready();
    }
  }

  bool _tieneBobina(Bobina? bob) {
    return (bob != null && bob.nroSerie != null && bob.nroSerie!.isNotEmpty);
  }

  _borrarBobina(Function acceptButton) {
    Utils.confirmAlert(
        context, 'Borrar', 'Esta seguro que desea borrar la bobina?', () {
      Navigator.pop(context);
      acceptButton();
    });
  }

  Future<Bobina?> _scanBobina(String result) async {
    Bobina? res;
    final prefs = AppPreferences();
    ApiService api = ApiService();
    String deposito = prefs.depositoId;
    Utils.modalLoading(context, 'Buscando bobina...');
    List<NroSerie>? nSeries =
        await api.PRO_bobinaPorNroSerieDeposito(result, deposito);
    Navigator.pop(context);

    if (nSeries != null) {
      if (nSeries.isEmpty) {
        Utils.snackBar(context, 'No se encontro la bobina');
        res = Bobina(
          codproducto: '',
          nombre: '',
          nroSerie: '',
        );
      } else {
        res = Bobina(
          codproducto: nSeries.first.codproducto ?? '',
          nombre: nSeries.first.nombre ?? '',
          nroSerie: result,
        );
      }
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    final prefs = AppPreferences();
    final double widthScreen = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          if (prefs.idRegistroEdit.isEmpty) {
            if (_reg.hasSomething()) {
              log('WILL NOT POP');

              Utils.confirmAlert(context, "Abandonar registro",
                  "¿Esta seguro que desea abandonar el registro de producción?",
                  () {
                Navigator.of(context).pop();

                // VUELVE A LA PANTALLA ANTERIOR
                Navigator.of(context).pop();
              });

              return false;
            } else {
              log('WILL POP');
              return true;
            }
          } else {
            log('WILL POP');
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text((prefs.idRegistroEdit.isNotEmpty)
                ? 'EDITAR REGISTRO DE PRODUCCIÓN'
                : 'NUEVO REGISTRO DE PRODUCCIÓN'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  setState(() {});
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, SettingsView.routeName)
                      .then((value) {
                    setState(() {});
                  });
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Sizes.espacioAlto10,
                  Row(
                    children: [
                      MaquinaCard(
                        onRefresh: () {
                          setState(() {});
                        },
                      ),
                      DepositoCard(
                        onRefresh: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ProductoCard(),
                      OperarioCard(),
                    ],
                  ),
                  (prefs.maquinaTipo.isEmpty ||
                          prefs.operarioId.isEmpty ||
                          prefs.productoId.isEmpty)
                      ? Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          color: Colors.amber[100],
                          height: 250,
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              const Spacer(),
                              const Center(
                                child: Text(
                                  'Debe seleccionar una maquina, un producto y un operario para poder continuar. Una vez seleccionados, presione confirmar.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {});
                                },
                                label: const Text('CONFIRMAR'),
                                icon: const Icon(Icons.check,
                                    color: Colors.white),
                              ),
                              const Spacer(),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 200,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final prefs = AppPreferences();
                                      String? _t = await selectTurno();

                                      if (_t != null) {
                                        _turno = Turno();
                                        _turno.codigo = _t;
                                        _turno.nombre = _t;
                                      } else {
                                        _turno.codigo = '';
                                        _turno.nombre = '';
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1, vertical: 1),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      decoration: BoxDecoration(
                                        border: Utils.borderApp,
                                        color: Colors.grey[200],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'TURNO ACTUAL:',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (_turno.codigo!.isNotEmpty)
                                            Text(
                                              _turno.nombre!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ContadorCard(
                                  label: 'LOTE: ',
                                  value: _reg.lote!,
                                  onPressed: () async {
                                    String result = await Modal.addModal(
                                        context: context, title: 'LOTE');
                                    if (result.isNotEmpty) {
                                      if (result == 'delete') {
                                        _reg.lote = '';
                                      } else {
                                        _reg.lote = result;
                                      }
                                      setState(() {});
                                    }
                                  },
                                ),
                                ContadorCard(
                                  label: 'CONTADOR INICIAL: ',
                                  value: _reg.contadorInicial!,
                                  onPressed: () async {
                                    String result = await Modal.addModal(
                                        context: context,
                                        title: 'CONTADOR INICIAL');
                                    if (result.isNotEmpty) {
                                      if (result == 'delete') {
                                        _reg.contadorInicial = '';
                                      } else {
                                        _reg.contadorInicial = result;
                                      }
                                      setState(() {});
                                    }
                                  },
                                ),
                              ],
                            ),
                            // MATERIA PRIMA
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSubTituloCard(
                                      context, 'MATERIA PRIMA UTILIZADA'),
                                ),
                              ],
                            ),

                            if (prefs.maquinaTipo == MaquinaType.UNA_BOBINA)
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 1, left: 1, right: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Sizes.mpLabelWidth,
                                          child: AdhesivoLabel(
                                              text: 'Adhesivo\ntrasero:'),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoTrasero1!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO TRASERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoTrasero1 = '';
                                                } else {
                                                  _reg.adhesivoTrasero1 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoTrasero2!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO TRASERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoTrasero2 = '';
                                                } else {
                                                  _reg.adhesivoTrasero2 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoTrasero3!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO TRASERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoTrasero3 = '';
                                                } else {
                                                  _reg.adhesivoTrasero3 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoTrasero4!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO TRASERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoTrasero4 = '';
                                                } else {
                                                  _reg.adhesivoTrasero4 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoTrasero5!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO TRASERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoTrasero5 = '';
                                                } else {
                                                  _reg.adhesivoTrasero5 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 1, left: 1, right: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Sizes.mpLabelWidth,
                                          child: AdhesivoLabel(
                                              text: 'Adhesivo\ndelantero:'),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoDelantero1!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO DELANTERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoDelantero1 = '';
                                                } else {
                                                  _reg.adhesivoDelantero1 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoDelantero2!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO DELANTERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoDelantero2 = '';
                                                } else {
                                                  _reg.adhesivoDelantero2 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoDelantero3!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO DELANTERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoDelantero3 = '';
                                                } else {
                                                  _reg.adhesivoDelantero3 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoDelantero4!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO DELANTERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoDelantero4 = '';
                                                } else {
                                                  _reg.adhesivoDelantero4 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoDelantero5!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO DELANTERO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoDelantero5 = '';
                                                } else {
                                                  _reg.adhesivoDelantero5 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 1, left: 1, right: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Sizes.mpLabelWidth,
                                          child: BobinaLabel(
                                              text: 'Bobina\npapel:'),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobina1!,
                                            nro: '1',
                                            onPressed: () async {
                                              if (_tieneBobina(_reg.bobina1)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobina1 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result != null &&
                                                      result.isNotEmpty) {
                                                    _reg.bobina1 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobina1 = bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobina1 = bobina;
                                              //     });
                                              //   }
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobina1!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobina2!,
                                            nro: '2',
                                            onPressed: () async {
                                              if (_tieneBobina(_reg.bobina2)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobina2 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobina2 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobina2 = bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobina2 = bobina;
                                              //     });
                                              //   }
                                              // }

                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobina2 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobina2!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobina3!,
                                            nro: '3',
                                            onPressed: () async {
                                              if (_tieneBobina(_reg.bobina3)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobina3 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobina3 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobina3 = bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobina3 = bobina;
                                              //     });
                                              //   }
                                              // }
                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobina3 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobina3!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 1, left: 1, right: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Sizes.mpLabelWidth,
                                          child: AdhesivoAdd(
                                              text: '', onPressed: () {}),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobina4!,
                                            nro: '4',
                                            onPressed: () async {
                                              if (_tieneBobina(_reg.bobina4)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobina4 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobina4 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobina4 = bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobina4 = bobina;
                                              //     });
                                              //   }
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobina4!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobina5!,
                                            nro: '5',
                                            onPressed: () async {
                                              if (_tieneBobina(_reg.bobina5)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobina5 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobina5 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobina5 = bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobina5 = bobina;
                                              //     });
                                              //   }
                                              // }

                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobina5 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobina5!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobina6!,
                                            nro: '6',
                                            onPressed: () async {
                                              if (_tieneBobina(_reg.bobina6)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobina6 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobina6 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobina6 = bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobina6 = bobina;
                                              //     });
                                              //   }
                                              // }
                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobina6 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobina6!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            if (prefs.maquinaTipo == MaquinaType.TRES_BOBINAS)
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 1, left: 1, right: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Sizes.mpLabelWidth,
                                          child: AdhesivoLabel(
                                              text: 'Adhesivo\nfondo:'),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoFondo1!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title: 'ADHESIVO FONDO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoFondo1 = '';
                                                } else {
                                                  _reg.adhesivoFondo1 = result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoFondo2!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title: 'ADHESIVO FONDO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoFondo2 = '';
                                                } else {
                                                  _reg.adhesivoFondo2 = result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: Sizes.mpLabelWidth,
                                            child: AdhesivoLabel(
                                                text: 'Adhesivo\ncorrugado:'),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoCorrugado!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO CORRUGADO');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoCorrugado = '';
                                                } else {
                                                  _reg.adhesivoCorrugado =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 1, left: 1, right: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Sizes.mpLabelWidth,
                                          child: AdhesivoLabel(
                                              text: 'Adhesivo\nlateral:'),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoLateral1!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO LATERAL');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoLateral1 = '';
                                                } else {
                                                  _reg.adhesivoLateral1 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.adhesivoLateral2!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title:
                                                          'ADHESIVO LATERAL');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.adhesivoLateral2 = '';
                                                } else {
                                                  _reg.adhesivoLateral2 =
                                                      result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: Sizes.mpLabelWidth,
                                            child: AdhesivoLabel(
                                                text: 'Desmoldante:'),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: AdhesivoAdd(
                                            text: _reg.desmoldante!,
                                            onPressed: () async {
                                              String result =
                                                  await Modal.addModal(
                                                      context: context,
                                                      title: 'DESMOLDANTE');
                                              if (result.isNotEmpty) {
                                                if (result == 'delete') {
                                                  _reg.desmoldante = '';
                                                } else {
                                                  _reg.desmoldante = result;
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 1, left: 1, right: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Sizes.mpLabelWidth,
                                          child: BobinaLabel(
                                              text: 'Bobina\nfondo:'),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobinaFondo1!,
                                            nro: '1',
                                            onPressed: () async {
                                              if (_tieneBobina(
                                                  _reg.bobinaFondo1)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobinaFondo1 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobinaFondo1 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobinaFondo1 =
                                              //             bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobinaFondo1 = bobina;
                                              //     });
                                              //   }
                                              // }

                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobinaFondo1 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobinaFondo1!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobinaFondo2!,
                                            nro: '2',
                                            onPressed: () async {
                                              if (_tieneBobina(
                                                  _reg.bobinaFondo2)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobinaFondo2 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobinaFondo2 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobinaFondo2 =
                                              //             bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobinaFondo2 = bobina;
                                              //     });
                                              //   }
                                              // }
                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobinaFondo2 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobinaFondo2!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobinaFondo3!,
                                            nro: '3',
                                            onPressed: () async {
                                              if (_tieneBobina(
                                                  _reg.bobinaFondo3)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobinaFondo3 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobinaFondo3 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobinaFondo3 =
                                              //             bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobinaFondo3 = bobina;
                                              //     });
                                              //   }
                                              // }
                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobinaFondo3 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobinaFondo3!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 1, left: 1, right: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Sizes.mpLabelWidth,
                                          child: BobinaLabel(
                                              text: 'Bobina\nlateral:'),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobinaLateral1!,
                                            nro: '1',
                                            onPressed: () async {
                                              if (_tieneBobina(
                                                  _reg.bobinaLateral1)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobinaLateral1 =
                                                        Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobinaLateral1 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobinaLateral1 =
                                              //             bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobinaLateral1 =
                                              //           bobina;
                                              //     });
                                              //   }
                                              // }

                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobinaLateral1 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobinaLateral1!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobinaLateral2!,
                                            nro: '2',
                                            onPressed: () async {
                                              if (_tieneBobina(
                                                  _reg.bobinaLateral2)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobinaLateral2 =
                                                        Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobinaLateral2 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobinaLateral2 =
                                              //             bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobinaLateral2 =
                                              //           bobina;
                                              //     });
                                              //   }
                                              // }
                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobinaLateral2 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobinaLateral2!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobinaLateral3!,
                                            nro: '3',
                                            onPressed: () async {
                                              if (_tieneBobina(
                                                  _reg.bobinaLateral3)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobinaLateral3 =
                                                        Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobinaLateral3 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobinaLateral3 =
                                              //             bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobinaLateral3 =
                                              //           bobina;
                                              //     });
                                              //   }
                                              // }
                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobinaLateral3 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobinaLateral3!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 1, left: 1, right: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Sizes.mpLabelWidth,
                                          child: BobinaLabel(
                                              text: 'Bobina\ncono:'),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobinaCono1!,
                                            nro: '1',
                                            onPressed: () async {
                                              if (_tieneBobina(
                                                  _reg.bobinaCono1)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobinaCono1 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobinaCono1 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobinaCono1 = bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobinaCono1 = bobina;
                                              //     });
                                              //   }
                                              // }

                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobinaCono1 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobinaCono1!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobinaCono2!,
                                            nro: '2',
                                            onPressed: () async {
                                              if (_tieneBobina(
                                                  _reg.bobinaCono2)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobinaCono2 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobinaCono2 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobinaCono2 = bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobinaCono2 = bobina;
                                              //     });
                                              //   }
                                              // }
                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobinaCono2 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobinaCono2!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: BobinaAdd(
                                            bobina: _reg.bobinaCono3!,
                                            nro: '3',
                                            onPressed: () async {
                                              if (_tieneBobina(
                                                  _reg.bobinaCono3)) {
                                                _borrarBobina(() {
                                                  setState(() {
                                                    _reg.bobinaCono3 = Bobina(
                                                      id: '',
                                                      codproducto: '',
                                                      nombre: '',
                                                      nroSerie: '',
                                                    );
                                                  });
                                                });
                                              } else {
                                                try {
                                                  String? result =
                                                      await openTextScanner(
                                                          context);
                                                  if (result!.isNotEmpty) {
                                                    _reg.bobinaCono3 =
                                                        await _scanBobina(
                                                            result);
                                                    setState(() {});
                                                  }
                                                } catch (err) {
                                                  print(
                                                      '=== QR SCANNER ERROR === $err');
                                                }
                                              }

                                              // Bobina? bobina = await Modal
                                              //     .seleccionarBobinaPorDeposito(
                                              //         context);
                                              // if (bobina != null) {
                                              //   if (bobina
                                              //       .codproducto!.isNotEmpty) {
                                              //     // OPEN NRO SERIE
                                              //     NroSerie? nroSerie = await Modal
                                              //         .seleccionarNumeroSerie(
                                              //             context,
                                              //             bobina.codproducto!);
                                              //     if (nroSerie != null) {
                                              //       bobina.nroSerie =
                                              //           nroSerie.nroserie;

                                              //       setState(() {
                                              //         _reg.bobinaCono3 = bobina;
                                              //       });
                                              //     }
                                              //   } else {
                                              //     bobina = Bobina.init();
                                              //     setState(() {
                                              //       _reg.bobinaCono3 = bobina;
                                              //     });
                                              //   }
                                              // }

                                              // Bobina? bobina =
                                              //     await Modal.seleccionarBobina(
                                              //         context);
                                              // if (bobina != null) {
                                              //   setState(() {
                                              //     _reg.bobinaCono3 = bobina;
                                              //   });
                                              // }
                                            },
                                            onChecked: (newValue) {
                                              setState(() {
                                                _reg.bobinaCono3!.checked =
                                                    newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            // END MATERIA PRIMA
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //CONTROLES
                                Expanded(
                                  flex: 3,
                                  child:
                                      _buildSubTituloCard(context, 'CONTROLES'),
                                ),
                                // FALLOS
                                Expanded(
                                  flex: 5,
                                  child: _buildSubTituloFallos(
                                      context, 'FALLOS DE LA MAQUINA'),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //CONTROLES DETALLE
                                Expanded(
                                  flex: 3,
                                  // child: DataTableControles(),
                                  child: (prefs.maquinaTipo ==
                                          MaquinaType.UNA_BOBINA)
                                      ? _controlesBUDIN(context)
                                      : _controlesNOBUDIN(context),
                                ),
                                // FALLOS DETALLE
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        FallosMaquinaHead(),
                                        FallosMaquinaLista(
                                          fallos: _reg.fallosMaquina!,
                                          onRefresh: () {
                                            setState(() {});
                                          },
                                        ),
                                        FallosMaquinaTotalHoras(
                                            fallos: _reg.fallosMaquina!),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ContadorCard(
                                  label: 'CANT. MOLDES FABRICADOS: ',
                                  value: _reg.cantidadMoldes!,
                                  onPressed: () async {
                                    String result = await Modal.addModal(
                                        context: context,
                                        title: 'MODEL FABICADOS');
                                    if (result.isNotEmpty) {
                                      if (result == 'delete') {
                                        _reg.cantidadMoldes = '';
                                      } else {
                                        _reg.cantidadMoldes = result;
                                      }
                                      setState(() {});
                                    }
                                  },
                                ),
                                ContadorCard(
                                  label: 'CONTADOR FINAL: ',
                                  value: _reg.contadorFinal!,
                                  onPressed: () async {
                                    String result = await Modal.addModal(
                                        context: context,
                                        title: 'CONTADOR FINAL');
                                    if (result.isNotEmpty) {
                                      if (result == 'delete') {
                                        _reg.contadorFinal = '';
                                      } else {
                                        _reg.contadorFinal = result;
                                      }
                                      setState(() {});
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ContadorCard(
                                  label: 'CANT. CAJAS COMPLETADAS: ',
                                  value: _reg.cantidadCajas!,
                                  onPressed: () async {
                                    String result = await Modal.addModal(
                                        context: context,
                                        title: 'CAJAS COMPLETADAS');
                                    if (result.isNotEmpty) {
                                      if (result == 'delete') {
                                        _reg.cantidadCajas = '';
                                      } else {
                                        _reg.cantidadCajas = result;
                                      }
                                      setState(() {});
                                    }
                                  },
                                ),
                                Expanded(child: Container(height: 1, width: 1)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                  '(*) SI NO ENCUENTRA EL CODIGO O DESCRIPCION DEL FALLO DE MAQUINA DEBE AGREGARLO EN OBSERVACIONES.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _finalizarButton(context, prefs),
                              ],
                            ),

                            const SizedBox(height: 80),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<String?> selectTurno() async {
    var _style = TextStyle(fontSize: 24);
    return await showDialog<String?>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Container(
              width: 500,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: const Text(
                'Selecciona un turno',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, '1');
                },
                child: Container(
                  width: 500,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text('1', style: _style),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, '2');
                },
                child: Container(
                  width: 500,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text('2', style: _style),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, '3');
                },
                child: Container(
                  width: 500,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text('3', style: _style),
                ),
              ),
            ],
          );
        });
  }

  Column _controlesBUDIN(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ControlesRow(
          label: 'CRUCE',
          nro1: _reg.cruce_1!,
          nro2: _reg.cruce_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'CRUCE - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.cruce_1 = '';
              } else {
                _reg.cruce_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'CRUCE - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.cruce_2 = '';
              } else {
                _reg.cruce_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'RULO/PESTAÑA',
          nro1: _reg.rulo_1!,
          nro2: _reg.rulo_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'RULO/PESTAÑA - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.rulo_1 = '';
              } else {
                _reg.rulo_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'RULO/PESTAÑA - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.rulo_2 = '';
              } else {
                _reg.rulo_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'PEGADO TRASERO',
          nro1: _reg.pegado_trasero_1!,
          nro2: _reg.pegado_trasero_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'PEGADO TRASERO - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.pegado_trasero_1 = '';
              } else {
                _reg.pegado_trasero_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'PEGADO TRASERO - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.pegado_trasero_2 = '';
              } else {
                _reg.pegado_trasero_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'PEGADO DELANTERO',
          nro1: _reg.pegado_delantero_1!,
          nro2: _reg.pegado_delantero_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'PEGADO DELANTERO - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.pegado_delantero_1 = '';
              } else {
                _reg.pegado_delantero_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'PEGADO DELANTERO - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.pegado_delantero_2 = '';
              } else {
                _reg.pegado_delantero_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'CANTIDAD EN CONO',
          nro1: _reg.cant_cono_1!,
          nro2: _reg.cant_cono_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'CANTIDAD EN CONO - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.cant_cono_1 = '';
              } else {
                _reg.cant_cono_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'CANTIDAD EN CONO - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.cant_cono_2 = '';
              } else {
                _reg.cant_cono_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'GRAFICA',
          nro1: _reg.grafica_1!,
          nro2: _reg.grafica_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'GRAFICA - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.grafica_1 = '';
              } else {
                _reg.grafica_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'GRAFICA - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.grafica_2 = '';
              } else {
                _reg.grafica_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'TROQUELADO',
          nro1: _reg.troquelado_1!,
          nro2: _reg.troquelado_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'TROQUELADO - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.troquelado_1 = '';
              } else {
                _reg.troquelado_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'TROQUELADO - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.troquelado_2 = '';
              } else {
                _reg.troquelado_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'MATERIAS EXTRAÑAS',
          nro1: _reg.materias_1!,
          nro2: _reg.materias_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'MATERIAS EXTRAÑAS - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.materias_1 = '';
              } else {
                _reg.materias_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'MATERIAS EXTRAÑAS - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.materias_2 = '';
              } else {
                _reg.materias_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'PPR3',
          nro1: _reg.ppr3_1!,
          nro2: _reg.ppr3_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR3 - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr3_1 = '';
              } else {
                _reg.ppr3_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR3 - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr3_2 = '';
              } else {
                _reg.ppr3_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'PPR4',
          nro1: _reg.ppr4_1!,
          nro2: _reg.ppr4_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR4 - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr4_1 = '';
              } else {
                _reg.ppr4_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR4 - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr4_2 = '';
              } else {
                _reg.ppr4_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'PPR6',
          nro1: _reg.ppr6_1!,
          nro2: _reg.ppr6_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR6 - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr6_1 = '';
              } else {
                _reg.ppr6_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR6 - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr6_2 = '';
              } else {
                _reg.ppr6_2 = result;
              }
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Column _controlesNOBUDIN(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ControlesRow(
          label: 'ALTURA',
          nro1: _reg.altura_1!,
          nro2: _reg.altura_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'ALTURA - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.altura_1 = '';
              } else {
                _reg.altura_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'ALTURA - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.altura_2 = '';
              } else {
                _reg.altura_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'TERMINACIÓN SUPERIOR',
          nro1: _reg.terminacion_superior_1!,
          nro2: _reg.terminacion_superior_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'TERMINACIÓN SUPERIOR - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.terminacion_superior_1 = '';
              } else {
                _reg.terminacion_superior_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'TERMINACIÓN SUPERIOR - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.terminacion_superior_2 = '';
              } else {
                _reg.terminacion_superior_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'CRUCE',
          nro1: _reg.cruce_1!,
          nro2: _reg.cruce_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'CRUCE - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.cruce_1 = '';
              } else {
                _reg.cruce_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'CRUCE - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.cruce_2 = '';
              } else {
                _reg.cruce_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'PEGADO',
          nro1: _reg.pegado_1!,
          nro2: _reg.pegado_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'PEGADO - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.pegado_1 = '';
              } else {
                _reg.pegado_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'PEGADO - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.pegado_2 = '';
              } else {
                _reg.pegado_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'CANTIDAD EN CONO',
          nro1: _reg.cant_cono_1!,
          nro2: _reg.cant_cono_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'CANTIDAD EN CONO - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.cant_cono_1 = '';
              } else {
                _reg.cant_cono_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'CANTIDAD EN CONO - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.cant_cono_2 = '';
              } else {
                _reg.cant_cono_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'GRAFICA',
          nro1: _reg.grafica_1!,
          nro2: _reg.grafica_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'GRAFICA - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.grafica_1 = '';
              } else {
                _reg.grafica_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'GRAFICA - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.grafica_2 = '';
              } else {
                _reg.grafica_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'MICROPERFORADO',
          nro1: _reg.microperforado_1!,
          nro2: _reg.microperforado_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'MICROPERFORADO - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.microperforado_1 = '';
              } else {
                _reg.microperforado_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'MICROPERFORADO - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.microperforado_2 = '';
              } else {
                _reg.microperforado_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'MATERIAS EXTRAÑAS',
          nro1: _reg.materias_1!,
          nro2: _reg.materias_2!,
          onPressed1: () async {
            String result = await Modal.addModal(
                context: context, title: 'MATERIAS EXTRAÑAS - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.materias_1 = '';
              } else {
                _reg.materias_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result = await Modal.addModal(
                context: context, title: 'MATERIAS EXTRAÑAS - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.materias_2 = '';
              } else {
                _reg.materias_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'PPR3',
          nro1: _reg.ppr3_1!,
          nro2: _reg.ppr3_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR3 - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr3_1 = '';
              } else {
                _reg.ppr3_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR3 - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr3_2 = '';
              } else {
                _reg.ppr3_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'PPR4',
          nro1: _reg.ppr4_1!,
          nro2: _reg.ppr4_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR4 - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr4_1 = '';
              } else {
                _reg.ppr4_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR4 - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr4_2 = '';
              } else {
                _reg.ppr4_2 = result;
              }
              setState(() {});
            }
          },
        ),
        ControlesRow(
          label: 'PPR6',
          nro1: _reg.ppr6_1!,
          nro2: _reg.ppr6_2!,
          onPressed1: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR6 - NRO 1');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr6_1 = '';
              } else {
                _reg.ppr6_1 = result;
              }
              setState(() {});
            }
          },
          onPressed2: () async {
            String result =
                await Modal.addModal(context: context, title: 'PPR6 - NRO 2');
            if (result.isNotEmpty) {
              if (result == 'delete') {
                _reg.ppr6_2 = '';
              } else {
                _reg.ppr6_2 = result;
              }
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget _finalizarButton(BuildContext context, AppPreferences prefs) {
    return BlocConsumer<RegistroAddCubit, RegistroAddState>(
      listener: (context, state) {
        if (state is RegistroAddLoaded) {
          if (state.mensaje.contains('con exito')) {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          }
        }
      },
      builder: (context, state) {
        if (state == null) return Text('State error');

        if (state is RegistroAddInitial) {
          return _buildFinalizarButton(prefs, context);
        } else if (state is RegistroAddLoading) {
          return Text('Loading..');
        } else if (state is RegistroAddError) {
          return _buildFinalizarButton(prefs, context);
        } else if (state is RegistroAddLoaded) {
          return Text(state.mensaje);
        } else {
          return _buildFinalizarButton(prefs, context);
        }
      },
    );
  }

  Container _buildFinalizarButton(AppPreferences prefs, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: FinishButton(
        text: 'FINALIZAR',
        onPressed: () async {
          _reg.idMaquina = prefs.maquinaId;
          _reg.legajoOperario = prefs.operarioId;
          _reg.codProducto = prefs.productoId;
          _reg.deposito = prefs.depositoId;
          _reg.fecha = prefs.fechaTurno;
          _reg.hora = prefs.horaTurno;
          _reg.turno = _turno.codigo;
          _reg.embaladoPor = prefs.embaladoPorCodigo;
          _reg.codigoCajas = prefs.codigoCaja;

          if (_reg.isReady()) {
            Utils.confirmAlert(context, 'Finalizar registro',
                '¿Esta seguro que desea guardar el registro de produccion?',
                () async {
              Navigator.of(context).pop();

              if (prefs.idRegistroEdit.isNotEmpty) {
                _reg.id = prefs.idRegistroEdit;
                await context.read<RegistroAddCubit>().PRO_editRegistro(_reg);

                final regState = context.read<RegistroDetalleCubit>().state;
                // ignore: unrelated_type_equality_checks
                if (regState == RegistroDetalleError) {
                  Utils.snackBarWarinig(
                      context, 'Algo salio mal', 'Registro no guardado');
                } else {
                  Utils.snackBarSuccess(context, 'Registro actualizado',
                      'Registro guardado correctamente.');
                }
              } else {
                await context.read<RegistroAddCubit>().PRO_insertRegistro(_reg);

                Utils.snackBarSuccess(context, 'Excelente',
                    'Registro finalizado y descargado correctamente.');
              }

              log(json.encode(_reg.toJson()).toString());
            });
          } else {
            Utils.snackBarWarinig(
                context, 'Aviso', 'Debe completar los campos obligatorios.');
          }
        },
      ),
    );
  }

  Widget _buildSubTituloCard(BuildContext context, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.yellow[300],
        border: Utils.borderApp,
      ),
      child: Row(
        children: [
          Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildSubTituloFallos(BuildContext context, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        border: Utils.borderApp,
        color: Colors.yellow[300],
      ),
      child: Row(
        children: [
          Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () async {
              Fallo? falloSelected = await Modal.seleccionarFallo(context);
              if (falloSelected != null) {
                FalloMaquina? falloAdded = await FalloMaquinaModal.addModal(
                  context: context,
                  title: 'INGRESE TIEMPO Y OBSERVACIONES',
                  fallo: falloSelected,
                );

                if (falloAdded != null) {
                  _reg.fallosMaquina!.add(falloAdded);

                  setState(() {});

                  // LISTA FALLOS DE NUEVO
                  context.read<FalloCubit>().PRO_fallos('');
                }
                //setState(() {});
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildContadorCard(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Utils.simpleAlert(context, 'Agregar contador inicial',
              'Pide numero de contador inicial');
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radious),
            color: Colors.orange[100],
          ),
          child: const Text('Contador inicial: '),
        ),
      ),
    );
  }
}
