import 'package:flutter/material.dart';

import '../../../domain/models/base.dart';
import '../../../domain/models/model_scope.dart';

abstract class BaseTextField extends StatefulWidget {
  final String fieldName;
  final String label;

  const BaseTextField({
    super.key,
    required this.fieldName,
    required this.label,
  });
}

abstract class BaseTextFieldState<W extends BaseTextField> extends State<W> {
  late final TextEditingController controller;
  late BaseModel model;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model = ModelScope.of(context);
    String value = getValue<String>();
    if (controller.text != value) {
      controller.text = value;
    }

    return buildInput(context, model);
  }

  T getValue<T>() => model.getValue<T>(widget.fieldName);
  void setValue<T>(String? value) => model.setValue<T>(widget.fieldName, value ?? '');

  Widget buildInput(BuildContext context, BaseModel model);
}
