import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/operario_cubit.dart';
import 'package:webtest/src/cubit/registro_add_cubit.dart';

import 'package:webtest/src/cubit/registro_detalle_cubit.dart';
import 'package:webtest/src/models/bobina.dart';

import 'package:webtest/src/models/registro_produccion.dart';
import 'package:webtest/src/models/respuesta.dart';
import 'package:webtest/src/models/supervisor.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/utils/modal.dart';
import 'package:webtest/src/utils/utils.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/fallos_detail.dart';
import 'package:webtest/src/views/registro/print_registro.dart';
import 'package:webtest/src/widgets/accept_button.dart';
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
          return const _MessageSearch(
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
  String _claveSuper = '';

  final _formKeySupervisor = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // widget.registro.bobina1 ??= Bobina.init();
    // widget.registro.bobina2 ??= Bobina.init();
    // widget.registro.bobina3 ??= Bobina.init();
    // widget.registro.bobina4 ??= Bobina.init();
    // widget.registro.bobina5 ??= Bobina.init();
    // widget.registro.bobina6 ??= Bobina.init();

    // widget.registro.bobinaCono1 ??= Bobina.init();
    // widget.registro.bobinaCono2 ??= Bobina.init();
    // widget.registro.bobinaCono3 ??= Bobina.init();

    // widget.registro.bobinaFondo1 ??= Bobina.init();
    // widget.registro.bobinaFondo2 ??= Bobina.init();
    // widget.registro.bobinaFondo3 ??= Bobina.init();

    // widget.registro.bobinaLateral1 ??= Bobina.init();
    // widget.registro.bobinaLateral2 ??= Bobina.init();
    // widget.registro.bobinaLateral3 ??= Bobina.init();

    String? _t = widget.registro.turno;
    String? _turno = '';

    if (_t != null) {
      _turno = _t;
    } else {
      _turno = '';
    }

    var _color = Colors.black54;
    bool canEdit = false;
    if (widget.registro.estado == RegistroType.CREADO) {
      _color = Colors.blue;
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
                    color: _color,
                    border: Border.all(color: _color),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.registro.estado!,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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
                  onPressed: () async {
                    String result = await Modal.password(
                        context: context,
                        title: 'PROCESAR: INGRESE CLAVE SUPERVISOR ');
                    if (result.isNotEmpty) {
                      if (result == 'delete') {
                        _claveSuper = '';
                      } else {
                        _claveSuper = result;

                        Supervisor operario = await context
                            .read<OperarioCubit>()
                            .PRO_supervisor(_claveSuper);

                        if (operario.claveacceso! == _claveSuper &&
                            operario.nombre!.contains('-PR')) {
                          Respuesta res = await context
                              .read<RegistroAddCubit>()
                              .PRO_procesarRegistro(
                                  widget.registro.id!, operario.quien!);

                          if (res.error == 'S') {
                            Utils.snackBarWarinig(context,
                                'Cambio de estado: Procesar', res.mensaje!);
                          } else {
                            context
                                .read<RegistroDetalleCubit>()
                                .PRO_registro(widget.registro.id!);
                            setState(() {});
                          }
                        } else {
                          Utils.snackBar(
                              context, 'No se encontro el supervisor');
                        }
                      }
                    }

                    // Utils.confirmAlert(context, 'Procesar registro',
                    //     '¿Está seguro que desea PROCESAR el registro?',
                    //     () async {
                    //   Navigator.of(context).pop();
                    //   Respuesta res = await context
                    //       .read<RegistroAddCubit>()
                    //       .PRO_cambiarEstadoRegistro(
                    //           widget.registro.id!, RegistroType.PROCESADO);

                    //   if (res.error == 'S') {
                    //     Utils.snackBarWarinig(
                    //         context, 'Cambio de estado', res.mensaje!);
                    //   } else {
                    //     context
                    //         .read<RegistroDetalleCubit>()
                    //         .PRO_registro(widget.registro.id!);
                    //     setState(() {});
                    //   }
                    // });
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
                  Navigator.pushNamed(context, PrintRegistro.routeName,
                      arguments: widget.registro.id);
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
                  onPressed: () async {
                    String result = await Modal.password(
                        context: context, title: 'INGRESE CLAVE SUPERVISOR ');
                    if (result.isNotEmpty) {
                      if (result == 'delete') {
                        _claveSuper = '';
                      } else {
                        _claveSuper = result;

                        Supervisor operario = await context
                            .read<OperarioCubit>()
                            .PRO_supervisor(_claveSuper);

                        if (operario.claveacceso! == _claveSuper) {
                          Respuesta res = await context
                              .read<RegistroAddCubit>()
                              .PRO_cambiarEstadoRegistro(widget.registro.id!,
                                  RegistroType.ANULADO, operario.quien!);

                          if (res.error == 'S') {
                            Utils.snackBarWarinig(
                                context, 'Cambio de estado', res.mensaje!);
                          } else {
                            context
                                .read<RegistroDetalleCubit>()
                                .PRO_registro(widget.registro.id!);
                            setState(() {});
                          }
                        } else {
                          Utils.snackBar(
                              context, 'No se encontro el supervisor');
                        }
                      }
                    }
                    // Utils.confirmAlert(context, 'Anular registro',
                    //     '¿Está seguro que desea ANULAR el registro? ',
                    //     () async {
                    //   Navigator.of(context).pop();
                    //   Respuesta res = await context
                    //       .read<RegistroAddCubit>()
                    //       .PRO_cambiarEstadoRegistro(
                    //           widget.registro.id!, RegistroType.ANULADO);
                    //   if (res.error == 'S') {
                    //     Utils.snackBarWarinig(
                    //         context, 'Cambio de estado', res.mensaje!);
                    //   } else {
                    //     context
                    //         .read<RegistroDetalleCubit>()
                    //         .PRO_registro(widget.registro.id!);
                    //     setState(() {});
                    //   }
                    // });
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
              InfoContainer(
                label: 'TURNO:',
                value: '$_turno',
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
                          value: widget.registro.adhesivoDelantero2!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoDelantero3!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoDelantero4!,
                        ),
                        InfoContainer.adhesivoDetalle(
                          value: widget.registro.adhesivoDelantero5!,
                        ),
                      ],
                    ),
                    // BOBINA PAPEL - BUDIN
                    Row(
                      children: [
                        InfoContainer.bobinaTitulo(label: 'Bobina\npapel:'),
                        InfoContainer.bobinaDetalle(
                          nro: '1',
                          value: (widget.registro.bobina1 == null ||
                                  widget.registro.bobina1!.nroSerie == null)
                              ? ' '
                              : widget.registro.bobina1!.nroSerie!,
                          checked: widget.registro.bobina1!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '2',
                          value: (widget.registro.bobina2 == null ||
                                  widget.registro.bobina2!.nroSerie == null)
                              ? ' '
                              : widget.registro.bobina2!.nroSerie!,
                          checked: widget.registro.bobina2!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '3',
                          value: (widget.registro.bobina3 == null ||
                                  widget.registro.bobina3!.nroSerie == null)
                              ? ' '
                              : widget.registro.bobina3!.nroSerie!,
                          checked: (widget.registro.bobina3 == null ||
                                  widget.registro.bobina3!.checked == null)
                              ? false
                              : widget.registro.bobina3!.checked!,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InfoContainer.bobinaTitulo(label: ''),
                        InfoContainer.bobinaDetalle(
                          nro: '4',
                          value: (widget.registro.bobina4 == null ||
                                  widget.registro.bobina4!.nroSerie == null)
                              ? ' '
                              : widget.registro.bobina4!.nroSerie!,
                          checked: (widget.registro.bobina4 == null ||
                                  widget.registro.bobina4!.checked == null)
                              ? false
                              : widget.registro.bobina4!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '5',
                          value: (widget.registro.bobina5 == null ||
                                  widget.registro.bobina5!.nroSerie == null)
                              ? ' '
                              : widget.registro.bobina5!.nroSerie!,
                          checked: (widget.registro.bobina5 == null ||
                                  widget.registro.bobina5!.checked == null)
                              ? false
                              : widget.registro.bobina5!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '6',
                          value: (widget.registro.bobina6 == null ||
                                  widget.registro.bobina6!.nroSerie == null)
                              ? ' '
                              : widget.registro.bobina6!.nroSerie!,
                          checked: (widget.registro.bobina6 == null ||
                                  widget.registro.bobina6!.checked == null)
                              ? false
                              : widget.registro.bobina6!.checked!,
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
                        InfoContainer.bobinaTitulo(label: 'Bobina\nfondo:'),
                        InfoContainer.bobinaDetalle(
                          nro: '1',
                          value: (widget.registro.bobinaFondo1 == null ||
                                  widget.registro.bobinaFondo1!.nroSerie ==
                                      null)
                              ? ' '
                              : widget.registro.bobinaFondo1!.nroSerie!,
                          checked: (widget.registro.bobinaFondo1 == null ||
                                  widget.registro.bobinaFondo1!.checked == null)
                              ? false
                              : widget.registro.bobinaFondo1!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '2',
                          value: (widget.registro.bobinaFondo2 == null ||
                                  widget.registro.bobinaFondo2!.nroSerie ==
                                      null)
                              ? ' '
                              : widget.registro.bobinaFondo2!.nroSerie!,
                          checked: (widget.registro.bobinaFondo2 == null ||
                                  widget.registro.bobinaFondo2!.checked == null)
                              ? false
                              : widget.registro.bobinaFondo2!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '3',
                          value: (widget.registro.bobinaFondo3 == null ||
                                  widget.registro.bobinaFondo3!.nroSerie ==
                                      null)
                              ? ' '
                              : widget.registro.bobinaFondo3!.nroSerie!,
                          checked: (widget.registro.bobinaFondo3 == null ||
                                  widget.registro.bobinaFondo3!.checked == null)
                              ? false
                              : widget.registro.bobinaFondo3!.checked!,
                        ),
                      ],
                    ),
                    // END BOBINA FONDO - DULCE BISCOCHO

                    // BOBINA LATERAL - DULCE BISCOCHO
                    Row(
                      children: [
                        InfoContainer.bobinaTitulo(label: 'Bobina\nlateral:'),
                        InfoContainer.bobinaDetalle(
                          nro: '1',
                          value: (widget.registro.bobinaLateral1 == null ||
                                  widget.registro.bobinaLateral1!.nroSerie ==
                                      null)
                              ? ' '
                              : widget.registro.bobinaLateral1!.nroSerie!,
                          checked: (widget.registro.bobinaLateral1 == null ||
                                  widget.registro.bobinaLateral1!.checked ==
                                      null)
                              ? false
                              : widget.registro.bobinaLateral1!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '2',
                          value: (widget.registro.bobinaLateral2 == null ||
                                  widget.registro.bobinaLateral2!.nroSerie ==
                                      null)
                              ? ' '
                              : widget.registro.bobinaLateral2!.nroSerie!,
                          checked: (widget.registro.bobinaLateral2 == null ||
                                  widget.registro.bobinaLateral2!.checked ==
                                      null)
                              ? false
                              : widget.registro.bobinaLateral2!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '3',
                          value: (widget.registro.bobinaLateral3 == null ||
                                  widget.registro.bobinaLateral3!.nroSerie ==
                                      null)
                              ? ' '
                              : widget.registro.bobinaLateral3!.nroSerie!,
                          checked: (widget.registro.bobinaLateral3 == null ||
                                  widget.registro.bobinaLateral3!.checked ==
                                      null)
                              ? false
                              : widget.registro.bobinaLateral3!.checked!,
                        ),
                      ],
                    ),
                    // END BOBINA LATERAL - DULCE BISCOCHO

                    // BOBINA CONO - DULCE BISCOCHO
                    Row(
                      children: [
                        InfoContainer.bobinaTitulo(label: 'Bobina\ncono:'),
                        InfoContainer.bobinaDetalle(
                          nro: '1',
                          value: (widget.registro.bobinaCono1 == null ||
                                  widget.registro.bobinaCono1!.nroSerie == null)
                              ? ' '
                              : widget.registro.bobinaCono1!.nroSerie!,
                          checked: (widget.registro.bobinaCono1 == null ||
                                  widget.registro.bobinaCono1!.checked == null)
                              ? false
                              : widget.registro.bobinaCono1!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '2',
                          value: (widget.registro.bobinaCono2 == null ||
                                  widget.registro.bobinaCono2!.nroSerie == null)
                              ? ' '
                              : widget.registro.bobinaCono2!.nroSerie!,
                          checked: (widget.registro.bobinaCono2 == null ||
                                  widget.registro.bobinaCono2!.checked == null)
                              ? false
                              : widget.registro.bobinaCono2!.checked!,
                        ),
                        InfoContainer.bobinaDetalle(
                          nro: '3',
                          value: (widget.registro.bobinaCono3 == null ||
                                  widget.registro.bobinaCono3!.nroSerie == null)
                              ? ' '
                              : widget.registro.bobinaCono3!.nroSerie!,
                          checked: (widget.registro.bobinaCono3 == null ||
                                  widget.registro.bobinaCono3!.checked == null)
                              ? false
                              : widget.registro.bobinaCono3!.checked!,
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
                      child: (widget.registro.maquina!.contains('BUDIN'))
                          ? _controlesBUDIN()
                          : _controlesNOBUDIN(),
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

  Column _controlesBUDIN() {
    return Column(
      children: [
        Row(
          children: [
            InfoGrid.head(label: 'CRUCE', flex: 5),
            InfoGrid.cell(label: widget.registro.cruce_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.cruce_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'RULO/PESTAÑA', flex: 5),
            InfoGrid.cell(label: widget.registro.rulo_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.rulo_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'PEGADO TRASERO', flex: 5),
            InfoGrid.cell(label: widget.registro.pegado_trasero_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.pegado_trasero_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'PEGADO DELANTERO', flex: 5),
            InfoGrid.cell(label: widget.registro.pegado_delantero_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.pegado_delantero_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'CANTIDAD DE CONO', flex: 5),
            InfoGrid.cell(label: widget.registro.cant_cono_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.cant_cono_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'GRAFICA', flex: 5),
            InfoGrid.cell(label: widget.registro.grafica_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.grafica_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'TROQUELADO', flex: 5),
            InfoGrid.cell(label: widget.registro.troquelado_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.troquelado_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'MATERIAS EXTRAÑAS', flex: 5),
            InfoGrid.cell(label: widget.registro.materias_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.materias_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'PPR3', flex: 5),
            InfoGrid.cell(label: widget.registro.ppr3_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.ppr3_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'PPR4', flex: 5),
            InfoGrid.cell(label: widget.registro.ppr4_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.ppr4_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'PPR6', flex: 5),
            InfoGrid.cell(label: widget.registro.ppr6_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.ppr6_2!, flex: 2)
          ],
        ),
      ],
    );
  }

  Column _controlesNOBUDIN() {
    return Column(
      children: [
        Row(
          children: [
            InfoGrid.head(label: 'ALTURA', flex: 5),
            InfoGrid.cell(label: widget.registro.altura_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.altura_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'TERMINACIÓN SUPERIOR', flex: 5),
            InfoGrid.cell(
                label: widget.registro.terminacion_superior_1!, flex: 2),
            InfoGrid.cell(
                label: widget.registro.terminacion_superior_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'CRUCE', flex: 5),
            InfoGrid.cell(label: widget.registro.cruce_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.cruce_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'PEGADO', flex: 5),
            InfoGrid.cell(label: widget.registro.pegado_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.pegado_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'CANTIDAD DE CONO', flex: 5),
            InfoGrid.cell(label: widget.registro.cant_cono_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.cant_cono_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'GRAFICA', flex: 5),
            InfoGrid.cell(label: widget.registro.grafica_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.grafica_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'MICROPERFORADO', flex: 5),
            InfoGrid.cell(label: widget.registro.microperforado_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.microperforado_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'MATERIAS EXTRAÑAS', flex: 5),
            InfoGrid.cell(label: widget.registro.materias_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.materias_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'PPR3', flex: 5),
            InfoGrid.cell(label: widget.registro.ppr3_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.ppr3_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'PPR4', flex: 5),
            InfoGrid.cell(label: widget.registro.ppr4_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.ppr4_2!, flex: 2)
          ],
        ),
        Row(
          children: [
            InfoGrid.head(label: 'PPR6', flex: 5),
            InfoGrid.cell(label: widget.registro.ppr6_1!, flex: 2),
            InfoGrid.cell(label: widget.registro.ppr6_2!, flex: 2)
          ],
        ),
      ],
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
          color: Colors.blue,
          text: 'Buscando registro de produccion',
          height: 3,
        ),
      ],
    );
  }
}
