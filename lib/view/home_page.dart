import 'package:almoxarifado/widgets/default_app_bar.dart';
import 'package:almoxarifado/widgets/default_dropdown.dart';
import 'package:almoxarifado/widgets/default_user_drawer.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({ Key? key }) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(pageName: 'Home'),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'label',
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                      ),
                      child: DefaultDropDown(
                        controller: TextEditingController(),
                        itenListBackgroundColor: Theme.of(context).cardColor,
                        maximunItensShown: 3,
                        enabled: true,
                        labelText: 'Teste',
                        // searchable: true,
                        validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
                        itens: const [
                          DropdownMenuItem(
                            value: 'data1',
                            child: Text('data1'),
                          ),
                          DropdownMenuItem(
                            value: 'data2',
                            child: Text('data2'),
                          ),
                          DropdownMenuItem(
                            value: 'data3',
                            child: Text('data3'),
                          ),
                          DropdownMenuItem(
                            value: 'data4',
                            child: Text('data4'),
                          ),
                          DropdownMenuItem(
                            value: 'data5',
                            child: Text('data5'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: (){_formKey.currentState!.validate();},
                child: const Text('textinho'),
              ),
              ElevatedButton(
                onPressed: null,
                child: const Text('textinho'),
              ),              
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                //padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.lock_rounded),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.visibility_off_outlined,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ),
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