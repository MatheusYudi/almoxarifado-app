class Fornecedor
{
  int? id;
  String status;
  String cnpj;
  String ie;
  String razoaSocial;
  String nomeFantasia;
  String estado;
  String complemento;
  String bairro;
  String cidade;
  int numero;
  String rua;
  String cep;  

  Fornecedor({
      this.id,
      this.status = '',
      this.cnpj = '',
      this.ie = '',
      this.razoaSocial = '',
      this.nomeFantasia = '',
      this.estado = '',
      this.complemento = '',
      this.bairro = '',
      this.cidade = '',
      this.numero = 0,
      this.rua = '',
      this.cep = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'status' : status,
      'document' : cnpj,
      'stateRegistration' : ie,
      'corporateName' : razoaSocial,
      'tradingName' : nomeFantasia,
      'state' : estado,
      'postalCode' : cep,
      'address' : rua,
      'addressNumber' : numero,
      'city' : cidade,
      'district' : bairro,
      'complement' : complemento,
    };
  }
  
  factory Fornecedor.fromJson(Map<String, dynamic> json){
    return Fornecedor(
      id : json['id'],
      status : json['status'] ?? '',
      cnpj : json['document'] ?? '',
      ie : json['stateRegistration'] ?? '',
      razoaSocial : json['corporateName'] ?? '',
      nomeFantasia : json['tradingName'] ?? '',
      estado : json['state'] ?? '',
      cep : json['postalCode'] ?? '',
      rua : json['address'] ?? '',
      numero : json['addressNumber'],
      cidade: json['city'] ?? '',
      bairro : json['district'] ?? '',
      complemento : json['complement'] ?? '',
    );
  }
}