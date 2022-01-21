import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtest/src/cubit/registro_detalle_cubit.dart';
import 'package:webtest/src/models/fallo_maquina_model.dart';

import 'package:webtest/src/models/registro_lista.dart';
import 'package:webtest/src/models/registro_produccion.dart';
import 'package:webtest/src/utils/registro_type.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/views/nuevo_registro/widgets/fallos_detail.dart';

import 'package:webtest/src/views/registro/registro.dart';
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
          return _LoadingRegistro();
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

class _Detalle extends StatelessWidget {
  const _Detalle({Key? key, required this.registro}) : super(key: key);

  final RegistroProduccion registro;

  @override
  Widget build(BuildContext context) {
    var _color = Colors.black54;
    if (registro.estado == RegistroType.CREADO) {
      _color = Theme.of(context).primaryColor;
    } else if (registro.estado == RegistroType.PROCESADO) {
      _color = Colors.green;
    } else if (registro.estado == RegistroType.ANULADO) {
      _color = Colors.red;
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${registro.fecha!} ${registro.hora!}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 3),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: _color),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                registro.estado!,
                style: TextStyle(
                  fontSize: 14,
                  color: _color,
                ),
              ),
            ),
          ),
          Row(
            children: [
              InfoContainer(
                label: 'PRODUCTO:',
                value: '${registro.codProducto!} - ${registro.producto!}',
              ),
            ],
          ),
          Row(
            children: [
              InfoContainer(
                label: 'MAQUINA:',
                value: registro.maquina!,
              ),
            ],
          ),
          Row(
            children: [
              InfoContainer(
                label: 'OPERARIO:',
                value: '${registro.legajoOperario!} - ${registro.operario!}',
              ),
            ],
          ),
          Row(
            children: [
              InfoContainer(
                label: 'CONTADOR INICIAL:',
                value: registro.contadorInicial!,
              ),
              InfoContainer(
                label: 'LOTE:',
                value: registro.lote!,
              ),
              InfoContainer(
                label: 'CONTADOR FINAL:',
                value: registro.contadorFinal!,
              ),
            ],
          ),
          Row(
            children: [
              InfoContainer.titulo(label: 'MATERIA PRIMA UTILIZADA', flex: 1),
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
                        left: 5,
                        right: 5,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InfoGrid.head(label: 'CRUCE', flex: 1),
                              InfoGrid.cell(label: registro.cruce_1!, flex: 1),
                              InfoGrid.cell(label: registro.cruce_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'RULO/PESTAÑA', flex: 1),
                              InfoGrid.cell(label: registro.rulo_1!, flex: 1),
                              InfoGrid.cell(label: registro.rulo_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PEGADO TRASERO', flex: 1),
                              InfoGrid.cell(
                                  label: registro.pegado_trasero_1!, flex: 1),
                              InfoGrid.cell(
                                  label: registro.pegado_trasero_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PEGADO DELANTERO', flex: 1),
                              InfoGrid.cell(
                                  label: registro.pegado_delantero_1!, flex: 1),
                              InfoGrid.cell(
                                  label: registro.pegado_delantero_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'CANTIDAD DE CONO', flex: 1),
                              InfoGrid.cell(
                                  label: registro.cant_cono_1!, flex: 1),
                              InfoGrid.cell(
                                  label: registro.cant_cono_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'GRAFICA', flex: 1),
                              InfoGrid.cell(
                                  label: registro.grafica_1!, flex: 1),
                              InfoGrid.cell(label: registro.grafica_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'TROQUELADO', flex: 1),
                              InfoGrid.cell(
                                  label: registro.troquelado_1!, flex: 1),
                              InfoGrid.cell(
                                  label: registro.troquelado_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(
                                  label: 'MATERIAS EXTRAÑAS', flex: 1),
                              InfoGrid.cell(
                                  label: registro.materias_1!, flex: 1),
                              InfoGrid.cell(
                                  label: registro.materias_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PPR3', flex: 1),
                              InfoGrid.cell(label: registro.ppr3_1!, flex: 1),
                              InfoGrid.cell(label: registro.ppr3_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PPR4', flex: 1),
                              InfoGrid.cell(label: registro.ppr4_1!, flex: 1),
                              InfoGrid.cell(label: registro.ppr4_2!, flex: 1)
                            ],
                          ),
                          Row(
                            children: [
                              InfoGrid.head(label: 'PPR6', flex: 1),
                              InfoGrid.cell(label: registro.ppr6_1!, flex: 1),
                              InfoGrid.cell(label: registro.ppr6_2!, flex: 1)
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
                                fallos: registro.fallosMaquina!),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          FallosDetail.hours(
                              context: context,
                              fallos: registro.fallosMaquina!),
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
                value: registro.cantidadCajas!,
              ),
              InfoContainer(
                label: 'CANTIDAD MODELS FABRICADOS:',
                value: registro.cantidadMoldes!,
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
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingSpinner(
            color: Theme.of(context).primaryColor,
            text: 'Buscando registro de produccion',
            height: 3,
          ),
        ],
      ),
    );
  }
}
