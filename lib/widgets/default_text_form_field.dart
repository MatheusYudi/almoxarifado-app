import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatefulWidget {

  final TextEditingController controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final Widget? suffixIcon;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;

  const DefaultTextFormField({
    required this.controller,
    this.initialValue,
    this.focusNode,
    this.labelText,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.suffixIcon,
    this.inputFormatters = const [],
    this.validator,
    Key? key
  }) : super(key: key);

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        child: TextFormField(
          controller: widget.controller,
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          readOnly: widget.readOnly,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          decoration: InputDecoration(
            labelText: widget.labelText,
            contentPadding: const EdgeInsets.all(10),
            border: InputBorder.none,
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ),
    );
  }
}