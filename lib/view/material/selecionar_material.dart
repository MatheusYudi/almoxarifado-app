import 'package:flutter/material.dart';

import '../../controller/grupo_material_controller.dart';
import '../../controller/materiais_controller.dart';
import '../../model/grupo_material.dart';
import '../../model/material_model.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_dropdown.dart';
import '../../widgets/default_text_form_field.dart';

class SelecionarMaterial extends StatefulWidget {
  const SelecionarMaterial({ Key? key }) : super(key: key);

  @override
  State<SelecionarMaterial> createState() => _SelecionarMaterialState();
}

class _SelecionarMaterialState extends State<SelecionarMaterial> {

  TextEditingController codigo = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController codigoBarras = TextEditingController();
  TextEditingController grupo = TextEditingController();

  bool materiaisLoading = false;
  List<MaterialModel> materiais = [];
  List<MaterialModel> materiaisGrid = [];

  bool gruposAcessoLoading = false;
  List<GrupoMaterial> gruposMaterial= [];
  GrupoMaterial? grupoMaterialSelecionado;

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
      appBar: const DefaultAppBar(pageName: 'Selecionar Material'),
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
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: DefaultTextFormField(
                                  controller: codigoBarras,
                                  labelText: 'Código de Barras',
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
                                  child: const Icon(Icons.search),
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                                  ),
                                  onPressed: (){
                                    materiaisGrid = materiais
                                      .where((material) =>
                                        (grupoMaterialSelecionado == null || material.grupoMaterial == null)
                                        ? material.nome
                                              .toUpperCase()
                                              .contains(nome.text.toUpperCase()) &&
                                          material.codigoBarras
                                              .toUpperCase()
                                              .contains(codigoBarras.text.toUpperCase())
                                        : material.nome
                                              .toUpperCase()
                                              .contains(nome.text.toUpperCase()) &&
                                          material.codigoBarras
                                              .toUpperCase()
                                              .contains(codigoBarras.text.toUpperCase())
                                        && material.grupoMaterial?.id == grupoMaterialSelecionado?.id
                                      ).toList();
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                        link: 'select',
                        alignment: Alignment.center,
                        sortable: false,
                        enableSearch: false,
                        displayPercentage: 10
                      ),
                      DataGridHeader(
                        link: 'descricao',
                        title: 'Descrição',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 35
                      ),
                      DataGridHeader(
                        link: 'grupo',
                        title: 'Grupo',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 35
                      ),
                      DataGridHeader(
                        link: 'codigoBarras',
                        title: 'Código de Barras',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 20
                      ),
                    ],
                    data: materiaisGrid.map((material){
                      return DataGridRow(
                        onDoubleTap: () => Navigator.pop(context, material),
                        columns: [
                          DataGridRowColumn(
                            link: 'select',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.ads_click),
                              onPressed: () => Navigator.pop(context, material),
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'descricao',
                            display: Text(material.nome),
                            alignment: Alignment.centerLeft,
                            textCompareOrder: material.nome,
                          ),
                          DataGridRowColumn(
                            link: 'grupo',
                            display: Text(material.grupoMaterial!.nome),
                            alignment: Alignment.centerLeft,
                            textCompareOrder: material.grupoMaterial!.nome,
                          ),
                          DataGridRowColumn(
                            link: 'codigoBarras',
                            display: Text(material.codigoBarras),
                            alignment: Alignment.centerLeft,
                            textCompareOrder: material.codigoBarras,
                          ),
                        ],
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
    );
  }
}