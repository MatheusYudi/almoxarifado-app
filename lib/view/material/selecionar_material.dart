import 'package:flutter/material.dart';

import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class SelecionarMaterial extends StatefulWidget {
  const SelecionarMaterial({ Key? key }) : super(key: key);

  @override
  State<SelecionarMaterial> createState() => _SelecionarMaterialState();
}

class _SelecionarMaterialState extends State<SelecionarMaterial> {



  @override
  Widget build(BuildContext context) {

    TextEditingController codigo = TextEditingController();
    TextEditingController descricao = TextEditingController();
    TextEditingController codigoBarras = TextEditingController();
    TextEditingController grupo = TextEditingController();
    
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Selecionar Material'),
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
                                  controller: codigo,
                                  labelText: 'Código',
                                ),
                              ),
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: descricao,
                                  labelText: 'Descrição',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: codigoBarras,
                                  labelText: 'Código de Barras',
                                ),
                              ),
                              Flexible(
                                child: DefaultDropDown(
                                  controller: grupo,
                                  labelText: 'Grupo',
                                  itens: [],
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
                        displayPercentage: 10
                      ),
                      DataGridHeader(
                        link: 'descricao',
                        title: 'Descrição',
                        alignment: Alignment.centerLeft,
                        displayPercentage: 90
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
                            link: 'descricao',
                            display: const Text('Produto 1'),
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