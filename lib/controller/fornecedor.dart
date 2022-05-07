class Fornecedor
{
  String cnpj;
  String ie;
  String razoaSocial;
  String nomeFantasia;
  String endereco;
  String complemento;
  String bairro;
  String cidade;
  int numero;
  String logradouro;
  String cep;  

  Fornecedor({
      this.cnpj = '',
      this.ie = '',
      this.razoaSocial = '',
      this.nomeFantasia = '',
      this.endereco = '',
      this.complemento = '',
      this.bairro = '',
      this.cidade = '',
      this.numero = 0,
      this.logradouro = '',
      this.cep = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'cnpj' : cnpj,
      'ie' : ie,
      'razoaSocial' : razoaSocial,
      'nomeFantasia' : nomeFantasia,
      'endereco' : endereco,
      'complemento' : complemento,
      'bairro' : bairro,
      'cidade' : cidade,
      'numero' : numero,
      'logradouro' : logradouro,
      'cep' : cep,
    };
  }
  
  factory Fornecedor.fromJson(Map<String, dynamic> json){
    return Fornecedor(
      cnpj : json['cnpj'] ?? '',
      ie : json['ie'] ?? '',
      razoaSocial : json['razoaSocial'] ?? '',
      nomeFantasia : json['nomeFantasia'] ?? '',
      endereco : json['endereco'] ?? '',
      complemento : json['complemento'] ?? '',
      bairro : json['bairro'] ?? '',
      cidade: json['cidade'] ?? '',
      numero : json['numero'],
      logradouro : json['logradouro'] ?? '',
      cep : json['cep'] ?? '',
    );
  }
}