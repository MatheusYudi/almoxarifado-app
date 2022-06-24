// ignore_for_file: constant_identifier_names

enum ERegimesTributarios{
  LucroArbitrado,
  MEI,
  LucroPresumido,
  LucroReal,
  SimplesNacional,
}

extension ERegimesTributariosExtensions on ERegimesTributarios {

  String get nome {
    switch (this) {
      case ERegimesTributarios.LucroArbitrado:
        return 'Lucro Arbitrado';
      case ERegimesTributarios.MEI:
        return 'MEI';
      case ERegimesTributarios.LucroPresumido:
        return 'Lucro Presumido';
      case ERegimesTributarios.LucroReal:
        return 'Lucro Real';
      case ERegimesTributarios.SimplesNacional:
        return 'Simples Nacional';
      default:
        return '';
    }
  }
}
