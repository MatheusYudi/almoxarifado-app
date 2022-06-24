import 'funcionario.dart';
import 'material_requisicao.dart';

class Requisicao
{
  int? id;
  DateTime? dataHora;
  Funcionario? requisitante;
  List<MaterialRequisicao>? itens;
  String aprovada;

  Requisicao({
    this.id,
    this.dataHora,
    this.aprovada = '',
    this.requisitante,
    List<MaterialRequisicao>? itens,
  }): itens = itens ?? [];

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'userId' : requisitante == null ? '' : requisitante!.id,
      'items' : itens!.map((item) => item.toJson()).toList(),
    };
  }

  factory Requisicao.fromJson(Map<String, dynamic> json){
    List list = json['requisitionMaterials'] ?? [];
    List<MaterialRequisicao> listMateriaisRequisicao = list.map((materialRequisicao){
      return MaterialRequisicao.fromJson(materialRequisicao);
    }).toList();
    
    return Requisicao(
      id: json['id'],
      dataHora : DateTime.tryParse(json['createdAt'].split('T')[0]),
      aprovada : json['approved'] == true ? 'Sim' : 'Não',
      requisitante : json['user'] != null? Funcionario.fromJson(json['user']) : null,
      itens: listMateriaisRequisicao,
    );
  }
}