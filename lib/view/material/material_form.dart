import 'package:flutter/material.dart';

import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';


class MaterialForm extends StatefulWidget {
  const MaterialForm({ Key? key }) : super(key: key);

  @override
  State<MaterialForm> createState() => _MaterialFormState();
}

class _MaterialFormState extends State<MaterialForm> {

  TextEditingController nome = TextEditingController();
  TextEditingController grupo = TextEditingController();
  TextEditingController quantidade = TextEditingController();
  TextEditingController unidade = TextEditingController();
  TextEditingController valorUnitario = TextEditingController();
  TextEditingController codigoBarras = TextEditingController();
  TextEditingController ncm = TextEditingController();
  TextEditingController estoqueMinimo = TextEditingController();
  TextEditingController quantidadeEstoque = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Mateiral'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: nome,
                        labelText: 'Nome',
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
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: quantidade,
                        labelText: 'Quantidade',
                        keyboardType: TextInputType.number,
                      ),
                    ), 
                    Flexible(
                      child: DefaultDropDown(
                        controller: unidade,
                        labelText: 'Unidade',
                        itens: [],
                      ),
                    ), 
                    Flexible(
                      child: DefaultTextFormField(
                        controller: valorUnitario,
                        labelText: 'Valor Unitário',
                        keyboardType: TextInputType.number,
                      ),
                    ),                  
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: codigoBarras,
                        labelText: 'Codigo de Barras',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Flexible(
                      child: DefaultDropDown(
                        controller: ncm,
                        labelText: 'Ncm',
                        itens: [],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: estoqueMinimo,
                        labelText: 'Estoque Mínimo',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: quantidadeEstoque,
                        labelText: 'Quantidade de Estoque',
                        enabled: false,
                      ),
                    ),
                  ],
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
              onPressed: () {},
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.cancel),
              label: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}