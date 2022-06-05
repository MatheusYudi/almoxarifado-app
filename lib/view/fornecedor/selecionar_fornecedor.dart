import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../controller/fornecedores_controller.dart';
import '../../model/fornecedor.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
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

  bool fornecedoresLoading = false;
  List<Fornecedor> fornecedores = [];
  List<Fornecedor> fornecedoresGrid = [];

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: cnpj,
                                  labelText: 'Cnpj',
                                  inputFormatters: [MaskTextInputFormatter(mask: "##.###.###/####-##")],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  child: const Icon(Icons.search),
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                                  ),
                                  onPressed: (){
                                    fornecedoresGrid = fornecedores
                                      .where((fornecedor) => fornecedor.razaoSocial
                                            .toUpperCase()
                                            .contains(razaoSocial.text.toUpperCase()) &&
                                        fornecedor.nomeFantasia
                                            .toUpperCase()
                                            .contains(nomeFantasia.text.toUpperCase()) &&
                                        fornecedor.cnpj
                                            .toUpperCase()
                                            .contains(cnpj.text.toUpperCase())
                                      ).toList();
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                        link: 'select',
                        alignment: Alignment.center,
                        sortable: false,
                        enableSearch: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'cnpj',
                        title: 'Cnpj',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 20,
                      ),
                      DataGridHeader(
                        link: 'razaoSocial',
                        title: 'Razão Social',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 35,
                      ),
                      DataGridHeader(
                        link: 'nomeFantasia',
                        title: 'Nome Fantasia',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 35,
                      ),
                    ],
                    data: fornecedoresGrid.map((fornecedor){
                      return DataGridRow(
                        onDoubleTap: () => Navigator.pop(context, fornecedor),
                        columns: [
                          DataGridRowColumn(
                            link: 'select',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.ads_click),
                              onPressed: () => Navigator.pop(context, fornecedor),
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'cnpj',
                            display: Text(fornecedor.cnpj),
                            textCompareOrder: fornecedor.cnpj,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'razaoSocial',
                            display: Text(fornecedor.razaoSocial),
                            textCompareOrder: fornecedor.razaoSocial,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'nomeFantasia',
                            display: Text(fornecedor.nomeFantasia),
                            textCompareOrder: fornecedor.nomeFantasia,
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      );
                    }).toList(),
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