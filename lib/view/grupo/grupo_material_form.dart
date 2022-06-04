import 'package:flutter/material.dart';

import '../../controller/grupo_material_controller.dart';
import '../../model/grupo_material.dart';
import '../../widgets/default_text_form_field.dart';

class GrupoForm extends StatefulWidget {
  final int? id;
  const GrupoForm({
    this.id,
    Key? key
  }) : super(key: key);

  @override
  State<GrupoForm> createState() => _GrupoFormState();
}

class _GrupoFormState extends State<GrupoForm> {

  TextEditingController nome = TextEditingController();
  GrupoMaterial grupo = GrupoMaterial();

  bool preenchido = false;


  fetchGrupo() async
  {
    grupo = await GruposMaterialController().getGrupoMaterialById(context, widget.id!);
    nome.text = grupo.nome;
    setState((){});
  }

  @override
  void initState() {
    if(!preenchido)
    {
      if(widget.id != null)
      {
        fetchGrupo();
      }
      preenchido = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Theme.of(context).primaryColor,
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: const [
                        Text('Grupo'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(16),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Material(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [                  
                        Flexible(
                          child: DefaultTextFormField(
                            controller: nome,
                            labelText: 'Nome',
                            onChanged: (data) => grupo.nome = data,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
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
                                      print(grupo.toJson());
                                      GruposMaterialController request = GruposMaterialController();
                                      if(grupo.id == null)
                                      {
                                        await request.postGrupoMaterial(context, grupo);
                                      }
                                      else
                                      {
                                        await request.updateGrupoMaterial(context, grupo);
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}