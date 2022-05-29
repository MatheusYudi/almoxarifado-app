import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../enum/e_estados.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';
import 'package:http/http.dart' as http;

class FornecedorForm extends StatefulWidget {
  const FornecedorForm({ Key? key }) : super(key: key);

  @override
  State<FornecedorForm> createState() => _FornecedorFormState();
}

class _FornecedorFormState extends State<FornecedorForm> {

  TextEditingController cnpj = TextEditingController();
  TextEditingController regimeApuracao = TextEditingController();
  TextEditingController razaoSocial = TextEditingController();
  TextEditingController nomeFantasia = TextEditingController();
  TextEditingController tipoIe = TextEditingController();
  TextEditingController inscricaoEstadual = TextEditingController();
  TextEditingController cep = TextEditingController();
  TextEditingController estado = TextEditingController();
  TextEditingController cidade = TextEditingController();
  TextEditingController bairro = TextEditingController();
  TextEditingController logradouro = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController complemento = TextEditingController();
  bool cepIsLoading = false;
  bool cnpjIsLoading = false;

  void buscarCnpj() async
  {
    if(cnpj.text != '')
    {
      setState(() => cnpjIsLoading = true);

      Uri url = Uri.parse('https://brasilapi.com.br/api/cnpj/v1/${cnpj.text}');
      dynamic response = await http.get(url);
      dynamic jsonResponse = jsonDecode(response.body);
      razaoSocial.text = jsonResponse['razao_social'] ?? '';
      nomeFantasia.text = jsonResponse['nome_fantasia'] ?? '';
      cep.text = jsonResponse['cep'] ?? '';
      estado.text = jsonResponse['uf'] ?? '';
      cidade.text = jsonResponse['municipio'] ?? '';
      bairro.text = jsonResponse['bairro'] ?? '';
      logradouro.text = jsonResponse['logradouro'] ?? '';
      complemento.text = jsonResponse['complemento'] ?? '';
      numero.text = jsonResponse['numero'] ?? '';

      setState(() => cnpjIsLoading = false);
    }
  }

  void buscarCep() async
  {
    if(cep.text != '')
    {
      setState(() => cepIsLoading = true);

      Uri url = Uri.parse('https://brasilapi.com.br/api/cep/v1/${cep.text}');
      dynamic response = await http.get(url);
      dynamic jsonResponse = jsonDecode(response.body);
      estado.text = jsonResponse['state'] ?? '';
      cidade.text = jsonResponse['city'] ?? '';
      bairro.text = jsonResponse['neighborhood'] ?? '';
      logradouro.text = jsonResponse['street'] ?? '';

      setState(() => cepIsLoading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Fornecedor'),
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
                      child: DefaultTextFormField(
                        controller: cnpj,
                        labelText: 'Cnpj',
                        suffixIcon: cnpjIsLoading
                        ? Center(
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                        : Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withBlue(100),
                            borderRadius: const BorderRadius.only(
                              topRight:  Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () => buscarCnpj(),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: DefaultDropDown(
                        controller: regimeApuracao,
                        labelText: 'Regime de Apuração',
                        itens: [],
                      ),
                    ),
                  ],
                ),
                Row(
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
                  children: [
                    Flexible(
                      child: DefaultDropDown(
                        controller: tipoIe,
                        labelText: 'Tipo Inscrição Estadual',
                        itens: [],
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: inscricaoEstadual,
                        labelText: 'Inscrição Estadual',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: cep,
                        labelText: 'Cep',
                        keyboardType: TextInputType.number,
                        inputFormatters: [MaskTextInputFormatter(mask: "##.###-###")],
                        suffixIcon: cepIsLoading
                        ? Center(
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                        : Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withBlue(100),
                            borderRadius: const BorderRadius.only(
                              topRight:  Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () => buscarCep(),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: DefaultDropDown(
                        controller: estado,
                        labelText: 'Estado',
                        maximunItensShown: 5,
                        searchable: true,
                        itens: EEstados.values.map((estado) {
                          return DropdownMenuItem(
                            value: estado.name,
                            child: Text(estado.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: cidade,
                        labelText: 'Cidade',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: bairro,
                        labelText: 'Bairro',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: logradouro,
                        labelText: 'Logradouro',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: numero,
                        labelText: 'Número',
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: complemento,
                        labelText: 'Complemento',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
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
      ),
    );
  }
}