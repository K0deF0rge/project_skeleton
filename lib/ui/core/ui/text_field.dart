import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/models/base.dart';
import 'base_field.dart';

class ModelTextField extends BaseTextField {
  final String? Function(String?)? validator;
  final bool required;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autoFocus;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  
  const ModelTextField({
    super.key,
    required super.fieldName,
    required super.label,
    this.validator,
    this.required = false,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.inputFormatters,
    this.autoFocus = false,
  });

  @override
  State<ModelTextField> createState() => _ModelTextFieldState();
}

class _ModelTextFieldState extends BaseTextFieldState<ModelTextField> {
  @override
  Widget buildInput(BuildContext context, BaseModel model) {
    return TextFormField(
      controller: controller,
      autofocus: widget.autoFocus,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.suffixIcon,
      ),
      onSaved: setValue,
      inputFormatters: widget.inputFormatters,
      validator: (value) {
        if (widget.required) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo obrigatório';
          }
        }
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
    );
  }
}
