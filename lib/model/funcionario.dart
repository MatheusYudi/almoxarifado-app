import 'grupo_acesso.dart';

class Funcionario
{
  int? id;
  String status;
  String nome;
  String cpf;
  String email;
  String? senha;
  GrupoAcesso? grupoAcesso;

  Funcionario({
    this.id,
    this.status = 'active',
    this.nome = '',
    this.cpf = '',
    this.email = '',
    this.senha,
    this.grupoAcesso,
  });

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name' : nome,
      'document' : cpf,
      'email' : email,
      'password' : senha,
      'accessGroupId' : grupoAcesso == null ? '' : grupoAcesso!.id,
    };
  }

  factory Funcionario.fromJson(Map<String, dynamic> json){
    return Funcionario(
      id : json['id'],
      status : json['status'],
      nome : json['name'] ?? '',
      cpf : json['document'] ?? '',
      email : json['email'] ?? '',
      senha : json['password'],
      grupoAcesso : json['accessGroup'] != null? GrupoAcesso.fromJson(json['accessGroup']) : null,
    );
  }
}