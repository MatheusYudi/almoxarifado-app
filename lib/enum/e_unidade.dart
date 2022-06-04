// ignore_for_file: constant_identifier_names

enum EUnidade{
  KG,
  DUZIA,
  G,
  TON,
  LT,
  UN,
  M3,
  MWHORA,
  QUILAT,
  M2,
  METRO,
  PARES,
}

extension EUnidadeExtensions on EUnidade {
  String get nome {
    switch (this) {
      case EUnidade.KG:
        return 'Quilo';
      case EUnidade.DUZIA:
        return 'Duzia';
      case EUnidade.G:
        return 'Grama';
      case EUnidade.TON:
        return 'Tonelada';
      case EUnidade.LT:
        return 'Litro';
      case EUnidade.UN:
        return 'Unidade';
      case EUnidade.M3:
        return 'Metro cúbico';
      case EUnidade.MWHORA:
        return 'Megawatt Hora';
      case EUnidade.QUILAT:
        return 'Quilate';
      case EUnidade.M2:
        return 'Metro Quadrado';
      case EUnidade.METRO:
        return 'Metro';
      case EUnidade.PARES:
        return 'Pares';
      default:
        return '';
    }
  }
}