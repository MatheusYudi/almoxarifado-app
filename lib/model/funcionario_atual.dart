import 'funcionario.dart';
import 'grupo_acesso.dart';

class FuncionarioAtual extends Funcionario{
  String tokenApi;

  FuncionarioAtual({
    this.tokenApi = '',
    id,
    cpf,
    nome,
    email,
    senha,
    grupoAcesso,
  }) : super(
    id: id,
    cpf: cpf ?? '',
    email: email ?? '',
    nome: nome ?? '',
    senha: senha ?? '',
    grupoAcesso: grupoAcesso,
  );

  factory FuncionarioAtual.fromJson(Map<String, dynamic> json){
    return FuncionarioAtual(
      id : json['id'],
      nome : json['name'] ?? '',
      cpf : json['cpf'] ?? '',
      email : json['email'] ?? '',
      senha : json['senha'] ?? '',
      tokenApi : json['accessToken'] ?? '',
      grupoAcesso: json['accessGroup'] != null? GrupoAcesso.fromJson(json['accessGroup']) : null
    );
  }

  @override
  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name' : nome,
      'document' : cpf,
      'email' : email,
      'password' : senha,
      'accessGroupId' : grupoAcesso == null ? '' : grupoAcesso!.id,
      'token': tokenApi,
    };
  }
}