class Credentials {
  final String email;
  final String password;

  Credentials({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}