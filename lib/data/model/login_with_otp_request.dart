class LoginWithOtpRequest {
  final String email;

  LoginWithOtpRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}