import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/models/fallo_maquina_model.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/models/operario.dart';

class RegistroProduccion {
  RegistroProduccion({
    this.producto,
    this.maquina,
    this.operario,
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

  Bobina? producto = Bobina(id: '', nombre: '');
  Maquina? maquina = Maquina(id: '', maquina: '');
  Operario? operario = Operario(legajo: '', nombre: '');
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
}
