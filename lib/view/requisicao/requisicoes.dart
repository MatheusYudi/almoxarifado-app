import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/funcionario_atual_controller.dart';
import '../../controller/funcionarios_controller.dart';
import '../../controller/requisicoes_controller.dart';
import '../../model/funcionario.dart';
import '../../model/grupo_acesso.dart';
import '../../model/requisicao.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class Requisicoes extends StatefulWidget {
  const Requisicoes({ Key? key }) : super(key: key);

  @override
  State<Requisicoes> createState() => _RequisicoesState();
}

class _RequisicoesState extends State<Requisicoes> {

  TextEditingController dataInicio = TextEditingController();
  TextEditingController dataFim = TextEditingController();
  TextEditingController requisitante = TextEditingController();
  TextEditingController status = TextEditingController();

  bool requisicoesLoading = false;
  List<Requisicao> requisicoes = [];
  List<Requisicao> requisicoesGrid = [];

  bool funcionariosLoading = false;
  List<Funcionario> funcionarios = [];
  Funcionario? funcionarioSelecionado;
  GrupoAcesso? permissao;

  fetchRequisicoes() async
  {
    setState(() => requisicoesLoading = true);
    if(permissao != null && permissao?.nome == "Requisitante")
    {
      requisicoes = await FuncionariosController().getRequisicoes(context, Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual());
    }
    else
    {
      requisicoes = await RequisicoesController().getRequisicoes(context);
    }
    requisicoesGrid = requisicoes;
    setState(() => requisicoesLoading = false);
  }

  fetchFuncionarios() async
  {
    setState(() => funcionariosLoading = true);
    funcionarios = await FuncionariosController().getFuncionarios(context);
    funcionarios.insert(0, Funcionario(nome: 'Todos'));
    setState(() => funcionariosLoading = false);
  }

