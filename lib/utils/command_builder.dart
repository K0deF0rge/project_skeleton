import 'package:flutter/material.dart';

import 'command.dart';

class CommandBuilder<T extends Command> extends StatefulWidget {
  final T command;
  final Widget? Function(BuildContext)? onRunning;
  final Widget? Function(BuildContext)? onCompleted;
  final Widget? Function(BuildContext)? onError;
  final Widget? initialWidget;

  const CommandBuilder({
    super.key,
    required this.command,
    this.onRunning,
    this.initialWidget,
    this.onCompleted,
    this.onError,
  });

  @override
  State<CommandBuilder> createState() => _CommandBuilderState();
}

class _CommandBuilderState extends State<CommandBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.command,
      builder: (BuildContext context, _) {
        if (widget.command.running) {
          if (widget.onRunning != null) {
            final w = widget.onRunning!(context);
            if (w != null) return w;
          }

          return const Center(child: CircularProgressIndicator());
        } else if (widget.command.completed) {
          if (widget.onCompleted != null) {
            final w = widget.onCompleted!(context);
            if (w != null) return w;
          }
        } else if (widget.command.error) {
          if (widget.onError != null) {
            final w = widget.onError!(context);
            if (w != null) return w;
          }
        }

        return widget.initialWidget ?? const SizedBox.shrink();
      },
    );
  }
}
