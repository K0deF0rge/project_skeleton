class PasswordException implements Exception {
  final String message;
  PasswordException(this.message);

  @override
  String toString() => message;
}
