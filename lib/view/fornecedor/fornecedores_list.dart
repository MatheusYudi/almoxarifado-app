import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  TextEditingController razaoSocial = TextEditingController();
  TextEditingController cnpj = TextEditingController();
  MaskTextInputFormatter cnpjMask = MaskTextInputFormatter(mask: "##.###.###/####-##");
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
                                  controller: razaoSocial,
                                  labelText: 'Razão Social',
                                ),
                              ),
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: cnpj,
                                  labelText: 'CNPJ',
                                  inputFormatters: [cnpjMask],
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
                            style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                              minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                            ),
                            onPressed: (){
                              Navigator.pushNamed(context, Routes.fornecedorForm).then((value) => fetchFornecedores());
                            },
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
                                        .contains(cnpjMask.getUnmaskedText().toUpperCase()) &&
                                    fornecedor.razaoSocial
                                        .toUpperCase()
                                        .contains(razaoSocial.text.toUpperCase())&&
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
                        link: 'delete',
                        title: '',
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'edit',
                        title: '',
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'cnpj',
                        title: 'CNPJ',
                        displayPercentage: 20,
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'razaoSocial',
                        title: 'Razão Social',
                        displayPercentage: 30,
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'nomeFantasia',
                        title: 'Nome Fantasia',
                        displayPercentage: 30,
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                      ),
                    ],
                    data: fornecedoresGrid.map((fornecedor){
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'delete',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                FornecedoresController().deleteFornecedor(context, fornecedor.id!).then((value){
                                  fetchFornecedores();
                                });
                              },
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'edit',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.blue,
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                Navigator.pushNamed(context, Routes.fornecedorForm, arguments: fornecedor.id!).then((value){
                                  fetchFornecedores();
                                });
                              },
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'cnpj',
                            display: Text(fornecedor.cnpj),
                            textCompareOrder: fornecedor.cnpj,
                            alignment: Alignment.centerLeft
                          ),
                          DataGridRowColumn(
                            link: 'razaoSocial',
                            display: Text(fornecedor.razaoSocial),
                            textCompareOrder: fornecedor.razaoSocial,
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