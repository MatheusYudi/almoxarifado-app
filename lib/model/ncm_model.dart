class NcmModel{
  String codigo;
  String descricao;

  NcmModel({
    this.codigo = '',
    this.descricao = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'codigo' : codigo,
      'descricao' : descricao,
    };
  }

  factory NcmModel.fromJson(Map<String, dynamic> json){
    return NcmModel(
      codigo : json['codigo'],
      descricao : json['descricao'] ?? '',
    );
  }
}