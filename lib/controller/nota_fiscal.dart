class NotaFiscal
{
  int numero;
  String chave;

  NotaFiscal({
    this.numero = 0,
    this.chave = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'numero' : numero,
      'chave' : chave,
    };
  }

  factory NotaFiscal.fromJson(Map<String, dynamic> json){
    return NotaFiscal(
      numero : json['numero'] ?? 0,
      chave : json['chave'] ?? '',
    );
  }
}