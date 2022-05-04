class MaterialRequisicao
{
  double qtd;

  MaterialRequisicao({
    this.qtd = 0,
  });

  Map<String, dynamic> toJson(){
    return{
      'qtd' : qtd,
    };
  }

  factory MaterialRequisicao.fromJson(Map<String, dynamic> json){
    return MaterialRequisicao(
      qtd : json['qtd'] ?? 0,
    );
  }
}