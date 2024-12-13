class LoginRequest {
  final String phonenumber;
  final bool isStaff;

  LoginRequest({
    required this.phonenumber,
    required this.isStaff,
  });

  // Convert request data to JSON
  Map<String, dynamic> toJson() {
    return {
      'phonenumber': phonenumber,
      'isStaff': isStaff,
    };
  }
}

class LoginResponse {
  final String message;
  final User user;
  final String token;

  LoginResponse({
    required this.message,
    required this.user,
    required this.token,
  });

  // Create an object from JSON response
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class User {
  final String id;
  final String userName;
  final String email;
  final bool emailConfirmed;
  final String phoneNumber;
  final bool phoneNumberConfirmed;
  final bool twoFactorEnabled;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.emailConfirmed,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
  });

  // Create an object from JSON response
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      emailConfirmed: json['emailConfirmed'],
      phoneNumber: json['phoneNumber'],
      phoneNumberConfirmed: json['phoneNumberConfirmed'],
      twoFactorEnabled: json['twoFactorEnabled'],
    );
  }
}
