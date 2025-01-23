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

class RefreshToken {
  final String accessToken;
  final String refereshToken;
  final String phoneNo;

  RefreshToken({
    required this.accessToken,
    required this.refereshToken,
    required this.phoneNo,
  });

  // Convert request data to JSON
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refereshToken,
      'phonenumber': phoneNo,
    };
  }
}

class LoginResponse {
  final String message;
  final User? user;
  final String token;
  final String refreshToken;

  LoginResponse({
    required this.message,
    required this.user,
    required this.token,
    required this.refreshToken,
  });

  // Create an object from JSON response
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}

class ProfileResponse {
  final String message;
  final User data;

  ProfileResponse({required this.message, required this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      message: json['message'] ?? '',
      data: User.fromJson(json['data']),
    );
  }
}

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String? alternateNumber;
  final String location;
  final List<String> tagsId;
  final List<String> businessTypeTagsId;
  final int? agentId;
  final String userId;
  final DateTime followUpDate;
  final String? additionalNote;
  final DateTime createdDate;
  final bool? isFinalCustomer;
  final String? customerImage;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.alternateNumber,
    required this.location,
    required this.tagsId,
    required this.businessTypeTagsId,
    this.agentId,
    required this.userId,
    required this.followUpDate,
    this.additionalNote,
    required this.createdDate,
    this.isFinalCustomer,
    this.customerImage,
  });

  // Create an object from JSON response
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      alternateNumber: json['alternateNumber'] ?? 'Nan',
      location: json['location'] ?? '',
      tagsId: json['tagsId'] != null
          ? (json['tagsId'] as String)
              .replaceAll('[', '')
              .replaceAll(']', '')
              .split(',')
              .map((e) => e.trim())
              .toList()
          : [],
      businessTypeTagsId: json['businessTypeTagsId'] != null
          ? (json['businessTypeTagsId'] as String)
              .replaceAll('[', '')
              .replaceAll(']', '')
              .split(',')
              .map((e) => e.trim())
              .toList()
          : [],
      agentId: json['agentId'] ?? 0,
      userId: json['userId'] ?? '',
      followUpDate:
          DateTime.parse(json['followUpDate'] ?? DateTime.now().toString()),
      additionalNote: json['additionalNote'] ?? '',
      createdDate:
          DateTime.parse(json['createdDate'] ?? DateTime.now().toString()),
      isFinalCustomer: json['isFinalCustomer'] ?? false,
      customerImage: json['customerImage'] ?? '',
    );
  }
}
