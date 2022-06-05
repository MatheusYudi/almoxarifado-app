
import 'funcionario.dart';
import 'material_model.dart';

class Movimentacao
{
  int? id;
  DateTime? dataHora;
  double quantidadeInicial;
  double quantidadeMovimentada;
  String tipo;
  String motivo;
  Funcionario? funcionario;
  MaterialModel? material;

  Movimentacao({
    this.id,
    this.dataHora,
    this.quantidadeInicial = 0,
    this.quantidadeMovimentada = 0,
    this.tipo = '',
    this.motivo = '',
    this.funcionario,
    this.material,
  });

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'quantity' : quantidadeMovimentada,
      'type' : tipo,
      'userId' : funcionario == null ? '' : funcionario!.id,
      'materialId' : material == null ? '' : material!.id,
      'reason': motivo,
    };
  }

  factory Movimentacao.fromJson(Map<String, dynamic> json){
    return Movimentacao(
      id: json['id'],
      dataHora : DateTime.tryParse(json['createdAt'].split('T')[0]),
      quantidadeInicial : json['quantidadeInicial'] ?? 0,
      quantidadeMovimentada : json['quantidadeMovimentada'] ?? 0,
      tipo : json['type'] ?? '',
      motivo : json['reason'] ?? '',
      funcionario : json['user'] != null? Funcionario.fromJson(json['user']) : null,
      material : json['material'] != null? MaterialModel.fromJson(json['material']) : null,
    );
  }
}