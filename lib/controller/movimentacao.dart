class Movimentacao
{
  DateTime? dataHora;
  double quantidadeInicial;
  double quantidadeMovimentada;

  Movimentacao({
    this.dataHora,
    this.quantidadeInicial = 0,
    this.quantidadeMovimentada = 0,
  });

  Map<String, dynamic> toJson(){
    return{
      'dataHora' : dataHora,
      'quantidadeInicial' : quantidadeInicial,
      'quantidadeMovimentada' : quantidadeMovimentada,
    };
  }

  factory Movimentacao.fromJson(Map<String, dynamic> json){
    return Movimentacao(
      dataHora : json['dataHora'],
      quantidadeInicial : json['quantidadeInicial'] ?? 0,
      quantidadeMovimentada : json['quantidadeMovimentada'] ?? 0,
    );
  }
}