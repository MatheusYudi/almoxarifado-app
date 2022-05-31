class GrupoAcesso
{
  int? id;
  String nome;

  GrupoAcesso({
    this.id,
    this.nome = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'name' : nome,
    };
  }

  factory GrupoAcesso.fromJson(Map<String, dynamic> json){
    return GrupoAcesso(
      id : json['id'],
      nome : json['name'] ?? '',
    );
  }
}