import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controller/grupo_material_controller.dart';
import '../../controller/materiais_controller.dart';
import '../../controller/ncm_controller.dart';
import '../../enum/e_unidade.dart';
import '../../model/grupo_material.dart';
import '../../model/material_model.dart';
import '../../model/ncm_model.dart';
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

  MaterialModel material = MaterialModel();

  List<GrupoMaterial> gruposMaterial = [];
  bool gruposMaterialLoading = false;
  GrupoMaterial? grupoAcessoSelecionado;

  List<NcmModel> ncms = [];
  bool ncmsLoading = false;
  GrupoMaterial? ncmSelecionado;
  NcmController ncmController = NcmController();

  bool preenchido = false;
  dynamic argument;

  fetchGruposMaterial() async {
    setState(() => gruposMaterialLoading = true);
    gruposMaterial = await GruposMaterialController().getGruposMaterial(context);
    setState(() => gruposMaterialLoading = false);
  }

  fetchMaterial() async {
    material = await MateriaisController().getMaterialById(context, argument);
    nome.text = material.nome;
    unidade.text = material.unidade;
    valorUnitario.text = material.valorUnitario.toString();
    codigoBarras.text = material.codigoBarras;
    ncm.text = material.ncm;
    estoqueMinimo.text = material.estoqueMinimo.toString();
    quantidadeEstoque.text = material.qtdeEstoque.toString();
    grupoAcessoSelecionado = material.grupoMaterial;
    grupo.text = material.grupoMaterial == null ? '' : material.grupoMaterial!.nome;
    setState((){});
  }

  fetchNcm() async
  {
    ncms = await ncmController.getNcms(context);
    setState(() {});
  }

  @override
  void initState() {
    fetchGruposMaterial();
    fetchNcm();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!preenchido)
    {
      argument = ModalRoute.of(context)!.settings.arguments;
      if(argument.runtimeType == int)
      {
        argument = ModalRoute.of(context)!.settings.arguments;
        fetchMaterial();
      }
      preenchido = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Material'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight - 18,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: nome,
                        labelText: 'Nome',
                        onChanged: (data) => material.nome = data,
                      ),
                    ),
                    Flexible(
                      child: DefaultDropDown(
                        controller: grupo,
                        labelText: 'Grupo',
                        maximunItensShown: 5,
                        itens: gruposMaterial.map((grupoMaterial){
                          return DropdownMenuItem(
                            value: grupoMaterial.nome,
                            child: Text(grupoMaterial.nome),
                            onTap: () => material.grupoMaterial = grupoMaterial,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultDropDown(
                        controller: unidade,
                        labelText: 'Unidade',
                        maximunItensShown: 5,
                        itens: EUnidade.values.map((unidade){
                          return DropdownMenuItem(
                            value: unidade.name,
                            child: Text(unidade.name),
                            onTap: () => material.unidade = unidade.name,
                          );
                        }).toList(),
                      ),
                    ), 
                    Flexible(
                      child: DefaultTextFormField(
                        controller: valorUnitario,
                        labelText: 'Valor Unit??rio',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                        onChanged: (data) => material.valorUnitario = double.parse(data),
                      ),
                    ),                  
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: codigoBarras,
                        labelText: 'C??digo de Barras',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (data) => material.codigoBarras = data,
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: ncm,
                        labelText: 'NCM',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (data) => material.ncm = data,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextFormField(
                        controller: estoqueMinimo,
                        labelText: 'Estoque M??nimo',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                        onChanged: (data) => material.estoqueMinimo = double.parse(data),
                      ),
                    ),
                    Flexible(
                      child: DefaultTextFormField(
                        controller: quantidadeEstoque,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
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
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(const Size(130, 50)),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                backgroundColor: MaterialStateProperty.all(const Color(0xFF43a047)),
              ),
              onPressed: () async {
                MateriaisController request = MateriaisController();
                if(material.id == null)
                {
                  await request.postMaterial(context, material);
                }
                else
                {
                  await request.updateMaterial(context, material);
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