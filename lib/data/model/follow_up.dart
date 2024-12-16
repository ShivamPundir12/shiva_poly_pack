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
      'tags': tags,
    };
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
      tagsId: json['tagsId'],
      crmId: json['crmId'],
      createdDate: json['createdDate'],
      isFollowUpDone: json['isFollowUpDone'],
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
