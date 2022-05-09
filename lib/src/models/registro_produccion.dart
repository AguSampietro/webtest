import 'dart:convert';

import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/models/producto.dart';
import 'package:webtest/src/models/fallo_maquina_model.dart';

RegistroProduccion registroProFromJson(String str) =>
    RegistroProduccion.fromJson(json.decode(str));

class RegistroProduccion {
  RegistroProduccion({
    this.id,
    this.producto,
    this.maquina,
    this.deposito,
    this.depositoNombre,
    this.operario,
    this.fecha,
    this.hora,
    this.estado,
    this.codProducto,
    this.idMaquina,
    this.legajoOperario,
    this.contadorInicial,
    this.lote,
    this.contadorFinal,
    this.cantidadMoldes,
    this.cantidadCajas,
    this.adhesivoTrasero1,
    this.adhesivoTrasero2,
    this.adhesivoTrasero3,
    this.adhesivoTrasero4,
    this.adhesivoTrasero5,
    this.adhesivoFondo1,
    this.adhesivoFondo2,
    this.adhesivoLateral1,
    this.adhesivoLateral2,
    this.adhesivoCorrugado,
    this.desmoldante,
    this.adhesivoDelantero1,
    this.adhesivoDelantero2,
    this.adhesivoDelantero3,
    this.adhesivoDelantero4,
    this.adhesivoDelantero5,
    this.bobina1,
    this.bobina2,
    this.bobina3,
    this.bobina4,
    this.bobina5,
    this.bobina6,
    this.bobinaFondo1,
    this.bobinaFondo2,
    this.bobinaFondo3,
    this.bobinaLateral1,
    this.bobinaLateral2,
    this.bobinaLateral3,
    this.bobinaCono1,
    this.bobinaCono2,
    this.bobinaCono3,
    this.cruce_1,
    this.cruce_2,
    this.rulo_1,
    this.rulo_2,
    this.pegado_trasero_1,
    this.pegado_trasero_2,
    this.pegado_delantero_1,
    this.pegado_delantero_2,
    this.cant_cono_1,
    this.cant_cono_2,
    this.grafica_1,
    this.grafica_2,
    this.troquelado_1,
    this.troquelado_2,
    this.materias_1,
    this.materias_2,
    this.ppr3_1,
    this.ppr3_2,
    this.ppr4_1,
    this.ppr4_2,
    this.ppr6_1,
    this.ppr6_2,
    this.fallosMaquina,
  });

  String? id = '';
  String? producto = '';
  String? maquina = '';
  String? deposito = '';
  String? depositoNombre = '';
  String? operario = '';
  String? fecha = '';
  String? hora = '';
  String? estado = '';

  String? codProducto = '';
  String? idMaquina = '';
  String? legajoOperario = '';
  String? contadorInicial = '';
  String? lote = '';
  String? contadorFinal = '';
  String? cantidadMoldes = '';
  String? cantidadCajas = '';

  String? adhesivoTrasero1 = '';
  String? adhesivoTrasero2 = '';
  String? adhesivoTrasero3 = '';
  String? adhesivoTrasero4 = '';
  String? adhesivoTrasero5 = '';

  String? adhesivoFondo1 = '';
  String? adhesivoFondo2 = '';

  String? adhesivoLateral1 = '';
  String? adhesivoLateral2 = '';

  String? adhesivoCorrugado = '';
  String? desmoldante = '';

  String? adhesivoDelantero1 = '';
  String? adhesivoDelantero2 = '';
  String? adhesivoDelantero3 = '';
  String? adhesivoDelantero4 = '';
  String? adhesivoDelantero5 = '';

  Bobina? bobina1 = Bobina.init();
  Bobina? bobina2 = Bobina.init();
  Bobina? bobina3 = Bobina.init();
  Bobina? bobina4 = Bobina.init();
  Bobina? bobina5 = Bobina.init();
  Bobina? bobina6 = Bobina.init();

  Bobina? bobinaFondo1 = Bobina.init();
  Bobina? bobinaFondo2 = Bobina.init();
  Bobina? bobinaFondo3 = Bobina.init();

