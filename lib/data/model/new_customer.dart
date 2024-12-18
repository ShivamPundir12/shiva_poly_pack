import 'dart:convert';

class CreateNewCustomer {
  final String name;
  final String phoneNumber;
  final String alternateNumber;
  final String location;
  final String tagsId;
  final String businessTypeTagsId;
  final int agentId;
  final String userId;
  final String additionalNote;

  CreateNewCustomer({
    required this.name,
    required this.phoneNumber,
    required this.alternateNumber,
    required this.location,
    required this.tagsId,
    required this.businessTypeTagsId,
    required this.agentId,
    required this.userId,
    required this.additionalNote,
  });

  // Factory method to create CreateNewCustomer from JSON
  factory CreateNewCustomer.fromJson(Map<String, dynamic> json) {
    return CreateNewCustomer(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      alternateNumber: json['alternateNumber'],
      location: json['location'],
      tagsId: json['tagsId'],
      businessTypeTagsId: json['businessTypeTagsId'],
      agentId: json['agentId'],
      userId: json['userId'],
      additionalNote: json['additionalNote'],
    );
  }

  // Convert CreateNewCustomer to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'alternateNumber': alternateNumber,
      'location': location,
      'tagsId': tagsId,
      'businessTypeTagsId': businessTypeTagsId,
      'agentId': agentId,
      'userId': userId,
      'additionalNote': additionalNote,
    };
  }
}

class GetCustomerInfo {
  final String message;
  final CustomerData data;

  GetCustomerInfo({
    required this.message,
    required this.data,
  });

  // Factory method to parse JSON to GetCustomerInfo
  factory GetCustomerInfo.fromJson(Map<String, dynamic> json) {
    return GetCustomerInfo(
      message: json['message'],
      data: CustomerData.fromJson(json['data']),
    );
  }

  // Convert GetCustomerInfo to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CustomerData {
  final int id;
  final String name;
  final String phoneNumber;
  final String alternateNumber;
  final String location;
  final List<String> tagsId;
  final List<String> businessTypeTagsId;
  final int agentId;
  final String userId;
  final String followUpDate;
  final String additionalNote;
  final String createdDate;
  final bool? isFinalCustomer;

  CustomerData({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.alternateNumber,
    required this.location,
    required this.tagsId,
    required this.businessTypeTagsId,
    required this.agentId,
    required this.userId,
    required this.followUpDate,
    required this.additionalNote,
    required this.createdDate,
    this.isFinalCustomer,
  });

  // Factory method to parse JSON to CustomerData
  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'] as int,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      alternateNumber: json['alternateNumber'] ?? '',
      location: json['location'] as String,
      tagsId: json['tagsId'] != null && json['tagsId'].isNotEmpty
          ? List<String>.from(jsonDecode(json['tagsId']))
          : [],
      businessTypeTagsId: json['businessTypeTagsId'] != null &&
              json['businessTypeTagsId'].isNotEmpty
          ? List<String>.from(jsonDecode(json['businessTypeTagsId']))
          : [],
      agentId: json['agentId'] != null ? json['agentId'] as int : 0,
      userId: json['userId'] as String,
      followUpDate: json['followUpDate'] ?? '',
      additionalNote: json['additionalNote'] ?? '',
      createdDate: json['createdDate'] ?? '',
      isFinalCustomer: json['isFinalCustomer'] as bool?,
    );
  }

  // Convert CustomerData to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'alternateNumber': alternateNumber,
      'location': location,
      'tagsId': tagsId.isNotEmpty ? jsonEncode(tagsId) : '[]',
      'businessTypeTagsId':
          businessTypeTagsId.isNotEmpty ? jsonEncode(businessTypeTagsId) : '[]',
      'agentId': agentId,
      'userId': userId,
      'followUpDate': followUpDate,
      'additionalNote': additionalNote,
      'createdDate': createdDate,
      'isFinalCustomer': isFinalCustomer,
    };
  }
}
