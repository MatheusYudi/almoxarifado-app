class Requisitante
{
  String codigo;
  String nome;
  String cpf;
  String email;

  Requisitante({
    this.codigo = '',
    this.nome = '',
    this.cpf = '',
    this.email = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'codigo' : codigo,
      'nome' : nome,
      'cpf' : cpf,
      'email' : email,
    };
  }

  factory Requisitante.fromJson(Map<String, dynamic> json){
    return Requisitante(
      codigo : json['codigo'] ?? '',
      nome : json['nome'] ?? '',
      cpf : json['cpf'] ?? '',
      email : json['email'] ?? '',
    );
  }
}