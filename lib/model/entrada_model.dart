import 'fornecedor.dart';
import 'material_entrada.dart';

class EntradaModel
{
  int? id;
  int numero;
  String chave;
  DateTime? dataHora;
  Fornecedor? fornecedor;
  List<MaterialEntrada>? itens;

  EntradaModel({
    this.id,
    this.numero = 0,
    this.chave = '',
    this.dataHora,
    this.fornecedor,
    List<MaterialEntrada>? itens,
  }): itens = itens ?? [];

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'number' : numero,
      'key' : chave,
      'supplierId' : fornecedor == null ? '' : fornecedor!.id,
      'items' : itens!.map((item) => item.toJson()).toList()
    };
  }

  factory EntradaModel.fromJson(Map<String, dynamic> json){
    return EntradaModel(
      id: json['id'],
      numero : json['number'] ?? 0,
      chave : json['key'] ?? '',
      dataHora : DateTime.tryParse(json['createdAt'].split('T')[0]),
      fornecedor : json['supplier'] != null? Fornecedor.fromJson(json['supplier']) : null,
    );
  }
}