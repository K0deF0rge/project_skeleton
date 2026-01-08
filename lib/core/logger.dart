import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void debug(String message) {
    if (kDebugMode || kProfileMode) debugPrint('[DEBUG] $message');
  }

  static void info(String message) {
    if (kDebugMode || kProfileMode) debugPrint('[INFO] $message');
  }

  static void warn(String message) {
    if (kDebugMode || kProfileMode) debugPrint('[WARN] $message');
  }

  static void error(String message, [Object? error, StackTrace? stack]) {
    debugPrint('[ERROR] $message ${error ?? ''}');
    if (stack != null) debugPrint(stack.toString());
  }
}
