
import 'funcionario.dart';
import 'material_model.dart';

class Movimentacao
{
  DateTime? dataHora;
  double quantidadeInicial;
  double quantidadeMovimentada;
  String tipo;
  Funcionario? funcionario;
  MaterialModel? material;

  Movimentacao({
    this.dataHora,
    this.quantidadeInicial = 0,
    this.quantidadeMovimentada = 0,
    this.tipo = '',
    this.funcionario,
    this.material,
  });

  Map<String, dynamic> toJson(){
    return{
      'dataHora' : dataHora,
      'quantidadeInicial' : quantidadeInicial,
      'quantidadeMovimentada' : quantidadeMovimentada,
      'type' : tipo,
      'user' : tipo,
      'material' : material,
    };
  }

  factory Movimentacao.fromJson(Map<String, dynamic> json){
    return Movimentacao(
      dataHora : json['dataHora'],
      quantidadeInicial : json['quantidadeInicial'] ?? 0,
      quantidadeMovimentada : json['quantidadeMovimentada'] ?? 0,
      tipo : json['type'] ?? '',
      funcionario : json['user'] != null? Funcionario.fromJson(json['user']) : null,
      material : json['material'] != null? MaterialModel.fromJson(json['material']) : null,
    );
  }
}