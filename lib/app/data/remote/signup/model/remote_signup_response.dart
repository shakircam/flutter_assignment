class RemoteSignupResponse {
  final int code;
  final String message;

  RemoteSignupResponse({
    required this.code,
    required this.message,
  });

  factory RemoteSignupResponse.fromJson(Map<String, dynamic> json) {
    return RemoteSignupResponse(
        code: json['code'] ?? '', message: json['message'] ?? '');
  }
}
