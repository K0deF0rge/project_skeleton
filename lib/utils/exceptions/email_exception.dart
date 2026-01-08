class EmailException implements Exception {
  final String message;
  EmailException(this.message);

  @override
  String toString() => message;
}