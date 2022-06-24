import 'package:flutter/material.dart';

class TesteData
{
  static List<Map> clientes = [
    {
      'nomeFantasia': {
        'display': const Text('Cliente 1'),
        'textCompareOrder': 'Cliente 1',
        'alignment': Alignment.topLeft,
      },
      'cpfCnpj': {
        'display': const Text('11.111.111/1111-11'),
        'textCompareOrder': '11.111.111/1111-11',
        'alignment': Alignment.topLeft,
      },
      'endereco': {
        'display': const Text('Endereco cliente 1'),
        'textCompareOrder': 'Endereco cliente 1',
        'alignment': Alignment.topLeft,
      },
      'contato': {
        'display': const Text('conatato cliente 1'),
        'textCompareOrder': 'conatato cliente 1',
        'alignment': Alignment.topLeft,
      }
    },
    {
      'nomeFantasia': {
        'display': const Text('Cliente 2'),
        'textCompareOrder': 'Cliente 2',
        'alignment': Alignment.topLeft,
	    },
      'cpfCnpj': {
        'display': const Text('22.222.222/2222-22'),
        'textCompareOrder': '22.222.222/2222-22',
        'alignment': Alignment.topLeft,
      },
      'endereco': {
        'display': const Text('Endereco cliente 2'),
        'textCompareOrder': 'Endereco cliente 2',
        'alignment': Alignment.topLeft,
      },
      'contato': {
        'display': const Text('conatato cliente 2'),
        'textCompareOrder': 'conatato cliente 2',
        'alignment': Alignment.topLeft,
      }
    },
    {
      'nomeFantasia': {
        'display': const Text('Cliente 3'),
        'textCompareOrder': 'Cliente 3',
        'alignment': Alignment.topLeft,
      },
      'cpfCnpj': {
        'display': const Text('33.333.333/3333-33'),
        'textCompareOrder': '33.333.333/3333-33',
        'alignment': Alignment.topLeft,
      },
      'endereco': {
        'display': const Text('Endereco cliente 3'),
        'textCompareOrder': '33.333.333/3333-33',
        'alignment': Alignment.topLeft,
      },
      'contato': {
        'display': const Text('conatato cliente 3'),
        'textCompareOrder': 'conatato cliente 3',
        'alignment': Alignment.topLeft,
      }
    },
    {
      'nomeFantasia': {
        'display': const Text('Cliente 4'),
        'textCompareOrder': 'Cliente 4',
        'alignment': Alignment.topLeft,
      },
      'cpfCnpj': {
        'display': const Text('44.444.444/4444-44'),
        'textCompareOrder': '44.444.444/4444-44',
        'alignment': Alignment.topLeft,
      },
      'endereco': {
        'display': const Text('Endereco cliente 4'),
        'textCompareOrder': 'Endereco cliente 4',
        'alignment': Alignment.topLeft,
      },
      'contato': {
        'display': const Text('conatato cliente 4'),
        'textCompareOrder': 'conatato cliente 4',
        'alignment': Alignment.topLeft,
      }
    },
  ];