  Bobina? bobinaLateral1 = Bobina.init();
  Bobina? bobinaLateral2 = Bobina.init();
  Bobina? bobinaLateral3 = Bobina.init();

  Bobina? bobinaCono1 = Bobina.init();
  Bobina? bobinaCono2 = Bobina.init();
  Bobina? bobinaCono3 = Bobina.init();

  String? cruce_1 = '';
  String? cruce_2 = '';

  String? rulo_1 = '';
  String? rulo_2 = '';

  String? pegado_trasero_1 = '';
  String? pegado_trasero_2 = '';

  String? pegado_delantero_1 = '';
  String? pegado_delantero_2 = '';

  String? cant_cono_1 = '';
  String? cant_cono_2 = '';

  String? grafica_1 = '';
  String? grafica_2 = '';

  String? troquelado_1 = '';
  String? troquelado_2 = '';

  String? materias_1 = '';
  String? materias_2 = '';

  String? ppr3_1 = '';
  String? ppr3_2 = '';

  String? ppr4_1 = '';
  String? ppr4_2 = '';

  String? ppr6_1 = '';
  String? ppr6_2 = '';

  List<FalloMaquina>? fallosMaquina = [];

  factory RegistroProduccion.init() => RegistroProduccion(
        contadorInicial: '',
        lote: '',
        contadorFinal: '',
        cantidadMoldes: '',
        cantidadCajas: '',
        adhesivoTrasero1: '',
        adhesivoTrasero2: '',
        adhesivoTrasero3: '',
        adhesivoTrasero4: '',
        adhesivoTrasero5: '',
        adhesivoFondo1: '',
        adhesivoFondo2: '',
        adhesivoLateral1: '',
        adhesivoLateral2: '',
        adhesivoCorrugado: '',
        desmoldante: '',
        adhesivoDelantero1: '',
        adhesivoDelantero2: '',
        adhesivoDelantero3: '',
        adhesivoDelantero4: '',
        adhesivoDelantero5: '',
        bobina1: Bobina.init(),
        bobina2: Bobina.init(),
        bobina3: Bobina.init(),
        bobina4: Bobina.init(),
        bobina5: Bobina.init(),
        bobina6: Bobina.init(),
        bobinaFondo1: Bobina.init(),
        bobinaFondo2: Bobina.init(),
        bobinaFondo3: Bobina.init(),
        bobinaLateral1: Bobina.init(),
        bobinaLateral2: Bobina.init(),
        bobinaLateral3: Bobina.init(),
        bobinaCono1: Bobina.init(),
        bobinaCono2: Bobina.init(),
        bobinaCono3: Bobina.init(),
        cruce_1: '',
        cruce_2: '',
        rulo_1: '',
        rulo_2: '',
        pegado_trasero_1: '',
        pegado_trasero_2: '',
        pegado_delantero_1: '',
        pegado_delantero_2: '',
        cant_cono_1: '',
        cant_cono_2: '',
        grafica_1: '',
        grafica_2: '',
        troquelado_1: '',
        troquelado_2: '',
        materias_1: '',
        materias_2: '',
        ppr3_1: '',
        ppr3_2: '',
        ppr4_1: '',
        ppr4_2: '',
        ppr6_1: '',
        ppr6_2: '',
        fallosMaquina: [],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "COD_PRODUCTO": codProducto,
        "ID_MAQUINA": idMaquina,
        "DEPOSITO": deposito,
        "LEGAJO_OPERARIO": legajoOperario,
        "CONTADOR_INICIAL": contadorInicial,
        "LOTE": lote,
        "CONTADOR_FINAL": contadorFinal,
        "CANTIDAD_MOLDES": cantidadMoldes,
        "CANTIDAD_CAJAS": cantidadCajas,
        "ADHESIVO_TRASERO1": adhesivoTrasero1,
        "ADHESIVO_TRASERO2": adhesivoTrasero2,
        "ADHESIVO_TRASERO3": adhesivoTrasero3,
        "ADHESIVO_TRASERO4": adhesivoTrasero4,
        "ADHESIVO_TRASERO5": adhesivoTrasero5,
        "ADHESIVO_FONDO1": adhesivoFondo1,
        "ADHESIVO_FONDO2": adhesivoFondo2,
        "ADHESIVO_LATERAL1": adhesivoLateral1,
        "ADHESIVO_LATERAL2": adhesivoLateral2,
        "ADHESIVO_CORRUGADO": adhesivoCorrugado,
        "DESMOLDANTE": desmoldante,
        "ADHESIVO_DELANTERO1": adhesivoDelantero1,
        "ADHESIVO_DELANTERO2": adhesivoDelantero2,
        "ADHESIVO_DELANTERO3": adhesivoDelantero3,
        "ADHESIVO_DELANTERO4": adhesivoDelantero4,
        "ADHESIVO_DELANTERO5": adhesivoDelantero5,
        "BOBINA1": bobinaMapToJson(bobina1!),
        "BOBINA2": bobinaMapToJson(bobina2!),
        "BOBINA3": bobinaMapToJson(bobina3!),
        "BOBINA4": bobinaMapToJson(bobina4!),
        "BOBINA5": bobinaMapToJson(bobina5!),
        "BOBINA6": bobinaMapToJson(bobina6!),
        "BOBINA_FONDO1": bobinaMapToJson(bobinaFondo1!),
        "BOBINA_FONDO2": bobinaMapToJson(bobinaFondo2!),
        "BOBINA_FONDO3": bobinaMapToJson(bobinaFondo3!),
        "BOBINA_LATERAL1": bobinaMapToJson(bobinaLateral1!),
        "BOBINA_LATERAL2": bobinaMapToJson(bobinaLateral2!),
        "BOBINA_LATERAL3": bobinaMapToJson(bobinaLateral3!),
        "BOBINA_CONO1": bobinaMapToJson(bobinaCono1!),
        "BOBINA_CONO2": bobinaMapToJson(bobinaCono2!),
        "BOBINA_CONO3": bobinaMapToJson(bobinaCono3!),
        "CRUCE1": cruce_1,
        "CRUCE2": cruce_2,
        "RULO1": rulo_1,
        "RULO2": rulo_2,
        "PEGADO_TRASERO1": pegado_trasero_1,
        "PEGADO_TRASERO2": pegado_trasero_2,
        "PEGADO_DELANTERO1": pegado_delantero_1,
        "PEGADO_DELANTERO2": pegado_delantero_2,
        "CANT_CONO1": cant_cono_1,
        "CANT_CONO2": cant_cono_2,
        "GRAFICA1": grafica_1,
        "GRAFICA2": grafica_2,
        "TROQUELADO1": troquelado_1,
        "TROQUELADO2": troquelado_2,
        "MATERIAS1": materias_1,
        "MATERIAS2": materias_2,
        "PPR3_1": ppr3_1,
        "PPR3_2": ppr3_2,
        "PPR4_1": ppr4_1,
        "PPR4_2": ppr4_2,
        "PPR6_1": ppr6_1,
        "PPR6_2": ppr6_2,
        "FALLOS_MAQUINA": fallosMaquinasMapToJson(fallosMaquina!),
      };