  @override
  void initState() {
    permissao = Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().grupoAcesso;
    fetchRequisicoes();
    fetchFuncionarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Requisi????es'),
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
                          Column(
                            children: [
                              const Text('Per??odo', style: TextStyle(color: Colors.white),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          dynamic dataInicioParse;
                                          if(dataInicio.text.isNotEmpty)
                                          {
                                            dataInicioParse = DateTime.parse("${dataInicio.text.split('/')[2]}-${dataInicio.text.split('/')[1]}-${dataInicio.text.split('/')[0]} 00:00:00");
                                          }
                                          showDatePicker(
                                            context: context,
                                            initialDate: dataInicioParse ?? DateTime.now(),
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
                                      labelText: 'At??',
                                      suffixIcon: IconButton(
                                        padding: const EdgeInsets.all(8.0),
                                        onPressed: (){
                                          dynamic dataFimParse;
                                          if(dataFim.text.isNotEmpty)
                                          {
                                            dataFimParse = DateTime.parse("${dataFim.text.split('/')[2]}-${dataFim.text.split('/')[1]}-${dataFim.text.split('/')[0]} 00:00:00");
                                          }
                                          showDatePicker(
                                            context: context,
                                            initialDate: dataFimParse ?? DateTime.now(),
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultDropDown(
                                  controller: requisitante,
                                  labelText: 'Requisitante',
                                  itens: funcionarios.map((funcionario){
                                    return funcionario.id == null
                                    ?  DropdownMenuItem(
                                        value: funcionario.nome,
                                        child: Text(funcionario.nome),
                                        onTap: () => funcionarioSelecionado = null,
                                      )
                                    :  DropdownMenuItem(
                                      value: funcionario.nome,
                                      child: Text(funcionario.nome),
                                      onTap: () => funcionarioSelecionado = funcionario,
                                    );
                                  }).toList(),
                                ),
                              ),
                              Flexible(
                                child: DefaultDropDown(
                                  controller: status,
                                  labelText: 'Aprovada?',
                                  itens: [
                                    DropdownMenuItem(
                                      value: 'Sim',
                                      child: const Text('Sim'),
                                      onTap: () => status.text =  'Sim',
                                    ),
                                    DropdownMenuItem(
                                      value: 'N??o',
                                      child: const Text('N??o'),
                                      onTap: () => status.text = 'N??o',
                                    ),
                                  ]
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
                            onPressed: () => Navigator.pushNamed(context, Routes.requisicaoForm).then((value) => fetchRequisicoes()),
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
                              requisicoesGrid = requisicoes.where((requisicao){
                                if(requisicao.requisitante == null || funcionarioSelecionado == null)
                                {
                                  return true;
                                }
                                if(requisicao.requisitante!.id == funcionarioSelecionado!.id)
                                {
                                  return true;
                                }
                                return false;
                              }).toList();
                              requisicoesGrid = requisicoesGrid.where((requisicao){
                                if(requisicao.aprovada
                                .toUpperCase()
                                .contains(status.text.toUpperCase()))
                                {
                                  return true;
                                }
                                return false;
                              }).toList();
                              requisicoesGrid = requisicoesGrid.where((requisicao){
                                if(dataInicio.text.isEmpty || dataFim.text.isEmpty)
                                {
                                  return true;
                                }
                                DateTime dataInicioParse = DateTime.parse("${dataInicio.text.split('/')[2]}-${dataInicio.text.split('/')[1]}-${dataInicio.text.split('/')[0]} 00:00:00");
                                DateTime dataFimParse = DateTime.parse("${dataFim.text.split('/')[2]}-${dataFim.text.split('/')[1]}-${dataFim.text.split('/')[0]} 23:59:59");

                                if(requisicao.dataHora!.isAfter(dataInicioParse) && requisicao.dataHora!.isBefore(dataFimParse))
                                {
                                  return true;
                                }
                                if(requisicao.dataHora!.isAtSameMomentAs(dataInicioParse) || requisicao.dataHora!.isAtSameMomentAs(dataFimParse))
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
                  child: DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'delete',
                        displayPercentage: 5,
                        sortable: false,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'edit',
                        displayPercentage: 5,
                        sortable: false,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'avaliar',
                        displayPercentage: 5,
                        sortable: false,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'requisitante',
                        title: 'Requisitante',
                        displayPercentage: 65,
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'data',
                        title: 'Data',
                        alignment: Alignment.centerLeft,
                        displayPercentage: 10,
                        enableSearch: false,
                      ),
                      DataGridHeader(
                        link: 'aprovada',
                        title: 'Aprovada?',
                        displayPercentage: 10,
                        enableSearch: false,
                      ),
                    ],
                    data: requisicoesGrid.map((requisicao){
                      return DataGridRow(
                        backgroundColor: requisicao.aprovada == "Sim" ? Colors.green[50] : Colors.red[50],
                        columns: [
                          DataGridRowColumn(
                            link: 'delete',
                            alignment: Alignment.center,
                            display: requisicao.aprovada != 'Sim'
                            ? IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              tooltip: "Excluir",
                              onPressed: () async {
                                RequisicoesController requisicoesController = RequisicoesController();
                                requisicoesController.deleteRequisicao(context, requisicao.id!).then((value){
                                  fetchRequisicoes();
                                  if(value == true)
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          content: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.cancel_outlined, color: Colors.red,),
                                              Text('Requisi????o Deletada')
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  else
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          content: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children:  [
                                              const Icon(Icons.cancel_outlined, color: Colors.red),
                                              Text(requisicoesController.error),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                });
                              },
                            )
                            : const SizedBox.shrink(),
                          ),
                          DataGridRowColumn(
                            link: 'edit',
                            alignment: Alignment.center,
                            display: permissao != null && permissao?.nome == "Funcion??rio"
                            ? const SizedBox.shrink()
                            : requisicao.aprovada != 'Sim'
                            ? IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.blue,
                              icon: const Icon(Icons.edit),
                              tooltip: "Alterar",
                              onPressed: () async {
                                Navigator.pushNamed(context, Routes.requisicaoForm, arguments: requisicao.id!).then((value){
                                  fetchRequisicoes();
                                });
                              },
                            )
                            : const SizedBox.shrink(),
                          ),
                          DataGridRowColumn(
                            link: 'avaliar',
                            display: permissao != null && permissao?.nome == "Requisitante"
                            ? const SizedBox.shrink()
                            : requisicao.aprovada != 'Sim'
                            ? IconButton(
                              padding: EdgeInsets.zero,
                              color: Theme.of(context).primaryColor,
                              icon: const Icon(Icons.check),
                              tooltip: "Aprovar",
                              onPressed: () async {
                                Navigator.pushNamed(context, Routes.avaliarRequisicao, arguments: requisicao.id).then((value){
                                    fetchRequisicoes();
                                    if(value == true)
                                    {
                                      showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            content: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                Icon(Icons.check_circle_outline_rounded, color: Colors.green,),
                                                Text('Requisi????o aprovada')
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                );
                              },
                            )
                            : const SizedBox.shrink(),
                          ),
                          DataGridRowColumn(
                            link: 'requisitante',
                            display: Text(requisicao.requisitante!.nome),
                            textCompareOrder: requisicao.requisitante!.nome,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'data',
                            display: Text(DateFormat('dd/MM/yyyy').format(requisicao.dataHora!)),
                            textCompareOrder: DateFormat('dd/MM/yyyy').format(requisicao.dataHora!),
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'aprovada',
                            display: Text(requisicao.aprovada, style: TextStyle(color: requisicao.aprovada == "Sim" ? Colors.green : Colors.red)),
                            textCompareOrder: requisicao.aprovada,
                          )
                        ]
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
      drawer: const DefaultUserDrawer(),
    );
  }
}