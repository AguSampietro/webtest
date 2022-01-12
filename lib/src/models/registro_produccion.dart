import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/models/fallo_maquina_model.dart';

class RegistroProduccion {
  RegistroProduccion({
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

  Bobina? bobina1 = Bobina(id: '', nombre: '');
  Bobina? bobina2 = Bobina(id: '', nombre: '');
  Bobina? bobina3 = Bobina(id: '', nombre: '');
  Bobina? bobina4 = Bobina(id: '', nombre: '');
  Bobina? bobina5 = Bobina(id: '', nombre: '');
  Bobina? bobina6 = Bobina(id: '', nombre: '');

  Bobina? bobinaFondo1 = Bobina(id: '', nombre: '');
  Bobina? bobinaFondo2 = Bobina(id: '', nombre: '');
  Bobina? bobinaFondo3 = Bobina(id: '', nombre: '');

  Bobina? bobinaLateral1 = Bobina(id: '', nombre: '');
  Bobina? bobinaLateral2 = Bobina(id: '', nombre: '');
  Bobina? bobinaLateral3 = Bobina(id: '', nombre: '');

  Bobina? bobinaCono1 = Bobina(id: '', nombre: '');
  Bobina? bobinaCono2 = Bobina(id: '', nombre: '');
  Bobina? bobinaCono3 = Bobina(id: '', nombre: '');

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
        bobina1: Bobina(id: '', nombre: ''),
        bobina2: Bobina(id: '', nombre: ''),
        bobina3: Bobina(id: '', nombre: ''),
        bobina4: Bobina(id: '', nombre: ''),
        bobina5: Bobina(id: '', nombre: ''),
        bobina6: Bobina(id: '', nombre: ''),
        bobinaFondo1: Bobina(id: '', nombre: ''),
        bobinaFondo2: Bobina(id: '', nombre: ''),
        bobinaFondo3: Bobina(id: '', nombre: ''),
        bobinaLateral1: Bobina(id: '', nombre: ''),
        bobinaLateral2: Bobina(id: '', nombre: ''),
        bobinaLateral3: Bobina(id: '', nombre: ''),
        bobinaCono1: Bobina(id: '', nombre: ''),
        bobinaCono2: Bobina(id: '', nombre: ''),
        bobinaCono3: Bobina(id: '', nombre: ''),
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
        "COD_PRODUCTO": codProducto,
        "ID_MAQUINA": idMaquina,
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
        "BOBINA1": bobinaToJson(bobina1!),
        "BOBINA2": bobinaToJson(bobina2!),
        "BOBINA3": bobinaToJson(bobina3!),
        "BOBINA4": bobinaToJson(bobina4!),
        "BOBINA5": bobinaToJson(bobina5!),
        "BOBINA6": bobinaToJson(bobina6!),
        "BOBINA_FONDO1": bobinaToJson(bobinaFondo1!),
        "BOBINA_FONDO2": bobinaToJson(bobinaFondo2!),
        "BOBINA_FONDO3": bobinaToJson(bobinaFondo3!),
        "BOBINA_LATERAL1": bobinaToJson(bobinaLateral1!),
        "BOBINA_LATERAL2": bobinaToJson(bobinaLateral2!),
        "BOBINA_LATERAL3": bobinaToJson(bobinaLateral3!),
        "BOBINA_CONO1": bobinaToJson(bobinaCono1!),
        "BOBINA_CONO2": bobinaToJson(bobinaCono2!),
        "BOBINA_CONO3": bobinaToJson(bobinaCono3!),
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
        "FALLOS_MAQUINA": fallosMaquinasToJson(fallosMaquina!),
      };

  bool isReady() {
    return contadorInicial != '' &&
        lote != '' &&
        codProducto != '' &&
        idMaquina != '' &&
        legajoOperario != '';
  }
}
