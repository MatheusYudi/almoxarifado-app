class Unidade
{
  String descricao;

  Unidade({
    this.descricao = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'descricao' : descricao,
    };
  }

  factory Unidade.fromJson(Map<String, dynamic> json){
    return Unidade(
      descricao : json['descricao'] ?? '',
    );
  }
}