class SigninResponse {
  final String uuid;
  final String message;

  SigninResponse({required this.uuid, required this.message});

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'message': message,
    };
  }
}