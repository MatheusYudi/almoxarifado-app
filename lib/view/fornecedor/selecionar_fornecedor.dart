import 'package:flutter/material.dart';

import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class SelecionarFornecedor extends StatefulWidget {
  const SelecionarFornecedor({ Key? key }) : super(key: key);

  @override
  State<SelecionarFornecedor> createState() => _SelecionarFornecedorState();
}

class _SelecionarFornecedorState extends State<SelecionarFornecedor> {

  TextEditingController razaoSocial = TextEditingController();
  TextEditingController nomeFantasia = TextEditingController();
  TextEditingController cnpj = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Selecionar Fornecedor'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: cnpj,
                                  labelText: 'Cnpj',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: razaoSocial,
                                  labelText: 'Razão Social',
                                ),
                              ),
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: nomeFantasia,
                                  labelText: 'Nome Fantasia',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: (){},
                            child: const Icon(Icons.search),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(               
                  height: MediaQuery.of(context).size.height * 0.65,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'select',
                        alignment: Alignment.center,
                        sortable: false,
                        enableSearch: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'cnpj',
                        title: 'Cnpj',
                        alignment: Alignment.centerLeft,
                        displayPercentage: 20,
                      ),
                      DataGridHeader(
                        link: 'razaoSocial',
                        title: 'Razão Social',
                        alignment: Alignment.centerLeft,
                        displayPercentage: 35,
                      ),
                      DataGridHeader(
                        link: 'nomeFantasia',
                        title: 'Nome Fantasia',
                        alignment: Alignment.centerLeft,
                        displayPercentage: 35,
                      ),
                    ],
                    data: [
                      DataGridRow(
                        onDoubleTap: () => Navigator.pop(context, 'Produto 1'),
                        columns: [
                          DataGridRowColumn(
                            link: 'select',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.ads_click),
                              onPressed: () => Navigator.pop(context, 'Produto 1'),
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'cnpj',
                            display: const Text('Cnpj'),
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'razaoSocial',
                            display: const Text('Razão Social'),
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'nomeFantasia',
                            display: const Text('Nome Fantasia'),
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      ),
                    ],//TesteData.clientes,
                    width: MediaQuery.of(context).size.width - 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}