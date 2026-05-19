import 'package:flutter/foundation.dart';

enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  fatal;

  int get priority => index;

  String get prefix => switch (this) {
        LogLevel.verbose => '🔍 VERBOSE',
        LogLevel.debug => '🐛 DEBUG',
        LogLevel.info => 'ℹ️  INFO',
        LogLevel.warning => '⚠️  WARN',
        LogLevel.error => '❌ ERROR',
        LogLevel.fatal => '🔥 FATAL',
      };
}

typedef LogCallback = void Function(
  String message,
  LogLevel level,
  String? tag,
  Object? error,
  StackTrace? stackTrace,
);

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  static LogLevel _minLevel = kDebugMode ? LogLevel.verbose : LogLevel.warning;
  static final List<LogCallback> _callbacks = [];
  static const int _maxLogHistory = 1000;
  static final List<String> _logHistory = [];

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal();

  static void initialize({
    LogLevel minLevel = LogLevel.verbose,
    List<LogCallback>? callbacks,
  }) {
    _minLevel = minLevel;
    if (callbacks != null) {
      _callbacks.addAll(callbacks);
    }
  }

  static void addCallback(LogCallback callback) {
    _callbacks.add(callback);
  }

  static void removeCallback(LogCallback callback) {
    _callbacks.remove(callback);
  }

  static void clearHistory() {
    _logHistory.clear();
  }

  static List<String> getHistory() {
    return List.unmodifiable(_logHistory);
  }

  /// Log verbose - para informações muito detalhadas
  static void verbose(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      LogLevel.verbose,
      tag,
      error,
      stackTrace,
    );
  }

  /// Log debug - para informações de debugging
  static void debug(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      LogLevel.debug,
      tag,
      error,
      stackTrace,
    );
  }

  /// Log info - para informações gerais
  static void info(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      LogLevel.info,
      tag,
      error,
      stackTrace,
    );
  }

  /// Log warning - para avisos
  static void warning(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      LogLevel.warning,
      tag,
      error,
      stackTrace,
    );
  }

  /// Log error - para erros
  static void error(
    String message, Exception error, {
    String? tag,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      LogLevel.error,
      tag,
      error,
      stackTrace,
    );
  }

  /// Log fatal - para erros críticos
  static void fatal(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      LogLevel.fatal,
      tag,
      error,
      stackTrace,
    );
  }

  static void _log(
    String message,
    LogLevel level,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  ) {
    if (level.priority < _minLevel.priority) {
      return;
    }

    final timestamp = DateTime.now().toIso8601String();
    final tagStr = tag != null ? '[$tag]' : '';
    final errorStr = error != null ? '\nError: $error' : '';

    final formattedMessage =
        '${level.prefix} $timestamp $tagStr $message$errorStr';

    _addToHistory(formattedMessage);

    debugPrint(formattedMessage);

    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }

    for (final callback in _callbacks) {
      callback(message, level, tag, error, stackTrace);
    }
  }

  static void _addToHistory(String message) {
    _logHistory.add(message);
    if (_logHistory.length > _maxLogHistory) {
      _logHistory.removeAt(0);
    }
  }
}
