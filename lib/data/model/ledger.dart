class LedgerModel {
  String? message;
  List<LedgerData> data;

  LedgerModel({this.message, required this.data});

  factory LedgerModel.fromJson(Map<String, dynamic> json) {
    return LedgerModel(
      message: json['message'],
      data: json['data'] != null
          ? List<LedgerData>.from(
              json['data'].map((item) => LedgerData.fromJson(item)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class LedgerData {
  int? id;
  int? orderId;
  int? crmId;
  String? ledger;
  DateTime? createdDate;

  LedgerData({
    this.id,
    this.orderId,
    this.crmId,
    this.ledger,
    this.createdDate,
  });

  factory LedgerData.fromJson(Map<String, dynamic> json) {
    return LedgerData(
      id: json['id'],
      orderId: json['orderId'],
      crmId: json['crmId'],
      ledger: json['ledger'],
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
