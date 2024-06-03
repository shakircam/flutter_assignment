class UserUpdateParams {
  final String firstName;
  final String lastName;

  UserUpdateParams({required this.firstName, required this.lastName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;

    return data;
  }
}
