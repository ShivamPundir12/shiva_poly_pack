class FinalCustomerModel {
  final String message;
  final List<FinalCustomerData> data;
  final Pagination pagination;

  FinalCustomerModel({
    required this.message,
    required this.data,
    required this.pagination,
  });

  // Factory to create a FinalCustomerModel from JSON
  factory FinalCustomerModel.fromJson(Map<String, dynamic> json) {
    return FinalCustomerModel(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => FinalCustomerData.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  // Convert the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
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

// Sub-model for the customer data
class FinalCustomerData {
  final int id;
  final String name;
  final String phoneNumber;
  final String location;
  final DateTime createdDate;

  FinalCustomerData({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.createdDate,
  });

  // Factory to create a CustomerData object from JSON
  factory FinalCustomerData.fromJson(Map<String, dynamic> json) {
    return FinalCustomerData(
      id: json['id'] as int,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      location: json['location'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
    );
  }

  // Convert the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'location': location,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
