import 'package:flutter/material.dart';

import 'base.dart';

class ModelScope extends StatefulWidget {
  final BaseModel model;
  final Widget child;
  final GlobalKey<FormState>? formKey;

  const ModelScope(this.model, {
    super.key,
    required this.child,
    this.formKey,
  });

  static BaseModel of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelScopeInherited>();
    assert(scope != null, 'Nenhum ModelScope encontrado no contexto.');
    return scope!.model;
  }

  static FormState? formStateOf(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelScopeInherited>();
    return scope?.formKey.currentState;
  }

  /// Valida o formulário (retorna false se não houver form).
  static bool validate(BuildContext context) =>
      formStateOf(context)?.validate() ?? false;

  /// Salva o formulário (chama onSaved nos fields).
  static void save(BuildContext context) => formStateOf(context)?.save();

  /// Reseta o formulário.
  static void reset(BuildContext context) => formStateOf(context)?.reset();

  @override
  State<ModelScope> createState() => _ModelScopeState();
}

class _ModelScopeState extends State<ModelScope> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _ModelScopeInherited(
      model: widget.model,
      formKey: widget.formKey ?? _formKey,
      child: Form(
        key: widget.formKey ?? _formKey,
        child: widget.child,
      ),
    );
  }
}

class _ModelScopeInherited extends InheritedWidget {
  final BaseModel model;
  final GlobalKey<FormState> formKey;

  const _ModelScopeInherited({
    required this.model,
    required this.formKey,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _ModelScopeInherited oldWidget) {
    return model.toJson() != oldWidget.model.toJson();
  }
}
