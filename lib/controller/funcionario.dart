class Funcionario
{
  String codigo;
  String nome;
  String cpf;
  String email;
  String senha;

  Funcionario({
    this.codigo = '',
    this.nome = '',
    this.cpf = '',
    this.email = '',
    this.senha = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'codigo' : codigo,
      'nome' : nome,
      'cpf' : cpf,
      'email' : email,
      'senha' : senha,
    };
  }

  factory Funcionario.fromJson(Map<String, dynamic> json){
    return Funcionario(
      codigo : json['codigo'] ?? '',
      nome : json['nome'] ?? '',
      cpf : json['cpf'] ?? '',
      email : json['email'] ?? '',
      senha : json['senha'] ?? '',
    );
  }
}