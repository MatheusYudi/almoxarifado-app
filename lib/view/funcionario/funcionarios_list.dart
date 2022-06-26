import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../controller/funcionarios_controller.dart';
import '../../controller/grupos_acesso_controller.dart';
import '../../model/funcionario.dart';
import '../../model/grupo_acesso.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class Funcionarios extends StatefulWidget {
  const Funcionarios({Key? key}) : super(key: key);

  @override
  State<Funcionarios> createState() => _FuncionariosState();
}

class _FuncionariosState extends State<Funcionarios> {
  TextEditingController cpf = TextEditingController();
  TextEditingController nome = TextEditingController();
  List<Funcionario> funcionarios = [];
  List<Funcionario> funcionariosGrid = [];
  List<GrupoAcesso> gruposAcesso = [];
  GrupoAcesso? grupoAcessoSelecionado;
  bool funcionariosLoading = false;
  bool gruposAcessoLoading = false;

  fetchFuncionarios() async {
    setState(() => funcionariosLoading = true);
    funcionarios = await FuncionariosController().getFuncionarios(context);
    funcionariosGrid = funcionarios;
    setState(() => funcionariosLoading = false);
  }
  fetchGruposAcesso() async {
    setState(() => gruposAcessoLoading = true);
    gruposAcesso = await GruposAcessoController().getGruposAcesso(context);
    setState(() => gruposAcessoLoading = false);
  }

  @override
  void initState() {
    fetchGruposAcesso();
    fetchFuncionarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Funcionários'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: cpf,
                                  labelText: 'CPF',
                                  inputFormatters: [MaskTextInputFormatter(mask: "###.###.###-##")],
                                ),
                              ),
                              Flexible(
                                child: DefaultDropDown(
                                controller: TextEditingController(
                                  text: grupoAcessoSelecionado == null 
                                    ? ''
                                    : grupoAcessoSelecionado!.nome
                                ),
                                labelText: 'Grupo de Acesso',
                                itens: gruposAcesso.map((grupoAcesso){
                                  return DropdownMenuItem(
                                    value: grupoAcesso.nome,
                                    child: Text(grupoAcesso.nome),
                                    onTap: () => setState(() => grupoAcessoSelecionado = grupoAcesso),
                                  );
                                }).toList(),
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: nome,
                                  labelText: 'Nome',
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
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.funcionarioForm).then((value) => fetchFuncionarios());
                            },
                            style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all(
                                  const Size(130, 50)),
                              minimumSize:
                                  MaterialStateProperty.all(const Size(0, 50)),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).cardColor),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () {
                              funcionariosGrid = funcionarios.where((funcionario){
                                if(funcionario.grupoAcesso == null || grupoAcessoSelecionado == null)
                                {
                                  return true;
                                }
                                if(funcionario.grupoAcesso!.id == grupoAcessoSelecionado!.id)
                                {
                                  return true;
                                }
                                return false;
                              }).toList();
                              funcionariosGrid = funcionariosGrid.where((funcionario){
                                if(funcionario.cpf
                                  .toUpperCase()
                                  .contains(cpf.text.toUpperCase()))
                                  {
                                    return true;
                                  }
                                  return false;
                              }).toList();
                              funcionariosGrid = funcionariosGrid.where((funcionario){
                                if(funcionario.nome
                                  .toUpperCase()
                                  .contains(nome.text.toUpperCase()))
                                  {
                                    return true;
                                  }
                                  return false;
                              }).toList();
                              setState(() {});
                            },
                            child: const Icon(Icons.search),
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(const Size(50, 50)),
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
                  child: funcionariosLoading
                    ? const Center(
                        child: SizedBox(child: CircularProgressIndicator()))
                    : DataGrid(
                        headers: [
                          DataGridHeader(
                            link: 'delete',
                            title: '',
                            enableSearch: false,
                            sortable: false,
                            displayPercentage: 5,
                          ),
                          DataGridHeader(
                            link: 'edit',
                            title: '',
                            enableSearch: false,
                            sortable: false,
                            displayPercentage: 5,
                          ),
                          DataGridHeader(
                            link: 'cpf',
                            title: 'CPF',
                            displayPercentage: 20,
                            enableSearch: false,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridHeader(
                            link: 'nome',
                            title: 'Nome',
                            displayPercentage: 40,
                            enableSearch: false,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridHeader(
                            link: 'email',
                            title: 'Email',
                            displayPercentage: 30,
                            enableSearch: false,
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                        data: funcionariosGrid.map((funcionario) {
                          return DataGridRow(columns: [
                            DataGridRowColumn(
                              link: 'delete',
                              alignment: Alignment.center,
                              display: IconButton(
                                padding: EdgeInsets.zero,
                                color: Colors.red,
                                icon: const Icon(Icons.delete),
                                tooltip: "Excluir",
                                onPressed: () async {
                                  FuncionariosController().deleteFuncionario(context, funcionario.id!).then((value){
                                    fetchFuncionarios();
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
                                                Text('Funcionario Deletado')
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
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
                                tooltip: "Alterar",
                                onPressed: () async {
                                  Navigator.pushNamed(context, Routes.funcionarioForm, arguments: funcionario.id).then((value){
                                    fetchFuncionarios();
                                  });
                                },
                              ),
                            ),
                            DataGridRowColumn(
                              link: 'cpf',
                              alignment: Alignment.centerLeft,
                              display: Text(funcionario.cpf, style: const TextStyle(overflow: TextOverflow.ellipsis)),
                              textCompareOrder: funcionario.cpf,
                            ),
                            DataGridRowColumn(
                              link: 'nome',
                              textCompareOrder: funcionario.nome,
                              display: Text(funcionario.nome),
                              alignment: Alignment.centerLeft,
                            ),
                            DataGridRowColumn(
                              link: 'email',
                              textCompareOrder: funcionario.email,
                              display: Text(funcionario.email),
                              alignment: Alignment.centerLeft,
                            ),
                          ]);
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
