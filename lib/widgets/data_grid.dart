import 'package:flutter/material.dart';

enum direcao{
  asc,
  desc,
}

class DataGridHeader{
  final String link;
  final String title;
  final bool sortable;
  final Alignment alignment;
  final bool enableSearch;
  final double displayPercentage;

  DataGridHeader({
    required this.link,
    this.title = '',
    this.sortable = true,
    this.alignment = Alignment.center,
    this.enableSearch = true,
    required this.displayPercentage,
  });
}

class DataGridRow{
  final Color? backgroundColor;
  final EdgeInsets contentPadding;
  final void Function()? onDoubleTap;
  final List<DataGridRowColumn> columns;

  DataGridRow({
    this.backgroundColor,
    this.contentPadding = const EdgeInsets.all(8.0),
    this.onDoubleTap,
    required this.columns,
  });
}

class DataGridRowColumn{
  final String link;
  final Widget display;
  final String textCompareOrder;
  final Alignment alignment;

  DataGridRowColumn({
    required this.link,
    this.display = const Text(''),
    this.textCompareOrder = '',
    this.alignment = Alignment.center,
  });
}

// ignore: must_be_immutable
class DataGrid extends StatefulWidget {
  
  final double width;
  final List<DataGridHeader> headers;
  late List<DataGridRow> data;
  final bool infiniteScroll;
  final Function(int index)? addMoreData;
  
  DataGrid({Key? key, 
    required this.headers,
    required this.data,
    required this.width,
    this.infiniteScroll = false,
    this.addMoreData,
  }) : assert(
    (infiniteScroll && addMoreData != null)
    || infiniteScroll == false
  ), super(key: key);

  @override
  _DataGridState createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {

  direcao orientation = direcao.asc;
  dynamic orderBy;
  Map textControlers = {};
  late List<DataGridRow> itens;

  @override
  void initState() {
    itens = widget.data;
    for(int i = 0; i < widget.headers.length; i++){
      textControlers[widget.headers[i].link] = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width - 16,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
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
                    return InkWell(
                      child: Container(
                        color: Colors.grey[200],
                        height: 50,
                        width: (widget.width - 16) * widget.headers[index].displayPercentage/100,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: widget.headers[index].alignment,
                                child: widget.headers[index].enableSearch
                                ? TextField(
                                  controller: textControlers[widget.headers[index].link],
                                  decoration: InputDecoration(
                                    labelText: widget.headers[index].title,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    suffixIcon: GestureDetector(
                                      child: const Icon(Icons.search),
                                      onTap: (){
                                        setState(() {
                                          widget.data = itens.where((element) => element.columns[index].textCompareOrder.toUpperCase().contains(textControlers[widget.headers[index].link].text.toString().toUpperCase())).toList();
                                        });
                                      }
                                    ),
                                  ),
                                )
                                : Text(widget.headers[index].title, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            widget.headers[index].sortable
                            ? widget.headers[index].title == orderBy
                              ? Icon(orientation == direcao.asc
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up)
                              : const SizedBox(width:24)
                            : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      onTap: widget.headers[index].sortable
                      ? (){
                        orderBy = widget.headers[index].title;
      
                        if(orientation == direcao.asc)
                        {
                          setState(() {
                            // widget.data = itens;
                            orientation = direcao.desc;
                            widget.data.sort((a, b) => a.columns[index].textCompareOrder.toUpperCase().compareTo(b.columns[index].textCompareOrder.toUpperCase()));
                          });
                        }
                        else
                        {
                          setState(() {
                            // widget.data = itens;
                            orientation = direcao.asc;
                            widget.data.sort((a, b) => b.columns[index].textCompareOrder.toUpperCase().compareTo(a.columns[index].textCompareOrder.toUpperCase()));
                          });
                        }
                      }
                      : null,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: widget.width - 16,
                child: ListView.builder(
                  itemCount: widget.infiniteScroll ? null : widget.data.length,
                  itemBuilder: (context, indexLinha){
                    if(!widget.infiniteScroll)
                    {
                      return InkWell(
                        child: Material(
                          elevation: 5,
                          child: Container(
                            color: widget.data[indexLinha].backgroundColor ?? Theme.of(context).cardColor,
                            height: 40,
                            width: widget.width - 16,
                            padding: widget.data[indexLinha].contentPadding,
                            child: Row(
                              children: [
                                Flexible(
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.headers.length,
                                    itemBuilder: (context, indexColuna){
                                      return Container(
                                        width: (widget.width - 16) * widget.headers[indexColuna].displayPercentage/100,
                                        alignment: widget.data[indexLinha].columns[indexColuna].alignment,
                                        child: widget.data[indexLinha].columns[indexColuna].display,
                                      );
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onDoubleTap: widget.data[indexLinha].onDoubleTap,
                      );
                    }
                    else
                    {
                      if(indexLinha < widget.data.length)
                      {
                        return Material(
                          elevation: 5,
                          child: Container(
                            color: widget.data[indexLinha].backgroundColor ?? Theme.of(context).cardColor,
                            height: 40,
                            width: widget.width - 16,
                            padding: widget.data[indexLinha].contentPadding,
                            child: Row(
                              children: [
                                Flexible(
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.headers.length,
                                    itemBuilder: (context, indexColuna){
                                      return Container(
                                        width: (widget.width - 16) * widget.headers[indexColuna].displayPercentage/100,
                                        alignment: widget.data[indexLinha].columns[indexColuna].alignment,
                                        child: widget.data[indexLinha].columns[indexColuna].display,
                                      );
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      else
                      {
                        widget.addMoreData!(indexLinha);
                        return CircularProgressIndicator();
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}