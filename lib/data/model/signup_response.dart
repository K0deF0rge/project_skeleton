class SignupResponse {
  final String uuid;
  final String message;

  SignupResponse({required this.uuid, required this.message});

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'message': message,
    };
  }
}