import 'package:flutter/material.dart';

import '../../controller/grupo_material_controller.dart';
import '../../model/grupo_material.dart';
import '../../widgets/data_grid.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_text_form_field.dart';
import '../../widgets/default_user_drawer.dart';
import 'grupo_material_form.dart';

class Grupos extends StatefulWidget {
  const Grupos({ Key? key }) : super(key: key);

  @override
  State<Grupos> createState() => _GruposState();
}

class _GruposState extends State<Grupos> {

  TextEditingController fornecedor = TextEditingController();
  TextEditingController grupo = TextEditingController();
  TextEditingController nome = TextEditingController();
  List<GrupoMaterial> grupoMateriais = [];
  List<GrupoMaterial> grupoMateriaisGrid = [];
  bool grupoMateriaisLoading = false;

  fetchFuncionarios() async {
    setState(() => grupoMateriaisLoading = true);
    grupoMateriais = await GruposMaterialController().getGruposMaterial(context);
    grupoMateriaisGrid = grupoMateriais;
    setState(() => grupoMateriaisLoading = false);
  }

  @override
  void initState() {
    fetchFuncionarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Grupos'),
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
                                  controller: nome,
                                  labelText: 'Nome',
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  onPressed: (){
                                    grupoMateriaisGrid = grupoMateriais
                                      .where((grupoMaterial) =>
                                          grupoMaterial.nome
                                              .toUpperCase()
                                              .contains(nome.text.toUpperCase())
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
                            icon: const Icon(
                              Icons.add_box_outlined,
                              color: Color(0xFF43a047),
                            ),
                            label: const Text(
                              'Cadastrar',
                              style: TextStyle(color: Color(0xFF43a047)),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const GrupoForm(),
                              );
                            },
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
                  child: grupoMateriaisLoading
                  ? const Center(
                    child: SizedBox(child: CircularProgressIndicator()))
                  : DataGrid(
                    headers: [
                      DataGridHeader(
                        link: 'nome',
                        title: 'Nome',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 100,
                      ),
                    ],
                    data: grupoMateriaisGrid.map((grupoMaterial) {
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'nome',
                            display: Text(grupoMaterial.nome),
                            textCompareOrder: grupoMaterial.nome,
                            alignment: Alignment.centerLeft,
                          )
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