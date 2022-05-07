class MaterialNotaFiscal
{
  double qtd;

  MaterialNotaFiscal({
    this.qtd = 0,
  });

  Map<String, dynamic> toJson(){
    return{
      'qtd' : qtd,
    };
  }

  factory MaterialNotaFiscal.fromJson(Map<String, dynamic> json){
    return MaterialNotaFiscal(
      qtd : json['qtd'] ?? 0,
    );
  }
}