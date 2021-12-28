import 'package:flutter/material.dart';
import 'package:webtest/src/models/bobina.dart';

import 'package:webtest/src/models/fallo_maquina_model.dart';
import 'package:webtest/src/models/fallo.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/adhesivo_add.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/adhesivo_label.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/bobina_add.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/bobina_label.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/contador_card.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/controles_row.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/fallo_maquina_modal.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/fallos_maquina_head.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/fallos_maquina_row.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/maquina_card.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/operario_card.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/modal.dart';
import 'package:webtest/src/utils/sizes.dart';
import 'package:webtest/src/utils/utils.dart';

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

  String _contadorInicial = '';
  String _lote = '';
  String _contadorFinal = '';
  String _cantidadMoldes = '';
  String _cantidadCajas = '';

  String _adhesivoTrasero1 = '';
  String _adhesivoTrasero2 = '';
  String _adhesivoTrasero3 = '';
  String _adhesivoTrasero4 = '';
  String _adhesivoTrasero5 = '';

  String _adhesivoDelantero1 = '';
  String _adhesivoDelantero2 = '';
  String _adhesivoDelantero3 = '';
  String _adhesivoDelantero4 = '';
  String _adhesivoDelantero5 = '';

  Bobina _bobina1 = Bobina(id: '', nombre: '');
  Bobina _bobina2 = Bobina(id: '', nombre: '');
  Bobina _bobina3 = Bobina(id: '', nombre: '');
  Bobina _bobina4 = Bobina(id: '', nombre: '');
  Bobina _bobina5 = Bobina(id: '', nombre: '');
  Bobina _bobina6 = Bobina(id: '', nombre: '');

  String _cruce_1 = '';
  String _cruce_2 = '';

  String _rulo_1 = '';
  String _rulo_2 = '';

  String _pegado_trasero_1 = '';
  String _pegado_trasero_2 = '';

  String _pegado_delantero_1 = '';
  String _pegado_delantero_2 = '';

  String _cant_cono_1 = '';
  String _cant_cono_2 = '';

  String _grafica_1 = '';
  String _grafica_2 = '';

  String _troquelado_1 = '';
  String _troquelado_2 = '';

  String _materias_1 = '';
  String _materias_2 = '';

  String _ppr3_1 = '';
  String _ppr3_2 = '';

  String _ppr4_1 = '';
  String _ppr4_2 = '';

  String _ppr6_1 = '';
  String _ppr6_2 = '';

  List<FalloMaquina> _fallosMaquina = [];

  @override
  Widget build(BuildContext context) {
    final prefs = AppPreferences();
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('NUEVO REGISTRO DE PRODUCCIÓN'),
        actions: [
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
                  MaquinaCard(),
                  OperarioCard(),
                ],
              ),
              Row(
                children: [
                  ContadorCard(
                    label: 'LOTE: ',
                    value: _lote,
                    onPressed: () async {
                      String result =
                          await Modal.addModal(context: context, title: 'LOTE');
                      if (result.isNotEmpty) {
                        if (result == 'delete') {
                          _lote = '';
                        } else {
                          _lote = result;
                        }
                        setState(() {});
                      }
                    },
                  ),
                  ContadorCard(
                    label: 'CONTADOR INICIAL: ',
                    value: _contadorInicial,
                    onPressed: () async {
                      String result = await Modal.addModal(
                          context: context, title: 'CONTADOR INICIAL');
                      if (result.isNotEmpty) {
                        if (result == 'delete') {
                          _contadorInicial = '';
                        } else {
                          _contadorInicial = result;
                        }
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child:
                        _buildSubTituloCard(context, 'MATERIA PRIMA UTILIZADA'),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Sizes.mpLabelWidth,
                      child: AdhesivoLabel(text: 'Adhesivo\ntrasero:'),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoTrasero1,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO TRASERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoTrasero1 = '';
                            } else {
                              _adhesivoTrasero1 = result;
                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoTrasero2,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO TRASERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoTrasero2 = '';
                            } else {
                              _adhesivoTrasero2 = result;
                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoTrasero3,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO TRASERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoTrasero3 = '';
                            } else {
                              _adhesivoTrasero3 = result;
                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoTrasero4,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO TRASERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoTrasero4 = '';
                            } else {
                              _adhesivoTrasero4 = result;
                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoTrasero5,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO TRASERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoTrasero5 = '';
                            } else {
                              _adhesivoTrasero5 = result;
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
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Sizes.mpLabelWidth,
                      child: AdhesivoLabel(text: 'Adhesivo\ndelantero:'),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoDelantero1,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO DELANTERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoDelantero1 = '';
                            } else {
                              _adhesivoDelantero1 = result;
                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoDelantero2,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO DELANTERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoDelantero2 = '';
                            } else {
                              _adhesivoDelantero2 = result;
                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoDelantero3,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO DELANTERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoDelantero3 = '';
                            } else {
                              _adhesivoDelantero3 = result;
                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoDelantero4,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO DELANTERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoDelantero4 = '';
                            } else {
                              _adhesivoDelantero4 = result;
                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AdhesivoAdd(
                        text: _adhesivoDelantero5,
                        onPressed: () async {
                          String result = await Modal.addModal(
                              context: context, title: 'ADHESIVO DELANTERO');
                          if (result.isNotEmpty) {
                            if (result == 'delete') {
                              _adhesivoDelantero5 = '';
                            } else {
                              _adhesivoDelantero5 = result;
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
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Sizes.mpLabelWidth,
                      child: BobinaLabel(text: 'Bobina\npapel:'),
                    ),
                    Expanded(
                      flex: 2,
                      child: BobinaAdd(
                        bobina: _bobina1,
                        nro: '1',
                        onPressed: () async {
                          Bobina? bobina =
                              await Modal.seleccionarBobina(context);
                          if (bobina != null) {
                            setState(() {
                              _bobina1 = bobina;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: BobinaAdd(
                        bobina: _bobina2,
                        nro: '2',
                        onPressed: () async {
                          Bobina? bobina =
                              await Modal.seleccionarBobina(context);
                          if (bobina != null) {
                            setState(() {
                              _bobina2 = bobina;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: BobinaAdd(
                        bobina: _bobina3,
                        nro: '3',
                        onPressed: () async {
                          Bobina? bobina =
                              await Modal.seleccionarBobina(context);
                          if (bobina != null) {
                            setState(() {
                              _bobina3 = bobina;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Sizes.mpLabelWidth,
                      child: AdhesivoAdd(text: '', onPressed: () {}),
                    ),
                    Expanded(
                      flex: 2,
                      child: BobinaAdd(
                        bobina: _bobina4,
                        nro: '4',
                        onPressed: () async {
                          Bobina? bobina =
                              await Modal.seleccionarBobina(context);
                          if (bobina != null) {
                            setState(() {
                              _bobina4 = bobina;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: BobinaAdd(
                        bobina: _bobina5,
                        nro: '5',
                        onPressed: () async {
                          Bobina? bobina =
                              await Modal.seleccionarBobina(context);
                          if (bobina != null) {
                            setState(() {
                              _bobina5 = bobina;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: BobinaAdd(
                        bobina: _bobina6,
                        nro: '6',
                        onPressed: () async {
                          Bobina? bobina =
                              await Modal.seleccionarBobina(context);
                          if (bobina != null) {
                            setState(() {
                              _bobina6 = bobina;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //CONTROLES
                  Expanded(
                    flex: 3,
                    child: _buildSubTituloCard(context, 'CONTROLES'),
                  ),
                  // FALLOS
                  Expanded(
                    flex: 5,
                    child:
                        _buildSubTituloFallos(context, 'FALLOS DE LA MAQUINA'),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ControlesRow(
                          label: 'CRUCE',
                          nro1: _cruce_1,
                          nro2: _cruce_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'CRUCE - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _cruce_1 = '';
                              } else {
                                _cruce_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'CRUCE - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _cruce_2 = '';
                              } else {
                                _cruce_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'RULO/PESTAÑA',
                          nro1: _rulo_1,
                          nro2: _rulo_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'RULO/PESTAÑA - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _rulo_1 = '';
                              } else {
                                _rulo_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'RULO/PESTAÑA - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _rulo_2 = '';
                              } else {
                                _rulo_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'PEGADO TRASERO',
                          nro1: _pegado_trasero_1,
                          nro2: _pegado_trasero_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'PEGADO TRASERO - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _pegado_trasero_1 = '';
                              } else {
                                _pegado_trasero_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'PEGADO TRASERO - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _pegado_trasero_2 = '';
                              } else {
                                _pegado_trasero_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'PEGADO DELANTERO',
                          nro1: _pegado_delantero_1,
                          nro2: _pegado_delantero_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'PEGADO DELANTERO - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _pegado_delantero_1 = '';
                              } else {
                                _pegado_delantero_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'PEGADO DELANTERO - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _pegado_delantero_2 = '';
                              } else {
                                _pegado_delantero_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'CANTIDAD EN CONO',
                          nro1: _cant_cono_1,
                          nro2: _cant_cono_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'CANTIDAD EN CONO - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _cant_cono_1 = '';
                              } else {
                                _cant_cono_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'CANTIDAD EN CONO - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _cant_cono_2 = '';
                              } else {
                                _cant_cono_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'GRAFICA',
                          nro1: _grafica_1,
                          nro2: _grafica_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'GRAFICA - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _grafica_1 = '';
                              } else {
                                _grafica_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'GRAFICA - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _grafica_2 = '';
                              } else {
                                _grafica_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'TROQUELADO',
                          nro1: _troquelado_1,
                          nro2: _troquelado_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'TROQUELADO - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _troquelado_1 = '';
                              } else {
                                _troquelado_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'TROQUELADO - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _troquelado_2 = '';
                              } else {
                                _troquelado_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'MATERIAS EXTRAÑAS',
                          nro1: _materias_1,
                          nro2: _materias_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'MATERIAS EXTRAÑAS - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _materias_1 = '';
                              } else {
                                _materias_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context,
                                title: 'MATERIAS EXTRAÑAS - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _materias_2 = '';
                              } else {
                                _materias_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'PPR3',
                          nro1: _ppr3_1,
                          nro2: _ppr3_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'PPR3 - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _ppr3_1 = '';
                              } else {
                                _ppr3_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'PPR3 - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _ppr3_2 = '';
                              } else {
                                _ppr3_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'PPR4',
                          nro1: _ppr4_1,
                          nro2: _ppr4_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'PPR4 - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _ppr4_1 = '';
                              } else {
                                _ppr4_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'PPR4 - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _ppr4_2 = '';
                              } else {
                                _ppr4_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                        ControlesRow(
                          label: 'PPR6',
                          nro1: _ppr6_1,
                          nro2: _ppr6_2,
                          onPressed1: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'PPR6 - NRO 1');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _ppr6_1 = '';
                              } else {
                                _ppr6_1 = result;
                              }
                              setState(() {});
                            }
                          },
                          onPressed2: () async {
                            String result = await Modal.addModal(
                                context: context, title: 'PPR6 - NRO 2');
                            if (result.isNotEmpty) {
                              if (result == 'delete') {
                                _ppr6_2 = '';
                              } else {
                                _ppr6_2 = result;
                              }
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  // FALLOS DETALLE
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FallosMaquinaHead(),
                          FallosMaquinaLista(
                            fallos: _fallosMaquina,
                            onRefresh: () {
                              setState(() {});
                            },
                          ),
                          FallosMaquinaTotalHoras(fallos: _fallosMaquina),
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
                    value: _cantidadMoldes,
                    onPressed: () async {
                      String result = await Modal.addModal(
                          context: context, title: 'MODEL FABICADOS');
                      if (result.isNotEmpty) {
                        if (result == 'delete') {
                          _cantidadMoldes = '';
                        } else {
                          _cantidadMoldes = result;
                        }
                        setState(() {});
                      }
                    },
                  ),
                  ContadorCard(
                    label: 'CONTADOR FINAL: ',
                    value: _contadorFinal,
                    onPressed: () async {
                      String result = await Modal.addModal(
                          context: context, title: 'CONTADOR FINAL');
                      if (result.isNotEmpty) {
                        if (result == 'delete') {
                          _contadorFinal = '';
                        } else {
                          _contadorFinal = result;
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
                    value: _cantidadCajas,
                    onPressed: () async {
                      String result = await Modal.addModal(
                          context: context, title: 'CAJAS COMPLETADAS');
                      if (result.isNotEmpty) {
                        if (result == 'delete') {
                          _cantidadCajas = '';
                        } else {
                          _cantidadCajas = result;
                        }
                        setState(() {});
                      }
                    },
                  ),
                  Expanded(child: Container()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: FinishButton(
                      text: 'FINALIZAR',
                      onPressed: () {
                        Utils.confirmAlert(context, 'Finalizar registro',
                            '¿Esta seguro que desea finalizar el registro de produccion?',
                            () {
                          Navigator.of(context).pop();

                          Utils.snackBarWarinig(
                              context,
                              'Configure una maquina',
                              'Desde la configuración puede seleccionar una maquina.');
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubTituloCard(BuildContext context, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                  _fallosMaquina.add(falloAdded);
                  setState(() {});
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
