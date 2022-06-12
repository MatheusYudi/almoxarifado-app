// ignore_for_file: constant_identifier_names

enum EStatusRequisicao{
  ATIVO,
  INATIVO,
}

extension EStatusRequisicaoExtensions on EStatusRequisicao {

  String get nome {
    switch (this) {
      case EStatusRequisicao.ATIVO:
        return 'Ativo';
      case EStatusRequisicao.INATIVO:
        return 'Inativo';
      default:
        return '';
    }
  }
}