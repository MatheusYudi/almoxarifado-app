import 'dart:convert';

import 'package:almoxarifado/controller/fornecedores_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../enum/e_estados.dart';
import '../../enum/e_regimes_tributarios.dart';
import '../../enum/e_tipo_ie.dart';
import '../../model/fornecedor.dart';
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
  Fornecedor fornecedor = Fornecedor();
  MaskTextInputFormatter cnpjMask = MaskTextInputFormatter(mask: "##.###.###/####-##");
  MaskTextInputFormatter cepMask = MaskTextInputFormatter(mask: "##.###-###");
  bool cepIsLoading = false;
  bool cnpjIsLoading = false;
  dynamic argument;
  bool preenchido = false;

  @override
  void didChangeDependencies() {
    if(!preenchido)
    {
      argument = ModalRoute.of(context)!.settings.arguments;
      if(argument.runtimeType == int)
      {
        fetchFornecedor();
      }
      preenchido = true;
    }
    super.didChangeDependencies();
  }

  fetchFornecedor() async
  {
    fornecedor = await FornecedoresController().getFornecedorById(context, argument);
    cnpj.text = fornecedor.cnpj;
    regimeApuracao.text = fornecedor.regimeTibutario;
    razaoSocial.text = fornecedor.razaoSocial;
    nomeFantasia.text = fornecedor.nomeFantasia;
    tipoIe.text = fornecedor.tipoIe;
    inscricaoEstadual.text = fornecedor.ie;
    cep.text = fornecedor.cep;
    estado.text = fornecedor.estado;
    cidade.text = fornecedor.cidade;
    bairro.text = fornecedor.bairro;
    logradouro.text = fornecedor.rua;
    numero.text = fornecedor.numero.toString();
    complemento.text = fornecedor.complemento;
    setState((){});
  }

  void buscarCnpj() async
  {
    if(cnpjMask.getUnmaskedText() != '')
    {
      setState(() => cnpjIsLoading = true);

      Uri url = Uri.parse('https://brasilapi.com.br/api/cnpj/v1/${cnpjMask.getUnmaskedText()}');
      dynamic response = await http.get(url);
      dynamic jsonResponse = jsonDecode(response.body);
      razaoSocial.text = jsonResponse['razao_social'] ?? '';
      fornecedor.razaoSocial = jsonResponse['razao_social'] ?? '';
      nomeFantasia.text = jsonResponse['nome_fantasia'] ?? '';
      fornecedor.nomeFantasia = jsonResponse['nome_fantasia'] ?? '';
      cep.text = jsonResponse['cep'] == null ? '' : [jsonResponse['cep'].substring(0, 5), '-', jsonResponse['cep'].substring(5)].join('');
      fornecedor.cep = cep.text;
      estado.text = jsonResponse['uf'] ?? '';
      fornecedor.estado = jsonResponse['uf'] ?? '';
      cidade.text = jsonResponse['municipio'] ?? '';
      fornecedor.cidade = jsonResponse['municipio'] ?? '';
      bairro.text = jsonResponse['bairro'] ?? '';
      fornecedor.bairro = jsonResponse['bairro'] ?? '';
      logradouro.text = jsonResponse['logradouro'] ?? '';
      fornecedor.rua = jsonResponse['logradouro'] ?? '';
      complemento.text = jsonResponse['complemento'] ?? '';
      fornecedor.complemento = jsonResponse['complemento'] ?? '';
      numero.text = jsonResponse['numero'] ?? '';
      fornecedor.numero = int.parse(jsonResponse['numero'] ?? '');
      fornecedor.regimeTibutario = '';
      regimeApuracao.text = '';
      tipoIe.text = '';
      inscricaoEstadual.text = '';
      complemento.text = '';

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
                        labelText: 'CNPJ',
                        inputFormatters: [cnpjMask],
                        onChanged: (data) => fornecedor.cnpj = cnpjMask.getUnmaskedText(),
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
                        itens: ERegimesTributarios.values.map((regimeTributario){
                          return DropdownMenuItem(
                            child: Text(regimeTributario.nome),
                            value: regimeTributario.nome,
                            onTap: () => fornecedor.regimeTibutario = regimeTributario.nome,
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
                        controller: razaoSocial,
                        labelText: 'Razão Social',
                        onChanged: (data) => fornecedor.razaoSocial = data,
                      ),
                    ), 
                    Flexible(
                      child: DefaultTextFormField(
                        controller: nomeFantasia,
                        labelText: 'Nome Fantasia',
                        onChanged: (data) => fornecedor.nomeFantasia = data,
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
                        itens: ETipoIe.values.map((tipoIe){
                          return DropdownMenuItem(
                            child: Text(tipoIe.nome),
                            value: tipoIe.nome,
                            onTap: () => fornecedor.tipoIe = tipoIe.nome,
                          );
                        }).toList(),
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: inscricaoEstadual,
                        labelText: 'Inscrição Estadual',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\,?\d{0,2}'))],
                        onChanged: (data) => fornecedor.ie = data,
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
                        inputFormatters: [cepMask],
                        onChanged: (data) => fornecedor.cep = cep.text,
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
                            onTap: () => fornecedor.ie = estado.name,
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
                        controller: logradouro,
                        labelText: 'Logradouro',
                        keyboardType: TextInputType.number,
                        onChanged: (data) => fornecedor.rua = data,
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: numero,
                        labelText: 'Número',
                        onChanged: (data) => fornecedor.numero = int.parse(data),
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: complemento,
                        labelText: 'Complemento',
                        onChanged: (data) => fornecedor.complemento = data,
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
                        onChanged: (data) => fornecedor.cidade = data,
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: bairro,
                        labelText: 'Bairro',
                        onChanged: (data) => fornecedor.bairro = data,
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
                onPressed: () async {
                  FornecedoresController request = FornecedoresController();
                  if(fornecedor.id == null)
                  {
                    await request.postFornecedor(context, fornecedor);
                  }
                  else
                  {
                    await request.updateFornecedor(context, fornecedor);
                  }

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