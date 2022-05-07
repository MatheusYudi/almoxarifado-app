class Inventario
{
  DateTime? dataHora;
  String status;

  Inventario({
    this.dataHora,
    this.status = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'dataHora' : dataHora,
      'status' : status,
    };
  }

  factory Inventario.fromJson(Map<String, dynamic> json){
    return Inventario(
      dataHora : json['dataHora'],
      status : json['status'] ?? '',
    );
  }
}