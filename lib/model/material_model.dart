import 'grupo_material.dart';

class MaterialModel
{
  int? id;
  String nome;
  String ncm;
  String unidade;
  String codigoBarras;
  double valorUnitario;
  double qtdeEstoque;
  double estoqueMinimo;
  GrupoMaterial? grupoMaterial;

  MaterialModel({
    this.id,
    this.nome = '',
    this.ncm = '',
    this.unidade = '',
    this.codigoBarras = '',
    this.valorUnitario = 0,
    this.qtdeEstoque = 0,
    this.estoqueMinimo = 0,
    this.grupoMaterial
  });

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'name' : nome,
      'ncmId' : ncm,
      'unit' : unidade,
      'barcode' : codigoBarras,
      'unitPrice' : valorUnitario,
      'stockQuantity' : qtdeEstoque,
      'minimumStock' : estoqueMinimo,
      'materialGroupId' : grupoMaterial == null ? '' : grupoMaterial!.id,
    };
  }

  factory MaterialModel.fromJson(Map<String, dynamic> json){
    return MaterialModel(
      id : json['id'],
      nome : json['name'] ?? '',
      ncm : json['ncm']['code'] ?? '',
      unidade : json['unit'] ?? '',
      codigoBarras : json['barcode'] ?? '',
      valorUnitario : double.parse("${json['unitPrice']}"),
      qtdeEstoque : double.parse("${json['stockQuantity']}"),
      estoqueMinimo :double.parse("${json['minimumStock']}"),
      grupoMaterial : json['materialGroup'] != null? GrupoMaterial.fromJson(json['materialGroup']) : null,
    );
  }
}