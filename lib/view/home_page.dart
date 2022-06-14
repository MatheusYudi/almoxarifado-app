import 'package:almoxarifado/widgets/default_app_bar.dart';
import 'package:almoxarifado/widgets/default_dropdown.dart';
import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/funcionario_atual_controller.dart';
import '../util/routes.dart';
import '../widgets/drawer_menu_itens.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
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
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(50),
                        child: Column(children: [
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
                          )
                        ])),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 16),
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8),
                                                        child: const Text(
                                                            'Em aberto',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black))),
                                                    const Text('25',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.orange,
                                                            fontSize: 20))
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8),
                                                        child: const Text(
                                                            'Aprovadas',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black))),
                                                    const Text('25',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 20))
                                                  ]),
                                            )
                                          ])
                                    ]),
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(0, 150)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)))),
                              )),
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                                context, Routes.inventarios),
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: const Text(
                                                        'Em aberto',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black))),
                                                const Text('25',
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 20))
                                              ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: const Text(
                                                        'Finalizados',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black))),
                                                const Text('25',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 20))
                                              ]),
                                        )
                                      ])
                                ]),
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(0, 150)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 100),
              Container(width: 1, height: 200, color: Colors.white),
              const SizedBox(width: 100),
              Expanded(
                  child:
                      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.upload,
                                color: Colors.green,
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: const Text(
                                    'Entrada de Material',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'realizada em 13/11/20 as 17:11',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.movimentacoes);
                            },
                            icon: const Icon(
                              Icons.remove_red_eye_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.download_rounded,
                                color: Colors.red,
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: const Text(
                                    'Saída de Material',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "realizada em 13/11/20 as 17:11",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.movimentacoes);
                            },
                            icon: const Icon(
                              Icons.remove_red_eye_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.upload,
                                color: Colors.green,
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: const Text(
                                    'Entrada de Material',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'realizada em 13/11/20 as 17:11',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.movimentacoes);
                            },
                            icon: const Icon(
                              Icons.remove_red_eye_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.download_rounded,
                                color: Colors.red,
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: const Text(
                                    'Saída de Material',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'realizada em 13/11/20 as 17:11',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.movimentacoes);
                            },
                            icon: const Icon(
                              Icons.remove_red_eye_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.upload,
                                color: Colors.green,
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: const Text(
                                    'Entrada de Material',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'realizada em 13/11/20 as 17:11',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.movimentacoes);
                            },
                            icon: const Icon(
                              Icons.remove_red_eye_outlined,
                            ),
                          ),
                        ],
                      ),
                    )
                  ])),
            ],
          ),
        ),
      ),
      drawer: const DefaultUserDrawer(),
    );
  }
}
