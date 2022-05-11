import 'package:flutter/material.dart';

import '../widgets/data_grid.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_dropdown.dart';
import '../widgets/default_text_form_field.dart';
import '../widgets/default_user_drawer.dart';

class Materiais extends StatefulWidget {
  const Materiais({ Key? key }) : super(key: key);

  @override
  State<Materiais> createState() => _MateriaisState();
}

class _MateriaisState extends State<Materiais> {

  TextEditingController fornecedor = TextEditingController();
  TextEditingController grupo = TextEditingController();
  TextEditingController nome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Materiais'),
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
                                child: DefaultDropDown(
                                  controller: fornecedor,
                                  labelText: 'Fornecedor',
                                  itens: [],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: nome,
                                  labelText: 'Nome',
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
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: (){},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(Icons.forward_to_inbox_sharp, color: Colors.blue),
                                Text('Solicitar compra', style: TextStyle(color: Colors.blue),),
                              ],
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(170, 50)),
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                            ),
                          ),
                        ),
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