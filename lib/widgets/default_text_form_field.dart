import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatefulWidget {

  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final Widget? suffixIcon;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool obscureText;
  final Function(String)? onChanged;

  const DefaultTextFormField({
    this.controller,
    this.initialValue,
    this.focusNode,
    this.labelText,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.suffixIcon,
    this.inputFormatters = const [],
    this.validator,
    this.enabled = true,
    this.obscureText = false,
    this.onChanged,
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
          enabled: widget.enabled,
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          style: TextStyle(color: widget.enabled ? Colors.black : Colors.grey),
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