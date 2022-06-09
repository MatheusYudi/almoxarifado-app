import 'material_model.dart';

class MaterialInventario
{
  double qtdeFisica;
  MaterialModel? material;

  MaterialInventario({
    this.qtdeFisica = 0,
    this.material,
  });

  Map<String, dynamic> toJson(){
    return{
      'physicQuantity' : qtdeFisica,
      'materialId' : material == null ? '' : material!.id,
    };
  }

  factory MaterialInventario.fromJson(Map<String, dynamic> json){
    return MaterialInventario(
      qtdeFisica : double.parse("${json['physicQuantity']}"),
      material : json['material'] != null? MaterialModel.fromJson(json['material']) : null,
    );
  }
}