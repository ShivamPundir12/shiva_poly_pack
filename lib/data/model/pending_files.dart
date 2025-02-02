class PendingFilesResponse {
  final String message;
  final List<PendingFile> pendingFiles;
  final Pagination pagination;

  PendingFilesResponse({
    required this.message,
    required this.pendingFiles,
    required this.pagination,
  });

  factory PendingFilesResponse.fromJson(Map<String, dynamic> json) {
    return PendingFilesResponse(
      message: json['message'],
      pendingFiles: (json['data'] as List<dynamic>)
          .map((item) => PendingFile.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Pagination {
  final int currentPage;
  final int pageSize;
  final int totalRecords;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.pageSize,
    required this.totalRecords,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
      totalRecords: json['totalRecords'],
      totalPages: json['totalPages'],
    );
  }
}

class PendingFile {
  final int id;
  final String name;
  final String phoneNumber;
  final String? alternateNumber;
  final String location;
  final String? tagsId;
  final String? businessTypeTagsId;
  final int? agentId;
  final String userId;
  final DateTime followUpDate;
  final String? additionalNote;
  final DateTime createdDate;
  final bool? isFinalCustomer;

  PendingFile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.alternateNumber,
    required this.location,
    this.tagsId,
    this.businessTypeTagsId,
    this.agentId,
    required this.userId,
    required this.followUpDate,
    this.additionalNote,
    required this.createdDate,
    this.isFinalCustomer,
  });

  // Factory method to parse JSON into a PendingFile object
  factory PendingFile.fromJson(Map<String, dynamic> json) {
    return PendingFile(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      alternateNumber: json['alternateNumber'],
      location: json['location'],
      tagsId: json['tagsId'],
      businessTypeTagsId: json['businessTypeTagsId'],
      agentId: json['agentId'],
      userId: json['userId'],
      followUpDate: DateTime.parse(json['followUpDate']),
      additionalNote: json['additionalNote'],
      createdDate: DateTime.parse(json['createdDate']),
      isFinalCustomer: json['isFinalCustomer'],
    );
  }

  // Method to convert a PendingFile object into JSON (useful for sending data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'alternateNumber': alternateNumber,
      'location': location,
      'tagsId': tagsId,
      'businessTypeTagsId': businessTypeTagsId,
      'agentId': agentId,
      'userId': userId,
      'followUpDate': followUpDate.toIso8601String(),
      'additionalNote': additionalNote,
      'createdDate': createdDate.toIso8601String(),
      'isFinalCustomer': isFinalCustomer,
    };
  }
}
