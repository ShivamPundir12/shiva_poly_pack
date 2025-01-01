import 'dart:convert';

class CreateNewCustomer {
  final String? name;
  final String? phoneNumber;
  final String? alternateNumber;
  final String? location;
  final List<String>? tagsId;
  final List<String>? businessTypeTagsId;
  final int agentId;
  final int id;
  // final List<String>? agentId;
  final String? userId;
  final String? folowUpDate;
  final String? additionalNote;

  CreateNewCustomer({
    this.name,
    this.phoneNumber,
    this.alternateNumber,
    this.location,
    this.tagsId,
    this.businessTypeTagsId,
    required this.agentId,
    this.userId,
    required this.id,
    this.additionalNote,
    this.folowUpDate,
  });

  // Factory to create from JSON
  factory CreateNewCustomer.fromJson(Map<String, dynamic> json) {
    return CreateNewCustomer(
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      alternateNumber: json['alternateNumber'] as String?,
      location: json['location'] as String?,
      tagsId: json['tagsId'] != null ? List<String>.from(json['tagsId']) : null,
      businessTypeTagsId: json['businessTypeTagsId'] != null
          ? List<String>.from(json['businessTypeTagsId'])
          : null,
      agentId: json['agentId'],
      userId: json['userId'] as String?,
      additionalNote: json['additionalNote'] as String?,
      id: json['id'],
    );
  }

  // Method to convert data to API format
  Map<String, dynamic> toApiFormat() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "alternateNumber": alternateNumber,
      "location": location,
      "followUpDate": folowUpDate,
      "tagsId": tagsId != null ? tagsId?.join(',') : null,
      "businessTypeTagsId":
          businessTypeTagsId != null ? businessTypeTagsId?.join(',') : null,
      "agentId": agentId,
      "userId": userId,
      "id": id,
      "additionalNote": additionalNote,
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
      agentId: json['agentId'] ?? 0,
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
