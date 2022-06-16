import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../controller/entradas_controller.dart';
import '../../model/entrada_model.dart';
import '../../model/fornecedor.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';
import '../../widgets/default_user_drawer.dart';

class GerenciarEntrada extends StatefulWidget {
  const GerenciarEntrada({ Key? key }) : super(key: key);

  @override
  State<GerenciarEntrada> createState() => _GerenciarEntradaState();
}

class _GerenciarEntradaState extends State<GerenciarEntrada> {

  TextEditingController numeroNota = TextEditingController();
  TextEditingController fornecedor = TextEditingController();
  TextEditingController chave = TextEditingController();

  bool entradasLoading = false;
  List<EntradaModel> entradas = [];
  List<EntradaModel> entradasGrid = [];

  Fornecedor? fornecedorSelecionado;

  fetchEntradas() async {
    setState(() => entradasLoading = true);
    entradas = await EntradasController().getEntradas(context);
    entradasGrid = entradas;
    setState(() => entradasLoading = false);
  }

  @override
  void initState() {
    fetchEntradas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Entradas'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: numeroNota,
                                  labelText: 'Número da Nota',
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: DefaultTextFormField(
                                  controller: fornecedor,
                                  labelText: 'Fornecedor',
                                  readOnly: true,
                                  suffixIcon: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.only(
                                        topRight:  Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.search, color: Colors.white),
                                      onPressed: () => Navigator.pushNamed(context, Routes.selecionarFornecedor).then((value) {
                                        fornecedorSelecionado = value as Fornecedor;
                                        if(fornecedorSelecionado != null)
                                        {
                                          fornecedor.text = fornecedorSelecionado!.razaoSocial;
                                        }
                                        setState(() {});
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: chave,
                                  labelText: 'Chave da Nota',
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  keyboardType: TextInputType.number,
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
                            onPressed: () => Navigator.pushNamed(context, Routes.entradaForm).then((value) => fetchEntradas()),
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
                              entradasGrid = entradas.where((entarda){
                                if(entarda.numero.toString()
                                  .toUpperCase()
                                  .contains(numeroNota.text.toUpperCase()))
                                  {
                                    return true;
                                  }
                                  return false;
                              }).toList();
                              entradasGrid = entradasGrid.where((entarda){
                                if(entarda.chave
                                  .toUpperCase()
                                  .contains(chave.text.toUpperCase()))
                                  {
                                    return true;
                                  }
                                  return false;
                              }).toList();
                              entradasGrid = entradasGrid.where((entarda){
                                if(entarda.fornecedor == null || fornecedorSelecionado == null)
                                {
                                  return true;
                                }
                                if(entarda.fornecedor!.id == fornecedorSelecionado!.id)
                                {
                                  return true;
                                }
                                return false;
                              }).toList();
                              setState(() {});
                            },
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
                  child: entradasLoading
                  ? const Center(
                    child: SizedBox(child: CircularProgressIndicator()))
                  : DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'numero',
                        title: 'Número da Nota',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 20,
                      ),
                      DataGridHeader(
                        link: 'fornecedor',
                        title: 'Fornecedor',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 40,
                      ),
                      DataGridHeader(
                        link: 'chave',
                        title: 'Chave',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 30,
                      ),
                      DataGridHeader(
                        link: 'data',
                        title: 'Data',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 10,
                      ),
                    ],
                    data: entradasGrid.map((entrada) {
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'numero',
                            display: Text(entrada.numero.toString()),
                            textCompareOrder: entrada.numero.toString(),
                            alignment: Alignment.centerLeft
                          ),
                          DataGridRowColumn(
                            link: 'fonecedor',
                            display: Text(entrada.fornecedor!.razaoSocial, style: TextStyle(overflow: TextOverflow.ellipsis)),
                            textCompareOrder: entrada.fornecedor!.razaoSocial,
                            alignment: Alignment.centerLeft
                          ),
                          DataGridRowColumn(
                            link: 'chave',
                            display: Text(entrada.chave, style: TextStyle(overflow: TextOverflow.ellipsis)),
                            textCompareOrder: entrada.chave,
                            alignment: Alignment.centerLeft
                          ),
                          DataGridRowColumn(
                            link: 'data',
                            display: Text(DateFormat('dd/MM/yyyy').format(entrada.dataHora!)),
                            textCompareOrder: DateFormat('dd/MM/yyyy').format(entrada.dataHora!),
                            alignment: Alignment.centerLeft
                          ),
                        ]
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
      drawer: const DefaultUserDrawer(),
    );
  }
}