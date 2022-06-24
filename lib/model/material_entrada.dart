import 'material_model.dart';

class MaterialEntrada
{
  MaterialModel? material;
  double qtd;

  MaterialEntrada({
    this.material,
    this.qtd = 0,
  });

  Map<String, dynamic> toJson(){
    return{
      'materialId' : material == null ? '' : material!.id,
      'quantity' : qtd,
    };
  }

  factory MaterialEntrada.fromJson(Map<String, dynamic> json){
    return MaterialEntrada(
      qtd : json['quantity'] ?? 0,
      material : json['material'] != null? MaterialModel.fromJson(json['material']) : null,
    );
  }
}