import 'package:almoxarifado/view/movimentacao/saida_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../controller/funcionarios_controller.dart';
import '../../controller/grupo_material_controller.dart';
import '../../controller/movimentacoes_controller.dart';

import '../../model/funcionario.dart';
import '../../model/grupo_material.dart';
import '../../model/movimentacao.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';
import '../../widgets/default_user_drawer.dart';

class Movimentacoes extends StatefulWidget {
  const Movimentacoes({ Key? key }) : super(key: key);

  @override
  State<Movimentacoes> createState() => _MovimentacoesState();
}

class _MovimentacoesState extends State<Movimentacoes> {

  TextEditingController dataInicio = TextEditingController();
  TextEditingController dataFim = TextEditingController();
  TextEditingController codigo = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController grupo = TextEditingController();
  List<Movimentacao> movimentacoes = [];
  List<Movimentacao> movimentacoesGrid = [];
  Funcionario? funcionarioSelecionado;
  GrupoMaterial? grupoSelecionado;
  List<Funcionario> funcionarios = [];
  List<GrupoMaterial> gruposMaterial = [];
  bool movimentacoesLoading = false;
  bool gruposMaterialLoading = false;
  bool funcionariosLoading = false;

  fetchMovimentacoes() async {
    setState(() => movimentacoesLoading = true);
    movimentacoes = await MovimentacoesController().getMovimentacoes(context);
    movimentacoesGrid = movimentacoes;
    setState(() => movimentacoesLoading = false);
  }
  fetchGruposMaterial() async {
    setState(() => gruposMaterialLoading = true);
    gruposMaterial = await GruposMaterialController().getGruposMaterial(context);
    setState(() => gruposMaterialLoading = false);
  }
  fetchFuncionarios() async {
    setState(() => funcionariosLoading = true);
    funcionarios = await FuncionariosController().getFuncionarios(context);
    setState(() => funcionariosLoading = false);
  }

  @override
  void initState() {
    fetchMovimentacoes();
    fetchGruposMaterial();
    fetchFuncionarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Consultar Movimentações'),
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
                                  controller: dataInicio,
                                  keyboardType: TextInputType.datetime,
                                  inputFormatters: [MaskTextInputFormatter(mask: "##/##/####")],
                                  labelText: 'De',
                                  suffixIcon: IconButton(
                                    padding: const EdgeInsets.all(8.0),
                                    onPressed: (){
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      ).then((value){
                                        if(value != null)
                                        {
                                          setState(() => dataInicio.text = DateFormat("dd/MM/yyyy").format(value));
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.date_range_rounded, size: 20),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: dataFim,
                                  keyboardType: TextInputType.datetime,
                                  inputFormatters: [MaskTextInputFormatter(mask: "##/##/####")],
                                  labelText: 'Até',
                                  suffixIcon: IconButton(
                                    padding: const EdgeInsets.all(8.0),
                                    onPressed: (){
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      ).then((value){
                                        if(value != null)
                                        {
                                          setState(() => dataFim.text = DateFormat("dd/MM/yyyy").format(value));
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.date_range_rounded, size: 20),
                                  ),
                                )
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 2,
                                child: DefaultTextFormField(
                                  controller: nome,
                                  labelText: 'Material',
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: DefaultDropDown(
                                  controller: grupo,
                                  labelText: 'Grupo',
                                  maximunItensShown: 5,
                                  itens: gruposMaterial.map((grupoMaterial){
                                    return DropdownMenuItem(
                                      value: grupoMaterial.nome,
                                      child: Text(grupoMaterial.nome),
                                      onTap: () => setState(() => grupoSelecionado = grupoMaterial),
                                    );
                                  }).toList(),
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
                              Icons.outbond_outlined,
                              color: Colors.blue,
                            ),
                            label: const Text(
                              'Saída',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const SaidaForm(),
                              ).then((value) => fetchMovimentacoes());
                            },
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
                              movimentacoesGrid = movimentacoes.where((movimentacao){
                                if(movimentacao.material!.nome
                                  .toUpperCase()
                                  .contains(nome.text.toUpperCase()))
                                  {
                                    return true;
                                  }
                                  return false;
                              }).toList();
                              movimentacoesGrid = movimentacoesGrid.where((movimentacao){
                                if(movimentacao.material!.grupoMaterial == null || grupoSelecionado == null)
                                {
                                  return true;
                                }
                                if(movimentacao.material!.grupoMaterial!.id == grupoSelecionado!.id)
                                {
                                  return true;
                                }
                                return false;
                              }).toList();
                              movimentacoesGrid = movimentacoesGrid.where((movimentacao){
                                if(dataInicio.text.isEmpty || dataFim.text.isEmpty)
                                {
                                  return true;
                                }
                                DateTime dataInicioParse = DateTime.parse("${dataInicio.text.split('/')[2]}-${dataInicio.text.split('/')[1]}-${dataInicio.text.split('/')[0]}");
                                DateTime dataFimParse = DateTime.parse("${dataFim.text.split('/')[2]}-${dataFim.text.split('/')[1]}-${dataFim.text.split('/')[0]}");
                                if(movimentacao.dataHora!.isAfter(dataInicioParse) && movimentacao.dataHora!.isBefore(dataFimParse))
                                {
                                  return true;
                                }
                                return false;
                              }).toList();
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
                  child: movimentacoesLoading
                  ? const Center(
                    child: SizedBox(child: CircularProgressIndicator()))
                  : DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'funcionario',
                        title: 'Funcionário',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 20,
                      ),
                      DataGridHeader(
                        link: 'material',
                        title: 'Material',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 20,
                      ),
                      DataGridHeader(
                        link: 'qtd',
                        title: 'Quantidade',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'tipo',
                        title: 'Tipo',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 20,
                      ),
                      DataGridHeader(
                        link: 'motivo',
                        title: 'Motivo',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 20,
                      ),
                      DataGridHeader(
                        link: 'data',
                        title: 'Data',
                        enableSearch: false,
                        alignment: Alignment.centerLeft,
                        displayPercentage: 10,
                      ),
                    ],
                    data: movimentacoesGrid.map((movimentacao){
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'usuario',
                            display: Text(movimentacao.funcionario!.nome),
                            textCompareOrder: movimentacao.funcionario!.nome,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'material',
                            display: Text(movimentacao.material!.nome),
                            textCompareOrder: movimentacao.material!.nome,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'qtd',
                            display: Text(movimentacao.quantidadeMovimentada.toString()),
                            textCompareOrder: movimentacao.quantidadeMovimentada.toString(),
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'tipo',
                            display: Text(movimentacao.tipo),
                            textCompareOrder: movimentacao.tipo,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'motivo',
                            display: Text(movimentacao.motivo),
                            textCompareOrder: movimentacao.motivo,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'data',
                            display: Text(DateFormat('dd/MM/yyyy').format(movimentacao.dataHora!)),
                            textCompareOrder: DateFormat('dd/MM/yyyy').format(movimentacao.dataHora!),
                            alignment: Alignment.centerLeft,
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
    );
  }
}