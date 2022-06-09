import 'funcionario.dart';
import 'material_inventario.dart';

class Inventario
{
  int? id;
  DateTime? dataHora;
  String status;
  Funcionario? operador;
  List<MaterialInventario>? itens;

  Inventario({
    this.id,
    this.dataHora,
    this.status = '',
    this.operador,
    List<MaterialInventario>? itens,
  }): itens = itens ?? [];

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'status' : status,
      'userId' : operador == null ? '' : operador!.id,
      'items' : itens!.map((item) => item.toJson()).toList()
    };
  }

  factory Inventario.fromJson(Map<String, dynamic> json){
    List list = json['inventoryMaterials'] ?? [];
    List<MaterialInventario> listMateriaisInventario= list.map((materialInventario){
      return MaterialInventario.fromJson(materialInventario);
    }).toList();

    return Inventario(
      id: json['id'],
      dataHora : DateTime.tryParse(json['createdAt'].split('T')[0]),
      status : json['status'] ?? '',
      operador : json['user'] != null? Funcionario.fromJson(json['user']) : null,
      itens: listMateriaisInventario,
    );
  }
}