class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  // From Json
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  // To json
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}
