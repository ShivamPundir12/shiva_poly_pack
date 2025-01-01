import 'dart:convert';

class FollowUpItem {
  final String location;
  final String name;
  final String phoneNumber;
  final String date;

  FollowUpItem({
    required this.location,
    required this.name,
    required this.phoneNumber,
    required this.date,
  });
}

class FollowUpResponse {
  final List<dynamic> followUp;
  FollowUpResponse({required this.followUp});

  factory FollowUpResponse.fromJson(Map<String, dynamic> json) {
    return FollowUpResponse(
      followUp: (json['todayFollowUpList'] as List<dynamic>)
          .map((item) => FollowupModel.fromJson(item))
          .toList(),
    );
  }
}

class FollowUpDecode {
  final String message;
  final FollowUpData data;

  FollowUpDecode({
    required this.message,
    required this.data,
  });

  // Factory method to create FollowUpResponse from JSON
  factory FollowUpDecode.fromJson(Map<String, dynamic> json) {
    return FollowUpDecode(
      message: json['message'],
      data: FollowUpData.fromJson(json['data']),
    );
  }

  // Convert FollowUpResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class FollowupModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String? alternateNumber;
  final String location;
  final List<String>? tagsId;
  final List<String>? tagsName;
  final String? businessTypeTagsId;
  final int? agentId;
  final int? userId;
  final DateTime? followUpDate;
  final String? additionalNote;
  final DateTime createdDate;
  final bool? isFinalCustomer;

  FollowupModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.alternateNumber,
    required this.location,
    this.tagsId,
    this.tagsName,
    this.businessTypeTagsId,
    this.agentId,
    this.userId,
    this.followUpDate,
    this.additionalNote,
    required this.createdDate,
    this.isFinalCustomer,
  });

  // Factory method to parse JSON and create a FollowupModel instance
  factory FollowupModel.fromJson(Map<String, dynamic> json) {
    return FollowupModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      alternateNumber: json['alternateNumber'] as String?,
      location: json['location'] as String,
      tagsName: json['tagsName'] != null
          ? List<String>.from(
              (json['tagsName'] as String)
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll('"', '')
                  .split(','),
            )
          : null,
      tagsId: json['tagsId'] != null
          ? List<String>.from(
              (json['tagsId'] as String)
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll('"', '')
                  .split(','),
            )
          : null,
      businessTypeTagsId: json['businessTypeTagsId'] as String?,
      agentId: json['agentId'] as int?,
      userId: json['userId'] as int?,
      followUpDate: json['followUpDate'] != null
          ? DateTime.tryParse(json['followUpDate'])
          : null,
      additionalNote: json['additionalNote'] as String?,
      createdDate: DateTime.parse(json['createdDate']),
      isFinalCustomer: json['isFinalCustomer'] as bool?,
    );
  }

  // Method to convert FollowupModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'alternateNumber': alternateNumber,
      'location': location,
      'tagsId': tagsId != null ? tagsId : null,
      'businessTypeTagsId': businessTypeTagsId,
      'agentId': agentId,
      'userId': userId,
      'followUpDate': followUpDate?.toIso8601String(),
      'additionalNote': additionalNote,
      'createdDate': createdDate.toIso8601String(),
      'isFinalCustomer': isFinalCustomer,
    };
  }
}

class CreateFollowupModel {
  final String crmId;
  final DateTime followupDate;
  final String review;
  final String tags;

  CreateFollowupModel({
    required this.crmId,
    required this.followupDate,
    required this.review,
    required this.tags,
  });

  // Method to convert FollowupModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'crmId': crmId,
      'followupDate': followupDate.toIso8601String(),
      'review': review,
      'tagsId': tags,
    };
  }
}

class PostedFollowUp {
  final String customerName;
  final DateTime followupDate;
  final String review;
  final List<String> tags;
  final List<dynamic> tagsName;

  PostedFollowUp({
    required this.customerName,
    required this.followupDate,
    required this.review,
    required this.tags,
    required this.tagsName,
  });

  // Factory constructor to create a FollowUp object from JSON
  factory PostedFollowUp.fromJson(Map<String, dynamic> json) {
    return PostedFollowUp(
      customerName: json['customerName'] as String,
      followupDate: DateTime.parse(json['followupDate']),
      review: json['review'] as String,
      tags: parseTags(json['tags']),
      tagsName: json['tagsName'] ?? [],
    );
  }

  // Convert FollowUp object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'followupDate': followupDate.toIso8601String(),
      'review': review,
      'tags': tags,
    };
  }

  // Custom method to parse the tags field
  static List<String> parseTags(dynamic tagsField) {
    List<String> setList = [];

    if (tagsField is String) {
      try {
        // If the string looks like a JSON array, decode it
        final dynamic decoded = jsonDecode(tagsField);
        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        } else {
          if (!setList.contains(tagsField)) {
            setList.add(tagsField);
          }
        }
      } catch (e) {
        // If it fails, assume it's a single tag and return it as a list
        return setList.toList();
      }
    } else if (tagsField is List) {
      return tagsField.map((e) => e.toString()).toList();
    }
    return setList;
  }
}

class FollowUpData {
  final int id;
  final String followUpDate;
  final String review;
  final String tagsId;
  final int crmId;
  final String createdDate;
  final bool isFollowUpDone;

  FollowUpData({
    required this.id,
    required this.followUpDate,
    required this.review,
    required this.tagsId,
    required this.crmId,
    required this.createdDate,
    required this.isFollowUpDone,
  });

  // Factory method to create FollowUpData from JSON
  factory FollowUpData.fromJson(Map<String, dynamic> json) {
    return FollowUpData(
      id: json['id'],
      followUpDate: json['followUpDate'],
      review: json['review'],
      tagsId: json['tagsId'] ?? '',
      crmId: json['crmId'],
      createdDate: json['createdDate'],
      isFollowUpDone: json['isFollowUpDone'] ?? false,
    );
  }

  // Convert FollowUpData to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'followUpDate': followUpDate,
      'review': review,
      'tagsId': tagsId,
      'crmId': crmId,
      'createdDate': createdDate,
      'isFollowUpDone': isFollowUpDone,
    };
  }
}
