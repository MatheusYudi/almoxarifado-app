// ignore_for_file: constant_identifier_names

enum ETipoIe{
  Contribuinte,
  NaoContribuinte,
  Isento,
}

extension ETipoIeExtensions on ETipoIe {

  String get nome {
    switch (this) {
      case ETipoIe.Contribuinte:
        return 'Contribuinte';
      case ETipoIe.NaoContribuinte:
        return 'Não contribuinte';
      case ETipoIe.Isento:
        return 'Isento';
      default:
        return '';
    }
  }
}