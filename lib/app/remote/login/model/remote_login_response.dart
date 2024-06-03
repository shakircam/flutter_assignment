class RemoteLoginResponse {
  final String token;
  final String userEmail;
  final String userNickName;
  final String userDisplayName;

  RemoteLoginResponse({
    required this.token,
    required this.userEmail,
    required this.userNickName,
    required this.userDisplayName,
  });

  factory RemoteLoginResponse.fromJson(Map<String, dynamic> json) {
    return RemoteLoginResponse(
        token: json['token'] ?? '',
        userEmail: json['user_email'] ?? '',
        userNickName: json['user_nicename'] ?? '',
        userDisplayName: json['user_display_name'] ?? '');
  }
}
