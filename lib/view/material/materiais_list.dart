import 'package:flutter/material.dart';

import '../../controller/grupo_material_controller.dart';
import '../../controller/materiais_controller.dart';

import '../../model/grupo_material.dart';
import '../../model/material_model.dart';
import '../../util/routes.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';
import '../../widgets/default_user_drawer.dart';

class Materiais extends StatefulWidget {
  const Materiais({ Key? key }) : super(key: key);

  @override
  State<Materiais> createState() => _MateriaisState();
}

class _MateriaisState extends State<Materiais> {

  TextEditingController fornecedor = TextEditingController();
  TextEditingController grupo = TextEditingController();
  TextEditingController nome = TextEditingController();
  List<MaterialModel> materiais = [];
  List<MaterialModel> materiaisGrid = [];
  List<GrupoMaterial> gruposMaterial= [];
  GrupoMaterial? grupoMaterialSelecionado;
  bool materiaisLoading = false;
  bool gruposAcessoLoading = false;

  fetchMateriais() async {
    setState(() => materiaisLoading = true);
    materiais = await MateriaisController().getMateriais(context);
    materiaisGrid = materiais;
    setState(() => materiaisLoading = false);
  }
  fetchGruposMaterial() async {
    setState(() => gruposAcessoLoading = true);
    gruposMaterial = await GruposMaterialController().getGruposMaterial(context);
    setState(() => gruposAcessoLoading = false);
  }

  @override
  void initState() {
    fetchMateriais();
    fetchGruposMaterial();
    super.initState();
  }

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
                                  itens: gruposMaterial.map((grupoMaterial){
                                    return DropdownMenuItem(
                                      value: grupoMaterial.nome,
                                      child: Text(grupoMaterial.nome),
                                      onTap: () => setState(() => grupoMaterialSelecionado = grupoMaterial),
                                    );
                                  }).toList(),
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
                                  onPressed: (){
                                    materiaisGrid = materiais
                                      .where((material) =>
                                          material.nome
                                              .toUpperCase()
                                              .contains(nome.text.toUpperCase()) &&
                                          grupoMaterialSelecionado != null &&
                                          material.grupoMaterial != null &&
                                          material.grupoMaterial?.id == grupoMaterialSelecionado?.id
                                      ).toList();
                                    setState(() {});
                                  },
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
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.forward_to_inbox_sharp, color: Colors.blue),
                            label: const Text('Solicitar compra', style: TextStyle(color: Colors.blue),),
                            onPressed: () {},
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(170, 50)),
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                            ),
                          ),
                        ),
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
                            onPressed: () => Navigator.pushNamed(context, Routes.materialForm),
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
                  child: materiaisLoading
                  ? const Center(
                    child: SizedBox(child: CircularProgressIndicator()))
                  : DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'delete',
                        title: '',
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 10,
                      ),
                      DataGridHeader(
                        link: 'nome',
                        title: 'Nome',
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 40,
                      ),
                      DataGridHeader(
                        link: 'preco',
                        title: 'Preço',
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 15,
                      ),
                      DataGridHeader(
                        link: 'codigoBarras',
                        title: 'Código de Barras',
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 20,
                      ),
                      DataGridHeader(
                        link: 'qtdEstoque',
                        title: 'Estoque Atual',
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 15,
                      ),
                    ],
                    data: materiaisGrid.map((material){
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'delete',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                MateriaisController().deleteMaterial(context, material.id!).then((value){
                                  fetchMateriais();
                                });
                              },
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'nome',
                            display: Text(material.nome),
                            textCompareOrder: material.nome,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'preco',
                            display: Text(material.valorUnitario.toStringAsFixed(2)),
                            textCompareOrder: material.valorUnitario.toStringAsFixed(2),
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'codigoBarras',
                            display: Text(material.codigoBarras),
                            textCompareOrder: material.codigoBarras,
                            alignment: Alignment.centerLeft,
                          ),
                          DataGridRowColumn(
                            link: 'qtdEstoque',
                            display: Text(material.qtdeEstoque.toString()),
                            textCompareOrder: material.qtdeEstoque.toString(),
                            alignment: Alignment.centerLeft,
                          ),
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