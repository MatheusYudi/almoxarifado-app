class GrupoAcesso
{
  String codigo;
  String nome;

  GrupoAcesso({
    this.codigo = '',
    this.nome = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'codigo' : codigo,
      'nome' : nome,
    };
  }

  factory GrupoAcesso.fromJson(Map<String, dynamic> json){
    return GrupoAcesso(
      codigo : json['codigo'] ?? '',
      nome : json['nome'] ?? '',
    );
  }
}