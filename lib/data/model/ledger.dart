class LedgerModel {
  String? message;
  List<LedgerData> data;
  Pagination pagination;

  LedgerModel({this.message, required this.data, required this.pagination});

  factory LedgerModel.fromJson(Map<String, dynamic> json) {
    return LedgerModel(
      message: json['message'],
      data: json['data'] != null
          ? List<LedgerData>.from(
              json['data'].map((item) => LedgerData.fromJson(item)))
          : [],
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
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

class LedgerData {
  int? id;
  int? orderId;
  int? crmId;
  String? ledger;
  String? orderName;
  DateTime? createdDate;

  LedgerData({
    this.id,
    this.orderId,
    this.crmId,
    this.ledger,
    this.createdDate,
    this.orderName,
  });

  factory LedgerData.fromJson(Map<String, dynamic> json) {
    return LedgerData(
      id: json['id'],
      orderId: json['orderId'],
      crmId: json['crmId'],
      ledger: json['ledger'],
      orderName: json['orderName'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'crmId': crmId,
      'ledger': ledger,
      'createdDate': createdDate?.toIso8601String(),
    };
  }
}
