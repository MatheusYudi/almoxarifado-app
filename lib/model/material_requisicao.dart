import 'material_model.dart';

class MaterialRequisicao
{
  double qtd;
  MaterialModel? material;

  MaterialRequisicao({
    this.qtd = 0,
    this.material,
  });

  Map<String, dynamic> toJson(){
    return{
      'quantity' : qtd,
      'materialId' : material == null ? '' : material!.id,
    };
  }

  factory MaterialRequisicao.fromJson(Map<String, dynamic> json){
    return MaterialRequisicao(
      qtd : double.parse("${json['quantity']}"),
      material : json['material'] != null? MaterialModel.fromJson(json['material']) : null,
    );
  }
}