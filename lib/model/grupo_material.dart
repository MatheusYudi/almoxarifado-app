class GrupoMaterial
{
  int? id;
  String status;
  String nome;

  GrupoMaterial({
    this.id,
    this.status = '',
    this.nome = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'status': status,
      'name' : nome,
    };
  }

  factory GrupoMaterial.fromJson(Map<String, dynamic> json){
    return GrupoMaterial(
      id : json['id'],
      status : json['status'],
      nome : json['name'] ?? '',
    );
  }
}