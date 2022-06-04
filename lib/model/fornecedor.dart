class Fornecedor
{
  int? id;
  String status;
  String cnpj;
  String ie;
  String razaoSocial;
  String nomeFantasia;
  String estado;
  String complemento;
  String bairro;
  String cidade;
  int numero;
  String rua;
  String cep;
  String regimeTibutario;
  String tipoIe;

  Fornecedor({
      this.id,
      this.status = 'ativo',
      this.cnpj = '',
      this.ie = '',
      this.razaoSocial = '',
      this.nomeFantasia = '',
      this.estado = '',
      this.complemento = '',
      this.bairro = '',
      this.cidade = '',
      this.numero = 0,
      this.rua = '',
      this.cep = '',
      this.regimeTibutario = '',
      this.tipoIe = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'status' : status,
      'document' : cnpj,
      'stateRegistration' : ie,
      'corporateName' : razaoSocial,
      'tradingName' : nomeFantasia,
      'state' : estado,
      'postalCode' : cep,
      'address' : rua,
      'addressNumber' : numero,
      'city' : cidade,
      'district' : bairro,
      'complement' : complemento,
      'calculationRegime' : regimeTibutario,
      'stateRegistrationType' : tipoIe,
    };
  }
  
  factory Fornecedor.fromJson(Map<String, dynamic> json){
    return Fornecedor(
      id : json['id'],
      status : json['status'] ?? '',
      cnpj : json['document'] ?? '',
      ie : json['stateRegistration'] ?? '',
      razaoSocial : json['corporateName'] ?? '',
      nomeFantasia : json['tradingName'] ?? '',
      estado : json['state'] ?? '',
      cep : json['postalCode'] ?? '',
      rua : json['address'] ?? '',
      numero : json['addressNumber'],
      cidade: json['city'] ?? '',
      bairro : json['district'] ?? '',
      complemento : json['complement'] ?? '',
      regimeTibutario : json['calculationRegime'] ?? '',
      tipoIe : json['stateRegistrationType'] ?? '',
    );
  }
}