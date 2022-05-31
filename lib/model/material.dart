class Material
{
  String codigo;
  String descricao;
  double valorUnitario;
  double qtdeEstoque;
  double estoqueMinimo;
  String codigoBarras;

  Material({
    this.codigo = '',
    this.descricao = '',
    this.valorUnitario = 0,
    this.qtdeEstoque = 0,
    this.estoqueMinimo = 0,
    this.codigoBarras = '',
  });

  Map<String, dynamic> toJson(){
    return{
      'codigo' : codigo,
      'descricao' : descricao,
      'valorUnitario' : valorUnitario,
      'qtdeEstoque' : qtdeEstoque,
      'estoqueMinimo' : estoqueMinimo,     
      'codigoBarras' : codigoBarras,     
    };
  }

  factory Material.fromJson(Map<String, dynamic> json){
    return Material(
      codigo : json['codigo'] ?? '',
      descricao : json['descricao'] ?? '',
      valorUnitario : json['valorUnitario'] ?? 0,
      qtdeEstoque : json['qtdeEstoque'] ?? 0,
      estoqueMinimo : json['estoqueMinimo'] ?? 0,
      codigoBarras : json['codigoBarras'] ?? '',
    );
  }
}