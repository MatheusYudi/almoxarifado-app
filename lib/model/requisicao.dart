import 'funcionario.dart';
import 'material_requisicao.dart';

class Requisicao
{
  int? id;
  DateTime? dataHora;
  Funcionario? requisitante;
  List<MaterialRequisicao>? itens;

  Requisicao({
    this.id,
    this.dataHora,
    this.requisitante,
    List<MaterialRequisicao>? itens,
  }): itens = itens ?? [];

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'dataHora' : dataHora,
      'userId' : requisitante == null ? '' : requisitante!.id,
      'items' : itens!.map((item) => item.toJson()).toList(),
    };
  }

  factory Requisicao.fromJson(Map<String, dynamic> json){
    return Requisicao(
      id: json['id'],
      dataHora : json['dataHora'] ?? DateTime.now(),
      requisitante : json['user'] != null? Funcionario.fromJson(json['user']) : null,
    );
  }
}