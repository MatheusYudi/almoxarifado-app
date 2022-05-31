import 'funcionario.dart';

class FuncionarioAtual extends Funcionario{
  String tokenApi;

  FuncionarioAtual({
    this.tokenApi = '',
    id,
    cpf,
    nome,
    email,
    senha,
  }) : super(
    id: id,
    cpf: cpf ?? '',
    email: email ?? '',
    nome: nome ?? '',
    senha: senha ?? ''
  );

  factory FuncionarioAtual.fromJson(Map<String, dynamic> json){
    return FuncionarioAtual(
      id : json['id'],
      nome : json['name'] ?? '',
      cpf : json['cpf'] ?? '',
      email : json['email'] ?? '',
      senha : json['senha'] ?? '',
      tokenApi : json['accessToken'] ?? '',
    );
  }
}