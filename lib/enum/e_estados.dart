// ignore_for_file: constant_identifier_names

enum EEstados
{
  AC,
  AL,
  AP,
  AM,
  BA,
  CE,
  DF,
  ES,
  GO,
  MA,
  MT,
  MS,
  MG,
  PA,
  PB,
  PR,
  PE,
  PI,
  RJ,
  RN,
  RS,
  RO,
  RR,
  SC,
  SP,
  SE,
  TO,
}

extension EEstadosExtensions on EEstados {

  String get nome {
    switch (this) {
      case EEstados.AC:
        return 'Acre';
      case EEstados.AL:
        return 'Alagoas';
      case EEstados.AP:
        return 'Amapá';
      case EEstados.AM:
        return 'Amazonas';
      case EEstados.BA:
        return 'Bahia';
      case EEstados.CE:
        return 'Ceará';
      case EEstados.DF:
        return 'Destrito Federal';
      case EEstados.ES:
        return 'Espirito Santo';
      case EEstados.GO:
        return 'Goiás';
      case EEstados.MA:
        return 'Maranhão';
      case EEstados.MT:
        return 'Mato Grosso';
      case EEstados.MS:
        return 'Mato Grosso do Sul';
      case EEstados.MG:
        return 'Minas Gerais';
      case EEstados.PA:
        return 'Pará';
      case EEstados.PB:
        return 'Paraíba';
      case EEstados.PR:
        return 'Paraná';
      case EEstados.PE:
        return 'Pernambuco';
      case EEstados.PI:
        return 'Piauí';
      case EEstados.RJ:
        return 'Rio de Janeiro';
      case EEstados.RN:
        return 'Rio Grande do Norte';
      case EEstados.RS:
        return 'Rio Grande do Sul';
      case EEstados.RO:
        return 'Rondônia';
      case EEstados.RR:
        return 'Roraima';
      case EEstados.SC:
        return 'Santa Catarina';
      case EEstados.SP:
        return 'São Paulo';
      case EEstados.SE:
        return 'Sergipe';
      case EEstados.TO:
        return 'Tocantins';
    }
  }

  int get codigo {
    switch (this) {
      case EEstados.AC:
        return 12;
      case EEstados.AL:
        return 27;
      case EEstados.AP:
        return 16;
      case EEstados.AM:
        return 13;
      case EEstados.BA:
        return 29;
      case EEstados.CE:
        return 23;
      case EEstados.DF:
        return 53;
      case EEstados.ES:
        return 32;
      case EEstados.GO:
        return 52;
      case EEstados.MA:
        return 21;
      case EEstados.MT:
        return 51;
      case EEstados.MS:
        return 50;
      case EEstados.MG:
        return 31;
      case EEstados.PA:
        return 15;
      case EEstados.PB:
        return 25;
      case EEstados.PR:
        return 41;
      case EEstados.PE:
        return 26;
      case EEstados.PI:
        return 22;
      case EEstados.RJ:
        return 33;
      case EEstados.RN:
        return 24;
      case EEstados.RS:
        return 43;
      case EEstados.RO:
        return 11;
      case EEstados.RR:
        return 14;
      case EEstados.SC:
        return 43;
      case EEstados.SP:
        return 35;
      case EEstados.SE:
        return 28;
      case EEstados.TO:
        return 17;
    }
  }
}