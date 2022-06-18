import 'package:almoxarifado/widgets/default_app_bar.dart';
import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/funcionario_atual_controller.dart';
import '../controller/inventarios_controller.dart';
import '../controller/movimentacoes_controller.dart';
import '../controller/requisicoes_controller.dart';
import '../model/grupo_acesso.dart';
import '../model/movimentacao.dart';
import '../util/routes.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  Map<String, dynamic> balancoRequisicao = {};
  Map<String, dynamic> balancoInventario = {};

  List<Movimentacao> movimentacoes = [];
  bool movimentacoesLoading = false;
  GrupoAcesso? permissao;

  fetchBalancoRequisicao() async {
    balancoRequisicao = await RequisicoesController().getBalanco(context) ?? {};
    setState((){});
  }

  fetchBalancoInventario() async {
    balancoInventario = await InventariosController().getBalanco(context) ?? {};
    setState((){});
  }

  fetchMovimentacoes() async {
    setState(() => movimentacoesLoading = true);
    movimentacoes = await MovimentacoesController().getMovimentacoes(context, {'page': 1, 'size': 5});
    setState(() => movimentacoesLoading = false);
  }

  @override
  void initState() {
    permissao = Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().grupoAcesso;
    
    fetchBalancoRequisicao();

    if(!(permissao != null && permissao?.id == 2))
    {
      fetchBalancoInventario();
      fetchMovimentacoes();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Home'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(80),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(50),
                        child: Column(
                          children: [
                          Text(
                            DateFormat.yMMMd('pt_BR').format(DateTime.now()),
                            style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            DateFormat('HH:mm').format(DateTime.now()),
                            style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                              color: Colors.white,
                              fontSize: 65,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        "Olá, " + Provider.of<FuncionarioAtualController>(context, listen: false).getFuncionarioAtual().nome,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        runSpacing: 25,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 32),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.requisicoes),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: const Text(
                                      'Requisições',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: const Text(
                                                'Em aberto',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              balancoRequisicao.isEmpty
                                              ? ''
                                              : balancoRequisicao['pending'].toString(),
                                              style: const TextStyle(
                                                color:Colors.orange,
                                                fontSize: 20
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisSize:MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: const Text(
                                                'Aprovadas',
                                                style: TextStyle(
                                                  color: Colors.black
                                                ),
                                              ),
                                            ),
                                            Text(
                                              balancoRequisicao.isEmpty
                                              ? ''
                                              : balancoRequisicao['approved'].toString(),
                                              style: const TextStyle(
                                                color:Colors.green,
                                                fontSize: 20
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(const Size(0, 150)),
                                backgroundColor:MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                ),
                              ),
                            ),
                          ),
                          permissao != null && permissao?.id == 2
                          ? const SizedBox.shrink()
                          : ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, Routes.inventarios),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: const Text(
                                    'Inventários',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: const Text(
                                                'Em aberto',
                                                style: TextStyle(
                                                  color:Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              balancoInventario.isEmpty
                                              ? ''
                                              : balancoInventario['pending'].toString(),
                                              style: const TextStyle(
                                                color:Colors.orange,
                                                fontSize: 20
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: const Text(
                                                'Finalizados',
                                                style: TextStyle(
                                                  color:Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              balancoInventario.isEmpty
                                              ? ''
                                              : balancoInventario['closed'].toString(),
                                              style: const TextStyle(
                                                color:Colors.green,
                                                fontSize: 20
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              ],
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(0, 150)),
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:BorderRadius.circular(18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(width: 100),
              permissao != null && permissao?.id == 2
              ? const SizedBox.shrink()
              : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: VerticalDivider(color: Colors.white),
              ),
              permissao != null && permissao?.id == 2
              ? const SizedBox.shrink()
              : Expanded(
                child: movimentacoesLoading
                ? const Center(
                    child: SizedBox(child: CircularProgressIndicator()))
                : ListView.builder(
                  itemCount: movimentacoes.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(
                          movimentacoes[index].tipo.toLowerCase() == "entrada" ? Icons.upload : Icons.download_rounded,
                          color: movimentacoes[index].tipo.toLowerCase() == "entrada" ? Colors.green : Colors.red,
                        ),
                        title: Text(movimentacoes[index].tipo),
                        subtitle: Text("Realizada em: ${DateFormat('dd/MM/yyyy').format(movimentacoes[index].dataHora!)}"),
                        trailing: IconButton(
                          onPressed: () => Navigator.pushNamed(context, Routes.movimentacoes),
                          icon: const Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const DefaultUserDrawer(),
    );
  }
}
