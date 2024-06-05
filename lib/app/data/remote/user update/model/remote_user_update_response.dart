class RemoteUserUpdateResponse {
  final int id;
  final String userName;
  final String name;
  final String firstName;
  final String lastName;
  final String email;

  RemoteUserUpdateResponse({
    required this.id,
    required this.userName,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory RemoteUserUpdateResponse.fromJson(Map<String, dynamic> json) {
    return RemoteUserUpdateResponse(
        id: json['id'] ?? '',
        userName: json['username'] ?? '',
        name: json['name'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        email: json['email'] ?? '');
  }
}
