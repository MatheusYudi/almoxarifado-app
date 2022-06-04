// ignore_for_file: constant_identifier_names

enum ERegimesTributarios{
  Contribuinte,
  NaoContribuinte,
  Isento,
}

extension ERegimesTributariosExtensions on ERegimesTributarios {

  String get nome {
    switch (this) {
      case ERegimesTributarios.Contribuinte:
        return 'Contribuinte';
      case ERegimesTributarios.NaoContribuinte:
        return 'Não contribuinte';
      case ERegimesTributarios.Isento:
        return 'Isento';
      default:
        return '';
    }
  }
}