class MaterialInventario
{
  double qtdeFisica;
  double qtdeSistema;

  MaterialInventario({
    this.qtdeFisica = 0,
    this.qtdeSistema = 0,
  });

  Map<String, dynamic> toJson(){
    return{
      'qtdeFisica' : qtdeFisica,
      'qtdeSistema' : qtdeSistema,
    };
  }

  factory MaterialInventario.fromJson(Map<String, dynamic> json){
    return MaterialInventario(
      qtdeFisica : json['qtdeFisica'] ?? 0,
      qtdeSistema : json['qtdeSistema'] ?? 0,
    );
  }
}