  bool isReady() {
    return lote!.isNotEmpty &&
        codProducto!.isNotEmpty &&
        idMaquina!.isNotEmpty &&
        legajoOperario!.isNotEmpty &&
        // contadorInicial!.isNotEmpty &&
        // contadorFinal!.isNotEmpty &&
        cantidadMoldes!.isNotEmpty &&
        cantidadCajas!.isNotEmpty;
  }

  factory RegistroProduccion.fromJson(Map<String, dynamic> json) =>
      RegistroProduccion(
        id: json["ID"],
        codProducto: json["COD_PRODUCTO"],
        producto: json["PRODUCTO"],
        idMaquina: json["ID_MAQUINA"],
        maquina: json["MAQUINA"],
        deposito: json["DEPOSITO"],
        depositoNombre: json["DEPOSITO_NOMBRE"],
        legajoOperario: json["LEGAJO_OPERARIO"],
        operario: json["OPERARIO"],
        contadorInicial: json["CONTADOR_INICIAL"],
        lote: json["LOTE"],
        contadorFinal: json["CONTADOR_FINAL"],
        cantidadMoldes: json["CANTIDAD_MOLDES"],
        cantidadCajas: json["CANTIDAD_CAJAS"],
        adhesivoTrasero1: json["ADHESIVO_TRASERO1"],
        adhesivoTrasero2: json["ADHESIVO_TRASERO2"],
        adhesivoTrasero3: json["ADHESIVO_TRASERO3"],
        adhesivoTrasero4: json["ADHESIVO_TRASERO4"],
        adhesivoTrasero5: json["ADHESIVO_TRASERO5"],
        adhesivoFondo1: json["ADHESIVO_FONDO1"],
        adhesivoFondo2: json["ADHESIVO_FONDO2"],
        adhesivoLateral1: json["ADHESIVO_LATERAL1"],
        adhesivoLateral2: json["ADHESIVO_LATERAL2"],
        adhesivoCorrugado: json["ADHESIVO_CORRUGADO"],
        desmoldante: json["DESMOLDANTE"],
        adhesivoDelantero1: json["ADHESIVO_DELANTERO1"],
        adhesivoDelantero2: json["ADHESIVO_DELANTERO2"],
        adhesivoDelantero3: json["ADHESIVO_DELANTERO3"],
        adhesivoDelantero4: json["ADHESIVO_DELANTERO4"],
        adhesivoDelantero5: json["ADHESIVO_DELANTERO5"],
        bobina1: json["BOBINA1"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA1"]),
        bobina2: json["BOBINA2"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA2"]),
        bobina3: json["BOBINA3"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA3"]),
        bobina4: json["BOBINA4"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA4"]),
        bobina5: json["BOBINA5"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA5"]),
        bobina6: json["BOBINA6"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA6"]),
        bobinaFondo1: json["BOBINA_FONDO1"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA_FONDO1"]),
        bobinaFondo2: json["BOBINA_FONDO2"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA_FONDO2"]),
        bobinaFondo3: json["BOBINA_FONDO3"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA_FONDO3"]),
        bobinaLateral1: json["BOBINA_LATERAL1"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA_LATERAL1"]),
        bobinaLateral2: json["BOBINA_LATERAL2"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA_LATERAL2"]),
        bobinaLateral3: json["BOBINA_LATERAL3"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA_LATERAL3"]),
        bobinaCono1: json["BOBINA_CONO1"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA_CONO1"]),
        bobinaCono2: json["BOBINA_CONO2"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA_CONO2"]),
        bobinaCono3: json["BOBINA_CONO3"] == null
            ? Bobina()
            : Bobina.fromJson(json["BOBINA_CONO3"]),
        cruce_1: json["CRUCE1"],
        cruce_2: json["CRUCE2"],
        rulo_1: json["RULO1"],
        rulo_2: json["RULO2"],
        pegado_trasero_1: json["PEGADO_TRASERO1"],
        pegado_trasero_2: json["PEGADO_TRASERO2"],
        pegado_delantero_1: json["PEGADO_DELANTERO1"],
        pegado_delantero_2: json["PEGADO_DELANTERO2"],
        cant_cono_1: json["CANT_CONO1"],
        cant_cono_2: json["CANT_CONO2"],
        grafica_1: json["GRAFICA1"],
        grafica_2: json["GRAFICA2"],
        troquelado_1: json["TROQUELADO1"],
        troquelado_2: json["TROQUELADO2"],
        materias_1: json["MATERIAS1"],
        materias_2: json["MATERIAS2"],
        ppr3_1: json["PPR3_1"],
        ppr3_2: json["PPR3_2"],
        ppr4_1: json["PPR4_1"],
        ppr4_2: json["PPR4_2"],
        ppr6_1: json["PPR6_1"],
        ppr6_2: json["PPR6_2"],
        fecha: json["FECHA"],
        hora: json["HORA"],
        estado: json["ESTADO"],
        fallosMaquina: json["FALLOS_MAQUINA"] == null
            ? []
            : List<FalloMaquina>.from(
                json["FALLOS_MAQUINA"].map((x) => FalloMaquina.fromJson(x))),
      );
}