  static List<Map> produtos = [
    {
      'codigo': {
        'display': const Text('00001'),
        'textCompareOrder': '00001',
        'alignment': Alignment.topLeft,
      },
      'descricao': {
        'display': const Text('Produto 1'),
        'textCompareOrder': 'Produto 1',
        'alignment': Alignment.topLeft,
      },
      'custo': {
        'display': const Text('1.11'),
        'textCompareOrder': '1.11',
        'alignment': Alignment.topRight,
      },
      'unidade': {
        'display': const Text('UN'),
        'textCompareOrder': 'UN',
        'alignment': Alignment.center,
      },
      'precoVenda': {
        'display': const Text('1.11'),
        'textCompareOrder': '1.11',
        'alignment': Alignment.topRight,
      },
      'ativo': {
        'display': const Text('Sim'),
        'textCompareOrder': 1,
        'alignment': Alignment.center,
      },
    },
    {
      'codigo': {
        'display': const Text('00002'),
        'textCompareOrder': '00002',
        'alignment': Alignment.topLeft,
      },
      'descricao': {
        'display': const Text('Produto 2'),
        'textCompareOrder': 'Produto 2',
        'alignment': Alignment.topLeft,
      },
      'custo': {
        'display': const Text('2.22'),
        'textCompareOrder': '2.22',
        'alignment': Alignment.topRight,
      },
      'unidade': {
        'display': const Text('UN'),
        'textCompareOrder': 'UN',
        'alignment': Alignment.center,
      },
      'precoVenda': {
        'display': const Text('2.22'),
        'textCompareOrder': '2.22',
        'alignment': Alignment.topRight,
      },
      'ativo': {
        'display': const Text('Sim'),
        'textCompareOrder': 1,
        'alignment': Alignment.center,
      },
    },
    {
      'codigo': {
        'display': const Text('00003'),
        'textCompareOrder': '00003',
        'alignment': Alignment.topLeft,
      },
      'descricao': {
        'display': const Text('Produto 3'),
        'textCompareOrder': 'Produto 3',
        'alignment': Alignment.topLeft,
      },
      'custo': {
        'display': const Text('3.33'),
        'textCompareOrder': '3.33',
        'alignment': Alignment.topRight,
      },
      'unidade': {
        'display': const Text('UN'),
        'textCompareOrder': 'UN',
        'alignment': Alignment.center,
      },
      'precoVenda': {
        'display': const Text('3.33'),
        'textCompareOrder': '3.33',
        'alignment': Alignment.topRight,
      },
      'ativo': {
        'display': const Text('Sim'),
        'textCompareOrder': 1,
        'alignment': Alignment.center,
      },
    },
    {
      'codigo': {
        'display': const Text('00004'),
        'textCompareOrder': '00004',
        'alignment': Alignment.topLeft,
      },
      'descricao': {
        'display': const Text('Produto 4'),
        'textCompareOrder': 'Produto 4',
        'alignment': Alignment.topLeft,
      },
      'custo': {
        'display': const Text('4.44'),
        'textCompareOrder': '4.44',
        'alignment': Alignment.topRight,
      },
      'unidade': {
        'display': const Text('UN'),
        'textCompareOrder': 'UN',
        'alignment': Alignment.center,
      },
      'precoVenda': {
        'display': const Text('4.44'),
        'textCompareOrder': '4.44',
        'alignment': Alignment.topRight,
      },
      'ativo': {
        'display': const Text('Sim'),
        'textCompareOrder': 1,
        'alignment': Alignment.center,
      },
    },
  ];

  static List<Map> codigoBarras = [
    {
      'codigoBarras': {
        'display': const Text('1234567890123'),
        'textCompareOrder': '1234567890123',
        'alignment': Alignment.topLeft,
      },
    }
  ];

  static List<Map> fornecedorProduto = [
    {
      'fornecedor': {
        'display': const Text('Fornecedor 1'),
        'textCompareOrder': '1234567890123',
        'alignment': Alignment.topLeft,
      },
    }
  ];
  
  static List<Map> headers = [
    {
      'link': 'cnpj_cpf',
      'title': 'CPF/CNPJ',
      'sortable': true,
      'alignment': Alignment.topLeft,
      'enableSearch': true,
      'displayPercentage': 25,
    },
    {
      'link': 'razaoSocial',
      'title': 'Razão Social',
      'sortable': false,
      'alignment': Alignment.topLeft,
      'enableSearch': true,
      'displayPercentage': 35,
    },
    {
      'link': 'nome_fantasia',
      'title': 'Nome Fantasia',
      'sortable': true,
      'alignment': Alignment.topLeft,
      'enableSearch': true,
      'displayPercentage': 30,
    },
    {
      'link': 'delete',
      'title': '',
      'sortable': false,
      'alignment': Alignment.center,
      'enableSearch': false,
      'displayPercentage': 5,
    },
    {
      'link': 'edit',
      'title': '',
      'sortable': false,
      'alignment': Alignment.center,
      'enableSearch': false,
      'displayPercentage': 5,
    }
  ];

