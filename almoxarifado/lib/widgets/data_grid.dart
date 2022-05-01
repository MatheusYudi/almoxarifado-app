import 'package:flutter/material.dart';

enum direcao{
  asc,
  desc,
}

// ignore: must_be_immutable
class DataGrid extends StatefulWidget {
  
  final double width;
  final List<Map> headers;
  late List data;
  final Future<void> Function()? pullToRefreshFunction;
  
  DataGrid({
    required this.headers,
    required this.data,
    required this.width,
    this.pullToRefreshFunction,
    Key? key,
  }) : super(key: key);

  @override
  _DataGridState createState() => _DataGridState();
}
//TODO aceitar propriedade tamanho minimo
class _DataGridState extends State<DataGrid> {

  direcao orientation = direcao.asc;
  dynamic orderBy;
  Map textControlers = {};
  late List itens;

  @override
  void initState() {
    itens = widget.data;
    for(int i = 0; i < widget.headers.length; i++){
      textControlers[widget.headers[i]['link']] = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width - 16,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: [
                Material(
                  elevation: 10,
                  child: SizedBox(
                    height: 50,
                    width: widget.width - 16,
                    child: ListView.builder(
                      physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.headers.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          child: Container(
                            color: Colors.grey[200],
                            height: 50,
                            width: (widget.width - 16) * widget.headers[index]['displayPercentage']/100,
                            padding: const EdgeInsets.all(8.0),
                            /*decoration: BoxDecoration(
                              border: Border.all(),
                              color: Colors.grey,
                            ),*/
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: ((widget.width - 16) * widget.headers[index]['displayPercentage']/100) - 40,
                                  alignment: widget.headers[index]['alignment'],
                                  child: widget.headers[index]['enableSearch']
                                  ? TextField(
                                    controller: textControlers[widget.headers[index]['link']],
                                    decoration: InputDecoration(
                                      labelText: widget.headers[index]['title'],
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      suffixIcon: GestureDetector(
                                        child: const Icon(Icons.search),
                                        onTap: (){
                                          setState(() {
                                            widget.data = itens;
                                            widget.data = widget.data.where((element) => element[widget.headers[index]['link']]['textCompareOrder'].toString().toUpperCase().contains(textControlers[widget.headers[index]['link']].text.toString().toUpperCase())).toList();
                                          });
                                        }
                                      ),
                                    ),
                                  )
                                  : Text(widget.headers[index]['title']),
                                ),
                                widget.headers[index]['title'] == orderBy && widget.headers[index]['sortable']
                                ? (Icon(orientation == direcao.asc 
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down))
                                : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                          onTap: (){
                            orderBy = widget.headers[index]['title'];
                
                            if(widget.headers[index]['sortable'])
                            {
                              if(orientation == direcao.asc)
                              {
                                setState(() {
                                  widget.data = itens;
                                  orientation = direcao.desc;
                                  widget.data.sort((a, b) => a[widget.headers[index]['link']]['textCompareOrder']==null ? 1: b[widget.headers[index]['link']]['textCompareOrder']==null? -1 : a[widget.headers[index]['link']]['textCompareOrder'].compareTo(b[widget.headers[index]['link']]['textCompareOrder']));
                                });
                              }
                              else
                              {
                                setState(() {
                                  widget.data = itens;
                                  orientation = direcao.asc;
                                  widget.data.sort((a, b) => b[widget.headers[index]['link']]['textCompareOrder']==null ? 1: a[widget.headers[index]['link']]['textCompareOrder']==null? -1 : b[widget.headers[index]['link']]['textCompareOrder'].compareTo(a[widget.headers[index]['link']]['textCompareOrder']));
                                });
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: widget.width - 16,
                    child: widget.pullToRefreshFunction != null
                    ? RefreshIndicator(
                      onRefresh: widget.pullToRefreshFunction!,
                      child: ListView.builder(
                        itemCount: widget.data.length,
                        itemBuilder: (context, indexLinha){
                          return Material(
                            elevation: 5,
                            child: SizedBox(
                              height: 40,
                              width: widget.width - 16,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: widget.width - 16,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.headers.length,
                                      itemBuilder: (context, indexColuna){
                                        return Container(
                                          color: indexLinha%2 != 0? Colors.grey[200]: Colors.grey[100],
                                          width: (widget.width - 16) * widget.headers[indexColuna]['displayPercentage']/100,
                                          padding: const EdgeInsets.all(8.0),
                                          /*decoration: BoxDecoration(
                                            border: Border.all(),
                                          ),*/
                                          alignment: widget.data[indexLinha][widget.headers[indexColuna]['link']]['alignment'],
                                          child: widget.data[indexLinha][widget.headers[indexColuna]['link']]['display'] as Widget,
                                        );
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    : ListView.builder(
                      itemCount: widget.data.length,
                      itemBuilder: (context, indexLinha){
                        return Material(
                          elevation: 5,
                          child: SizedBox(
                            height: 40,
                            width: widget.width - 16,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: widget.width - 16,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.headers.length,
                                    itemBuilder: (context, indexColuna){
                                      return Container(
                                        color: indexLinha%2 != 0? Colors.grey[200]: Colors.grey[100],
                                        width: (widget.width - 16) * widget.headers[indexColuna]['displayPercentage']/100,
                                        padding: const EdgeInsets.all(8.0),
                                        /*decoration: BoxDecoration(
                                          border: Border.all(),
                                        ),*/
                                        alignment: widget.data[indexLinha][widget.headers[indexColuna]['link']]['alignment'],
                                        child: widget.data[indexLinha][widget.headers[indexColuna]['link']]['display'] as Widget,
                                      );
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}