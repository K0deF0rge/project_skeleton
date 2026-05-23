import 'package:flutter/material.dart';

import '../domain/models/base.dart';
import 'command.dart';
import 'result.dart';

class Command0BuilderList<T extends BaseModel> extends StatelessWidget {
  final Command0<List<T>> command;
  final Widget? Function(BuildContext)? onRunning;
  final Widget? Function(BuildContext, List<T>)? onCompleted;
  final Widget? Function(BuildContext)? onError;
  final Widget? initialWidget;

  const Command0BuilderList({
    super.key,
    required this.command,
    this.onRunning,
    this.initialWidget,
    this.onCompleted,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: command,
      builder: (BuildContext context, _) {
        if (command.running) {
          if (onRunning != null) {
            final w = onRunning!(context);
            if (w != null) return w;
          }

          return const Center(child: CircularProgressIndicator());
        } else if (command.completed) {
          if (onCompleted != null) {
            final list = (command.result as Ok<List<T>>).value;

            final w = onCompleted!(context, list);

            if (w != null) return w;
          }
        } else if (command.error) {
          if (onError != null) {
            final w = onError!(context);
            if (w != null) return w;
          }
        }

        return initialWidget ?? const SizedBox.shrink();
      },
    );
  }
}
