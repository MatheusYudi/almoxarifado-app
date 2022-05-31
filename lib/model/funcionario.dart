class Funcionario
{
  int? id;
  String nome;
  String cpf;
  String email;
  String senha;

  Funcionario({
    this.id,
    this.nome = '',
    this.cpf = '',
    this.email = '',
    this.senha = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name' : nome,
      'cpf' : cpf,
      'email' : email,
      'senha' : senha,
    };
  }

  factory Funcionario.fromJson(Map<String, dynamic> json){
    return Funcionario(
      id : json['id'],
      nome : json['name'] ?? '',
      cpf : json['cpf'] ?? '',
      email : json['email'] ?? '',
      senha : json['senha'] ?? '',
    );
  }
}