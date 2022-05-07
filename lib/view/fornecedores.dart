import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/data_grid.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_text_form_field.dart';

class Fornecedores extends StatefulWidget {
  const Fornecedores({ Key? key }) : super(key: key);

  @override
  State<Fornecedores> createState() => _FornecedoresState();
}

class _FornecedoresState extends State<Fornecedores> {

  TextEditingController raxaoSocial = TextEditingController();
  TextEditingController cnpj = TextEditingController();
  TextEditingController nomeFantasia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Fornecedores'),
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
                          child: ElevatedButton(
                            onPressed: (){},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(Icons.add_box_outlined, color: Color(0xFF43a047)),
                                Text('Novo Fornecedor', style: TextStyle(color: Color(0xFF43a047)),),
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