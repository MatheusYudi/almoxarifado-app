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

  fetchGrupoMaterial() async {
    setState(() => grupoMateriaisLoading = true);
    grupoMateriais = await GruposMaterialController().getGruposMaterial(context);
    grupoMateriaisGrid = grupoMateriais;
    setState(() => grupoMateriaisLoading = false);
  }

  @override
  void initState() {
    fetchGrupoMaterial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Gerenciar Grupos'),
      drawer: const DefaultUserDrawer(),
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
                              ).then((value) => fetchGrupoMaterial());
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
                        link: 'delete',
                        title: '',
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 5,
                      ),
                      DataGridHeader(
                        link: 'edit',
                        title: '',
                        enableSearch: false,
                        sortable: false,
                        displayPercentage: 5,
                      ),
                      DataGridHeader(
                        link: 'nome',
                        title: 'Nome',
                        alignment: Alignment.centerLeft,
                        enableSearch: false,
                        displayPercentage: 90,
                      ),
                    ],
                    data: grupoMateriaisGrid.map((grupoMaterial) {
                      return DataGridRow(
                        columns: [
                          DataGridRowColumn(
                            link: 'delete',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              tooltip: "Excluir",
                              onPressed: () async {
                                GruposMaterialController grupoMaterialController = GruposMaterialController();
                                grupoMaterialController.deleteGrupoMaterial(context, grupoMaterial.id!).then((value){
                                  fetchGrupoMaterial();
                                  if(value == true)
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          content: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.cancel_outlined, color: Colors.red,),
                                              Text('Grupo de material deletado')
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  else
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          content: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children:  [
                                              const Icon(Icons.cancel_outlined, color: Colors.red),
                                              Text(grupoMaterialController.error),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                });
                              },
                            ),
                          ),
                          DataGridRowColumn(
                            link: 'edit',
                            alignment: Alignment.center,
                            display: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.blue,
                              icon: const Icon(Icons.edit),
                              tooltip: "Alterar",
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => GrupoForm(id: grupoMaterial.id)).then((value){
                                    fetchGrupoMaterial();
                                  },
                                );
                              },
                            ),
                          ),
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
    );
  }
}