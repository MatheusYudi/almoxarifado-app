import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/data_grid.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_dropdown.dart';
import '../widgets/default_text_form_field.dart';

class Funcionarios extends StatefulWidget {
  const Funcionarios({ Key? key }) : super(key: key);

  @override
  State<Funcionarios> createState() => _FuncionariosState();
}

class _FuncionariosState extends State<Funcionarios> {

  TextEditingController cpf = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController permissao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Funcionarios'),
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
                                  labelText: 'Cpf',
                                ),
                              ),
                              Flexible(
                                child: DefaultDropDown(
                                  controller: permissao,
                                  labelText: 'Permissão',
                                  itens: [],
                                )
                              ),
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
                          child: ElevatedButton(
                            onPressed: (){},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children:  [
                                Container(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: const Icon(
                                    Icons.add_box_outlined,
                                    color: Color(0xFF43a047),
                                  ),
                                ),
                                const Flexible(
                                  fit: FlexFit.tight,
                                  child: Text(
                                    'Cadastrar',
                                    style: TextStyle(color: Color(0xFF43a047)),
                                  ),
                                ),
                              ],
                            ),
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
                    headers: const [],
                    data: const [],//TesteData.clientes,
                    width: MediaQuery.of(context).size.width - 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: const DefaultUserDrawer(),
    );
  }
}