import 'package:almoxarifado/controller/entradas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/entrada_model.dart';
import '../../model/fornecedor.dart';
import '../../model/material_entrada.dart';
import '../../model/material_model.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_text_form_field.dart';

class EntradaForm extends StatefulWidget {
  const EntradaForm({ Key? key }) : super(key: key);

  @override
  State<EntradaForm> createState() => _EntradaFormState();
}

class _EntradaFormState extends State<EntradaForm> {

  TextEditingController numeroNota = TextEditingController();
  TextEditingController chave = TextEditingController();
  TextEditingController fornecedor = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController quantidade = TextEditingController();

  EntradaModel entrada = EntradaModel();

  MaterialModel? materialSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Entrada'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: numeroNota,
                                  labelText: 'Número da Nota',
                                  keyboardType: TextInputType.number,
                                  onChanged: (data) => entrada.numero = int.parse(data),
                                 ),
                              ),
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: chave,
                                  labelText: 'Chave da Nota',
                                  keyboardType: TextInputType.number,
                                  onChanged: (data) => entrada.chave = data,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
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
                                        entrada.fornecedor = value as Fornecedor;
                                        if(entrada.fornecedor != null)
                                        {
                                          fornecedor.text = entrada.fornecedor!.razaoSocial;
                                        }
                                        setState(() {});
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: DefaultTextFormField(
                        controller: nome,
                        labelText: 'Nome',
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
                            onPressed: () => Navigator.pushNamed(context, Routes.selecionarMaterial).then((value) {
                              materialSelecionado = value as MaterialModel;
                              if(materialSelecionado != null)
                              {
                                nome.text = materialSelecionado!.nome;
                              }
                              setState(() {});
                            }),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: quantidade,
                        labelText: 'Quantidade',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\,?\d{0,2}'))],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: const Icon(Icons.add_box_outlined),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                        ),
                        onPressed: (){
                          if(materialSelecionado != null && quantidade.text.isNotEmpty)
                          {
                            entrada.itens!.add(
                              MaterialEntrada(
                                qtd: double.parse(quantidade.text),
                                material: materialSelecionado
                              )
                            );
                            materialSelecionado = null;
                            nome.text = '';
                            quantidade.text = '';
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'delete',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'material',
                        title: 'Material',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 70,
                      ),
                      DataGridHeader(
                        link: 'qtd',
                        title: 'Quantidade',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 20,
                      ),
                    ],
                    data: entrada.itens!.map((item){
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'delete',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                entrada.itens!.removeWhere((itemEntrada) => itemEntrada.material!.id == item.material!.id);
                                setState(() {});
                              },
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'material',
                            alignment: Alignment.centerLeft,
                            display: Text(item.material!.nome),
                          ),
                          DataGridRowColumn(
                            link: 'qtd',
                            alignment: Alignment.centerLeft,
                            display: Text(item.qtd.toString()),
                          ),
                        ]
                      );
                    }).toList(),
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
              ),
              onPressed: () async {
                EntradasController request = EntradasController();
                
                await request.postEntradaModel(context, entrada);

                if(request.error != '')
                {
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text('Algo deu errado'),
                        content: Text(request.error),
                      );
                    },
                  );
                }
                else
                {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.cancel),
              label: const Text('Cancelar'),
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}