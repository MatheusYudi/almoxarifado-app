import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultDropDown extends StatefulWidget {

  final TextEditingController controller;
  final String labelText;
  final Color prefixColor;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final List<DropdownMenuItem> itens;
  final int? maximunItensShown;
  final bool searchable;
  final bool enabled;
  final Color entryBackgroundColor;
  final Color itenListBackgroundColor;
  final double borderRadius;
  final String? Function(String?)? validator;

  const DefaultDropDown({ 
    required this.controller,
    this.labelText = '',
    this.prefixColor = Colors.blue,
    this.keyboardType,
    this.inputFormatters,
    this.maximunItensShown,
    this.searchable = false,
    this.enabled = true,
    this.entryBackgroundColor = Colors.transparent,
    this.itenListBackgroundColor = Colors.white,
    this.borderRadius = 10,
    this.validator,
    required this.itens,
    Key? key
  }) : super(key: key);

  @override
  _DefaultDropDownState createState() => _DefaultDropDownState();
}

class _DefaultDropDownState extends State<DefaultDropDown> {

  late GlobalKey actionKey;
  OverlayEntry? overlay;
  bool isShowingItens = false;
  double height = 0;
  double width = 0;
  double xPosition = 0;
  double yPosition = 0;
  late List<DropdownMenuItem> filteredItens;
  late Offset offset;

  void _findPosition(){
    RenderBox renderBox = actionKey.currentContext!.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createOverlay(){
    return OverlayEntry(
      builder: (context){
        return Stack(
          children: [
            Positioned.fill(
               child: GestureDetector(
                onTap:(){
                  overlay!.remove();
                  setState(() => isShowingItens = !isShowingItens);
                },
                child: Container(
                  color: Colors.transparent,
                ),
              )
            ),
            Positioned(
              left: xPosition,
              width: width,
              top: yPosition + height,
              height: 40.0 * (widget.maximunItensShown == null
                ? filteredItens.length
                : (widget.maximunItensShown! <= filteredItens.length
                ? widget.maximunItensShown
                : filteredItens.length) as int),
              child: Material(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(widget.borderRadius),
                  bottomRight: Radius.circular(widget.borderRadius),
                ),
                elevation: 20,
                color: Colors.transparent,
                child: Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: width,                  
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: widget.itenListBackgroundColor,//Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(widget.borderRadius),
                      bottomRight: Radius.circular(widget.borderRadius),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredItens.length,
                    itemBuilder: (context, index){
                      return SizedBox(
                        height: 40,
                        width: width,
                        child: GestureDetector(
                          child: Container(
                            child: filteredItens[index],
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: widget.itenListBackgroundColor,//Theme.of(context).canvasColor,
                              border: Border.all(color: Colors.black12)
                            ),
                          ),
                          onTap: (){
                            setState(() {
                              widget.controller.text = filteredItens[index].value;
                            });
                            if(filteredItens[index].onTap != null)
                            {
                              filteredItens[index].onTap!();
                            }
                            overlay!.remove();
                            setState(() => isShowingItens = !isShowingItens);
                          },
                        ),
                      );
                    }
                  ),
                ),
              ),
            ),
          ]
        );
      }
    );
  }

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.controller.text);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      filteredItens = widget.itens;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.borderRadius),
              topRight: Radius.circular(widget.borderRadius),
              bottomLeft: Radius.circular(isShowingItens ? 0 : widget.borderRadius),
              bottomRight: Radius.circular(isShowingItens ? 0 : widget.borderRadius),
            ),
            color: widget.entryBackgroundColor,
          ),
          child: TextFormField(
            readOnly: !widget.searchable,
            enabled: widget.enabled,
            key: actionKey,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            inputFormatters: widget.inputFormatters ?? [],
            validator: widget.validator,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              labelText: widget.labelText,
              suffixIcon: const Icon(Icons.keyboard_arrow_down),
            ),
            onTap: widget.enabled
            ? (){
              if(!isShowingItens)
              {
                filteredItens = widget.itens;
                _findPosition();
                overlay =_createOverlay();
                Overlay.of(context)!.insert(overlay!);
                setState(() => isShowingItens = !isShowingItens);
              }
            }
            : null,
            onChanged: (data){
              setState(() {
                filteredItens = widget.itens.where((element) => element.value.toString().toUpperCase().contains(widget.controller.text.toUpperCase())).toList();
              });
            },
          ),
        ),
        onTap: widget.enabled
        ? (){
          if(!isShowingItens)
          {
            filteredItens = widget.itens;
            _findPosition();
            overlay =_createOverlay();
            Overlay.of(context)!.insert(overlay!);
            setState(() => isShowingItens = !isShowingItens);
          }
        }
        : null,
      ),
    );
  }
}
