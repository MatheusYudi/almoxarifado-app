class Grupo
{
  String descricao;

  Grupo({
    this.descricao = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'descricao' : descricao,
    };
  }

  factory Grupo.fromJson(Map<String, dynamic> json){
    return Grupo(
      descricao : json['descricao'] ?? '',
    );
  }
}