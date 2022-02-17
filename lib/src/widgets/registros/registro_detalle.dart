import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/registro_add_cubit.dart';

import 'package:webtest/src/cubit/registro_detalle_cubit.dart';

import 'package:webtest/src/models/registro_produccion.dart';
import 'package:webtest/src/models/respuesta.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/utils/utils.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/fallos_detail.dart';
import 'package:webtest/src/widgets/cancel_button.dart';

import 'package:webtest/src/widgets/loading.dart';
import 'package:webtest/src/widgets/registros/info_container.dart';
import 'package:webtest/src/widgets/registros/info_grid.dart';

class RegistrosDetalleView extends StatelessWidget {
  RegistrosDetalleView({required this.id});

  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<RegistroDetalleCubit>().PRO_registro(id);

    return BlocConsumer<RegistroDetalleCubit, RegistroDetalleState>(
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
          return _Detalle(registro: state.registro);
        } else {
          return _MessageSearch(
              mensaje: 'Algo salio mal obteniendo el registro de produccion.');
        }
      },
    );
  }
}

class _Detalle extends StatefulWidget {
  const _Detalle({Key? key, required this.registro}) : super(key: key);

  final RegistroProduccion registro;

  @override
  State<_Detalle> createState() => _DetalleState();
}

class _DetalleState extends State<_Detalle> {
  @override
  Widget build(BuildContext context) {
    var _color = Colors.black54;
    bool canEdit = false;
    if (widget.registro.estado == RegistroType.CREADO) {
      _color = Theme.of(context).primaryColor;
      canEdit = true;
    } else if (widget.registro.estado == RegistroType.PROCESADO) {
      _color = Colors.green;
    } else if (widget.registro.estado == RegistroType.ANULADO) {
      _color = Colors.red;
    }

    return Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 3,
                    right: 10,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: _color),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.registro.estado!,
                    style: TextStyle(
                      fontSize: 16,
                      color: _color,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${widget.registro.fecha!} ${widget.registro.hora!}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            actions: [
              if (canEdit)
                TextButton.icon(
                  onPressed: () {
                    Utils.confirmAlert(context, 'Procesar registro',
                        '¿Está seguro que desea PROCESAR el registro?',
                        () async {
                      Navigator.of(context).pop();
                      Respuesta res = await context
                          .read<RegistroAddCubit>()
                          .PRO_cambiarEstadoRegistro(
                              widget.registro.id!, RegistroType.PROCESADO);

                      if (res.error == 'S') {
                        Utils.snackBarWarinig(
                            context, 'Cambio de estado', res.mensaje!);
                      } else {
                        context
                            .read<RegistroDetalleCubit>()
                            .PRO_registro(widget.registro.id!);
                        setState(() {});
                      }
                    });
                  },
                  label: const Text(
                    'PROCESAR',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  icon: const Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                ),
              const SizedBox(width: 5),
              TextButton.icon(
                onPressed: () {
                  Utils.snackBar(context, 'En desarrollo');
                },
                label: const Text(
                  'IMPRIMIR',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                icon: const Icon(
                  Icons.print,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 5),
              if (canEdit)
                TextButton.icon(
                  onPressed: () {
                    Utils.confirmAlert(context, 'Anular registro',
                        '¿Está seguro que desea ANULAR el registro? ',
                        () async {
                      Navigator.of(context).pop();
                      Respuesta res = await context
                          .read<RegistroAddCubit>()
                          .PRO_cambiarEstadoRegistro(
                              widget.registro.id!, RegistroType.ANULADO);

                      if (res.error == 'S') {
                        Utils.snackBarWarinig(
                            context, 'Cambio de estado', res.mensaje!);
                      } else {
                        context
                            .read<RegistroDetalleCubit>()
                            .PRO_registro(widget.registro.id!);
                        setState(() {});
                      }
                    });
                  },
                  label: const Text(
                    'ANULAR',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              const SizedBox(width: 10),
            ],
          ),
          Row(
            children: [
              InfoContainer(
                label: 'OPERARIO:',
                value:
                    '${widget.registro.legajoOperario!} - ${widget.registro.operario!}',
              ),
            ],
          ),
          Row(
            children: [
              InfoContainer(
                label: 'MAQUINA:',
                value: widget.registro.maquina!,
              ),
              InfoContainer(
                label: 'PRODUCTO:',
                value:
                    '${widget.registro.codProducto!} - ${widget.registro.producto!}',
              ),
            ],
          ),
          Row(
            children: [
              InfoContainer(
                label: 'CONTADOR INICIAL:',
                value: widget.registro.contadorInicial!,
              ),
              InfoContainer(
                label: 'LOTE:',
                value: widget.registro.lote!,
              ),
              InfoContainer(
                label: 'CONTADOR FINAL:',
                value: widget.registro.contadorFinal!,
              ),
            ],
          ),
          Row(
            children: [
              InfoContainer.titulo(label: 'MATERIA PRIMA UTILIZADA', flex: 1),
            ],
          ),
          (widget.registro.maquina!.contains('BUDIN'))
              ? Column(
                  children: [
                    Row(
                      children: [
                        InfoContainer.adhesivoTitulo(
                            label: 'Adhesivo\ntrasero No:'),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoTrasero1!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoTrasero2!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoTrasero3!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoTrasero4!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoTrasero5!,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InfoContainer.adhesivoTitulo(
                            label: 'Adhesivo\ndelantero No:'),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoDelantero1!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoDelantero1!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoDelantero1!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoDelantero1!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoDelantero1!,
                        ),
                      ],
                    ),
                    // BOBINA PAPEL - BUDIN
                    Row(
                      children: [
                        InfoContainer.bobinaTitulo(label: 'Adhesivo\npapel:'),
                        InfoContainer.bobinaDetalle(
                          nro: '1',
                          value: (widget.registro.bobina1!.codproducto == null)
                              ? ' '
                              : widget.registro.bobina1!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '2',
                          value: (widget.registro.bobina2!.codproducto == null)
                              ? ' '
                              : widget.registro.bobina2!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '3',
                          value: (widget.registro.bobina3!.codproducto == null)
                              ? ' '
                              : widget.registro.bobina3!.nombre!,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InfoContainer.bobinaTitulo(label: ''),
                        InfoContainer.bobinaDetalle(
                          nro: '4',
                          value: (widget.registro.bobina4!.codproducto == null)
                              ? ' '
                              : widget.registro.bobina4!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '5',
                          value: (widget.registro.bobina5!.codproducto == null)
                              ? ' '
                              : widget.registro.bobina5!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '6',
                          value: (widget.registro.bobina6!.codproducto == null)
                              ? ' '
                              : widget.registro.bobina6!.nombre!,
                        ),
                      ],
                    ),
                    // END BOBINA PAPEL - BUDIN
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        InfoContainer.adhesivoTitulo(
                            label: 'Adhesivo fondo No:'),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoFondo1!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoFondo2!,
                        ),
                        InfoContainer.adhesivoTitulo(
                            label: 'Adhesivo Corrugado No:'),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoCorrugado!,
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        InfoContainer.adhesivoTitulo(
                            label: 'Adhesivo lateral No:'),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoLateral1!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoLateral2!,
                        ),
                        InfoContainer.adhesivoTitulo(label: 'Desmoldante No:'),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.desmoldante!,
                        ),
                      ],
                    ),

                    // BOBINA FONDO - DULCE BISCOCHO
                    Row(
                      children: [
                        InfoContainer.bobinaTitulo(label: 'Adhesivo\nfondo:'),
                        InfoContainer.bobinaDetalle(
                          nro: '1',
                          value: (widget.registro.bobinaFondo1!.codproducto ==
                                  null)
                              ? ' '
                              : widget.registro.bobinaFondo1!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '2',
                          value: (widget.registro.bobinaFondo2!.codproducto ==
                                  null)
                              ? ' '
                              : widget.registro.bobinaFondo2!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '3',
                          value: (widget.registro.bobinaFondo3!.codproducto ==
                                  null)
                              ? ' '
                              : widget.registro.bobinaFondo3!.nombre!,
                        ),
                      ],
                    ),
                    // END BOBINA FONDO - DULCE BISCOCHO

                    // BOBINA LATERAL - DULCE BISCOCHO
                    Row(
                      children: [
                        InfoContainer.bobinaTitulo(label: 'Adhesivo\nlateral:'),
                        InfoContainer.bobinaDetalle(
                          nro: '1',
                          value: (widget.registro.bobinaLateral1!.codproducto ==
                                  null)
                              ? ' '
                              : widget.registro.bobinaLateral1!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '2',
                          value: (widget.registro.bobinaLateral2!.codproducto ==
                                  null)
                              ? ' '
                              : widget.registro.bobinaLateral2!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '3',
                          value: (widget.registro.bobinaLateral3!.codproducto ==
                                  null)
                              ? ' '
                              : widget.registro.bobinaLateral3!.nombre!,
                        ),
                      ],
                    ),
                    // END BOBINA LATERAL - DULCE BISCOCHO

                    // BOBINA CONO - DULCE BISCOCHO
                    Row(
                      children: [
                        InfoContainer.bobinaTitulo(label: 'Adhesivo\ncono:'),
                        InfoContainer.bobinaDetalle(
                          nro: '1',
                          value:
                              (widget.registro.bobinaCono1!.codproducto == null)
                                  ? ' '
                                  : widget.registro.bobinaCono1!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '2',
                          value:
                              (widget.registro.bobinaCono2!.codproducto == null)
                                  ? ' '
                                  : widget.registro.bobinaCono2!.nombre!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '3',
                          value:
                              (widget.registro.bobinaCono3!.codproducto == null)
                                  ? ' '
                                  : widget.registro.bobinaCono3!.nombre!,
                        ),
                      ],
                    ),
                    // END BOBINA CONO - DULCE BISCOCHO
                  ],
                ),
          Row(
            children: [
              InfoContainer.titulo(label: 'CONTROLES', flex: 3),
              InfoContainer.titulo(label: 'FALLOS DE LA MAQUINA', flex: 5),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 1,
                        right: 1,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InfoGrid.head(label: 'CRUCE', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.cruce_1!, flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.cruce_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'RULO/PESTAÑA', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.rulo_1!, flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.rulo_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PEGADO TRASERO', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.pegado_trasero_1!,
                                  flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.pegado_trasero_2!,
                                  flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PEGADO DELANTERO', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.pegado_delantero_1!,
                                  flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.pegado_delantero_2!,
                                  flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'CANTIDAD DE CONO', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.cant_cono_1!, flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.cant_cono_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'GRAFICA', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.grafica_1!, flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.grafica_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'TROQUELADO', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.troquelado_1!,
                                  flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.troquelado_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(
                                  label: 'MATERIAS EXTRAÑAS', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.materias_1!, flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.materias_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PPR3', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.ppr3_1!, flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.ppr3_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PPR4', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.ppr4_1!, flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.ppr4_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PPR6', flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.ppr6_1!, flex: 1),
                              InfoGrid.cell(
                                  label: widget.registro.ppr6_2!, flex: 1)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FallosDetail.header(context),
                            FallosDetail.list(
                                context: context,
                                fallos: widget.registro.fallosMaquina!),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          FallosDetail.hours(
                              context: context,
                              fallos: widget.registro.fallosMaquina!),
                          SizedBox(width: 5),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          Row(
            children: [
              InfoContainer(
                label: 'CANTIDAD CAJAS FABRICADAS:',
                value: widget.registro.cantidadCajas!,
              ),
              InfoContainer(
                label: 'CANTIDAD MODELS FABRICADOS:',
                value: widget.registro.cantidadMoldes!,
              ),
            ],
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
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          child: Text(
            mensaje!,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
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