  static List<Map> produtoHeaders = [
    {
      'link': 'codigo',
      'title': 'Código',
      'sortable': true,
      'alignment': Alignment.topLeft,
      'enableSearch': true,
      'displayPercentage': 10,
    },
    {
      'link': 'descricao',
      'title': 'Descrição',
      'sortable': true,
      'alignment': Alignment.topLeft,
      'enableSearch': true,
      'displayPercentage': 40,
    },
    {
      'link': 'preco_custo',
      'title': '\$ Custo',
      'sortable': true,
      'alignment': Alignment.topRight,
      'enableSearch': true,
      'displayPercentage': 10,
    },
    {
      'link': 'unidade',
      'title': 'Unidade',
      'sortable': true,
      'alignment': Alignment.center,
      'enableSearch': false,
      'displayPercentage': 10,
    },
    {
      'link': 'preco1',
      'title': '\$ Venda',
      'sortable': true,
      'alignment': Alignment.topRight,
      'enableSearch': true,
      'displayPercentage': 10,
    },
    {
      'link': 'ativo',
      'title': 'Ativo',
      'sortable': true,
      'alignment': Alignment.center,
      'enableSearch': false,
      'displayPercentage': 10,
    },
    {
      'link': 'edit',
      'title': '',
      'sortable': false,
      'alignment': Alignment.center,
      'enableSearch': false,
      'displayPercentage': 5,
    },
    {
      'link': 'delete',
      'title': '',
      'sortable': false,
      'alignment': Alignment.center,
      'enableSearch': false,
      'displayPercentage': 5,
    },
  ];
  
  static List<Map> codigoBarrasHeader = [
    {
      'link': 'codigoBarras',
      'title': 'Código de Barras',
      'sortable': true,
      'alignment': Alignment.topLeft,
      'enableSearch': true,
      'displayPercentage': 90,
    },
    {
      'link': 'delete',
      'title': '',
      'sortable': false,
      'alignment': Alignment.center,
      'enableSearch': false,
      'displayPercentage': 10,
    },
  ];

  static List<Map> fornecedorProdutoHeaders = [
    {
      'link': 'fornecedor',
      'title': 'Fornecedor',
      'sortable': true,
      'alignment': Alignment.topLeft,
      'enableSearch': true,
      'displayPercentage': 100,
    },
  ];

  static List dropDownCfop = [
    {'id' : '5102', 'descricao' : 'Venda Revenda'},
    {'id' : '5101', 'descricao': 'Venda Fabr. Própria'},
    {'id' : '6102', 'descricao': 'Venda Revenda fora do estado'},
    {'id' : '6101', 'descricao': 'Venda Revenda fora do estado'},
  ];

  static List dropDownNcm = [
    {'id' : '1', 'codigo' : '11111111'},
    {'id' : '2', 'codigo' : '22222222'},
    {'id' : '3', 'codigo' : '33333333'},
    {'id' : '3', 'codigo' : '44444444'},
  ];
  
  static List dropDownUnidade = [
    {'id' : '1', 'sigla' : 'UN'},
    {'id' : '2', 'sigla' : 'KG'},
    {'id' : '3', 'sigla' : 'LT'},
    {'id' : '4', 'sigla' : 'CX'},
  ];

  static List dropDownFabricante = [
    {'id' : '1', 'descricao' : 'Fabricante 1'},
    {'id' : '2', 'descricao' : 'Fabricante 2'},
    {'id' : '3', 'descricao' : 'Fabricante 3'},
    {'id' : '4', 'descricao' : 'Fabricante 4'},
  ];

  static List dropDownGrupoProduto = [
    {'id' : '1', 'descricao' : 'Grupo 1'},
    {'id' : '2', 'descricao' : 'Grupo 2'},
    {'id' : '3', 'descricao' : 'Grupo 3'},
    {'id' : '4', 'descricao' : 'Grupo 4'},
  ];

  static List<String> dropDownFornecedor = [
    'Fornecedor 1',
    'Fornecedor 2',
    'Fornecedor 3',
    'Fornecedor 4',
  ];

  static List<String> dropDownEstadoCivil = [
    'Solteiro',
    'Casado',
    'Separado',
    'Divorciado',
    'Viúvo',
  ];

  static List<String> dropDownSexo= [
    'Masculino',
    'Feminino',
  ];
}