import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';

import '../../controller/fornecedores_controller.dart';
import '../../model/fornecedor.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_text_form_field.dart';

class Fornecedores extends StatefulWidget {
  const Fornecedores({ Key? key }) : super(key: key);

  @override
  State<Fornecedores> createState() => _FornecedoresState();
}

class _FornecedoresState extends State<Fornecedores> {

  TextEditingController raxaoSocial = TextEditingController();
  TextEditingController cnpj = TextEditingController();
  TextEditingController nomeFantasia = TextEditingController();
  List<Fornecedor> fornecedores = [];
  List<Fornecedor> fornecedoresGrid = [];
  bool fornecedoresLoading = false;

  fetchFornecedores() async {
    setState(() => fornecedoresLoading = true);
    fornecedores = await FornecedoresController().getFornecedores(context);
    fornecedoresGrid = fornecedores;
    setState(() => fornecedoresLoading = false);
  }

  @override
  void initState() {
    fetchFornecedores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Fornecedores'),
      drawer: const DefaultUserDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: raxaoSocial,
                                  labelText: 'Razão Social',
                                ),
                              ),
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
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.add_box_outlined,
                              color: Color(0xFF43a047),
                            ),
                            label: const Text(
                              'Cadastrar',
                              style: TextStyle(color: Color(0xFF43a047)),
                            ),
                            onPressed: () => Navigator.pushNamed(context, Routes.fornecedorForm),
                            style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                              minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: (){
                              fornecedoresGrid = fornecedores
                                .where((fornecedor) =>
                                    fornecedor.cnpj
                                        .toUpperCase()
                                        .contains(cnpj.text.toUpperCase()) &&
                                    fornecedor.razoaSocial
                                        .toUpperCase()
                                        .contains(raxaoSocial.text.toUpperCase())&&
                                    fornecedor.nomeFantasia
                                        .toUpperCase()
                                        .contains(nomeFantasia.text.toUpperCase())
                                ).toList();
                              setState(() {});
                            },
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
                  child: fornecedoresLoading
                  ? const Center(
                    child: SizedBox(child: CircularProgressIndicator()))
                  : DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'cnpj',
                        title: 'Cnpj',
                        displayPercentage: 30,
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'razaoSocial',
                        title: 'Razão Social',
                        displayPercentage: 35,
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'nomeFantasia',
                        title: 'Nome Fantasia',
                        displayPercentage: 35,
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                      ),
                    ],
                    data: fornecedoresGrid.map((fornecedor){
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'cnpj',
                            display: Text(fornecedor.cnpj),
                            textCompareOrder: fornecedor.cnpj,
                            alignment: Alignment.centerLeft
                          ),
                          DataGridRowColumn(
                            link: 'razaoSocial',
                            display: Text(fornecedor.razoaSocial),
                            textCompareOrder: fornecedor.razoaSocial,
                            alignment: Alignment.centerLeft
                          ),
                          DataGridRowColumn(
                            link: 'nomeFantasia',
                            display: Text(fornecedor.nomeFantasia),
                            textCompareOrder: fornecedor.nomeFantasia,
                            alignment: Alignment.centerLeft
                          ),
                        ],
                      );
                    }).toList(),//TesteData.clientes,
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