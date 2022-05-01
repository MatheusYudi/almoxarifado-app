class Requisicao
{
  DateTime? dataHora;

  Requisicao({
    this.dataHora,
  });

  Map<String, dynamic> toJson(){
    return{
      'dataHora' : dataHora,
    };
  }

  factory Requisicao.fromJson(Map<String, dynamic> json){
    return Requisicao(
      dataHora : json['dataHora'] ?? DateTime.now(),
    );
  }
}