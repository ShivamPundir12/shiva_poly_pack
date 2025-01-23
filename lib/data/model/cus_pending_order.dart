class PendingOrderResponse {
  String message;
  List<PendingOrderData> data;
  // Pagination pagination;
  PendingOrderResponse({required this.message, required this.data});

  factory PendingOrderResponse.fromJson(Map<String, dynamic> json) {
    return PendingOrderResponse(
      message: json['message'] ?? '',
      data: json['data'] != null
          ? (json['data'] as List)
              .map((item) => PendingOrderData.fromJson(item))
              .toList()
          : [],
      // pagination: Pagination.fromJson(json['pagination']),
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

class PendingOrderData {
  int? id;
  String? jobName;
  String? orderPic;
  int? sizeId;
  dynamic size;
  int? metal;
  int? cbp;
  String? pcsEstimate;
  double? cylinderDiameter;
  String? jobColour;
  int? purchaserId;
  dynamic purchaser;
  String? pouchType;
  int? stageNumber;
  DateTime? dispatchDate;
  bool? isAgent;
  int? tblCrmId;
  dynamic agentId;
  dynamic tblCrm;
  dynamic additionalNote;
  String? pressure;
  String? lamination;
  int? uniqueNumber;
  String? progressStatus;
  int? orderSetsId;
  dynamic orderSets;
  int? sizePouchId;
  dynamic sizePouch;
  bool? isScheduled;
  double? totalPolyUsed;
  double? totalMetalUsed;
  double? totalLDUsed;
  DateTime? createdDate;
  dynamic mobileNumber;
  dynamic name;
  dynamic dispatchJobRollId;
  dynamic isDone;
  dynamic isLDPurchased;
  dynamic isPolyPurchased;
  dynamic isMetalPurchased;
  String? userId;
  String? stage;
  List<dynamic>? orderHistories;

  PendingOrderData({
    this.id,
    this.jobName,
    this.orderPic,
    this.sizeId,
    this.size,
    this.metal,
    this.cbp,
    this.pcsEstimate,
    this.cylinderDiameter,
    this.jobColour,
    this.purchaserId,
    this.purchaser,
    this.pouchType,
    this.dispatchDate,
    this.isAgent,
    this.tblCrmId,
    this.agentId,
    this.tblCrm,
    this.additionalNote,
    this.pressure,
    this.lamination,
    this.uniqueNumber,
    this.progressStatus,
    this.orderSetsId,
    this.orderSets,
    this.sizePouchId,
    this.sizePouch,
    this.isScheduled,
    this.totalPolyUsed,
    this.totalMetalUsed,
    this.totalLDUsed,
    this.createdDate,
    this.mobileNumber,
    this.name,
    this.dispatchJobRollId,
    this.isDone,
    this.isLDPurchased,
    this.isPolyPurchased,
    this.isMetalPurchased,
    this.userId,
    this.stage,
    this.orderHistories,
    this.stageNumber,
  });

  factory PendingOrderData.fromJson(Map<String, dynamic> json) {
    return PendingOrderData(
      id: json['id'],
      jobName: json['jobName'],
      orderPic: json['orderPic'],
      sizeId: json['sizeId'],
      size: json['size'],
      metal: json['metal'],
      cbp: json['cbp'],
      pcsEstimate: json['pcsEstimate'],
      cylinderDiameter: (json['cylinderDiameter'] as num?)?.toDouble(),
      jobColour: json['jobColour'],
      purchaserId: json['purchaserId'],
      purchaser: json['purchaser'],
      pouchType: json['pouchType'],
      stageNumber: json['stageNumber'],
      dispatchDate: json['dispatchDate'] != null
          ? DateTime.parse(json['dispatchDate'])
          : null,
      isAgent: json['isAgent'],
      tblCrmId: json['tblCrmId'],
      agentId: json['agentId'],
      tblCrm: json['tblCrm'],
      additionalNote: json['additionalNote'],
      pressure: json['pressure'],
      lamination: json['lamination'],
      uniqueNumber: json['uniqueNumber'],
      progressStatus: json['progressStatus'],
      orderSetsId: json['orderSetsId'],
      orderSets: json['orderSets'],
      sizePouchId: json['sizePouchId'],
      sizePouch: json['sizePouch'],
      isScheduled: json['isScheduled'],
      totalPolyUsed: (json['totalPolyUsed'] as num?)?.toDouble(),
      totalMetalUsed: (json['totalMetalUsed'] as num?)?.toDouble(),
      totalLDUsed: (json['totalLDUsed'] as num?)?.toDouble(),
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      mobileNumber: json['mobileNumber'],
      name: json['name'],
      dispatchJobRollId: json['dispatchJobRollId'],
      isDone: json['isDone'],
      isLDPurchased: json['isLDPurchased'],
      isPolyPurchased: json['isPolyPurchased'],
      isMetalPurchased: json['isMetalPurchased'],
      userId: json['userId'],
      stage: json['stage'],
      orderHistories: json['orderHistories'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobName': jobName,
      'orderPic': orderPic,
      'sizeId': sizeId,
      'size': size,
      'metal': metal,
      'cbp': cbp,
      'pcsEstimate': pcsEstimate,
      'cylinderDiameter': cylinderDiameter,
      'jobColour': jobColour,
      'purchaserId': purchaserId,
      'purchaser': purchaser,
      'pouchType': pouchType,
      'dispatchDate': dispatchDate?.toIso8601String(),
      'isAgent': isAgent,
      'tblCrmId': tblCrmId,
      'agentId': agentId,
      'tblCrm': tblCrm,
      'additionalNote': additionalNote,
      'pressure': pressure,
      'lamination': lamination,
      'uniqueNumber': uniqueNumber,
      'progressStatus': progressStatus,
      'orderSetsId': orderSetsId,
      'orderSets': orderSets,
      'sizePouchId': sizePouchId,
      'sizePouch': sizePouch,
      'isScheduled': isScheduled,
      'totalPolyUsed': totalPolyUsed,
      'totalMetalUsed': totalMetalUsed,
      'totalLDUsed': totalLDUsed,
      'createdDate': createdDate?.toIso8601String(),
      'mobileNumber': mobileNumber,
      'name': name,
      'dispatchJobRollId': dispatchJobRollId,
      'isDone': isDone,
      'isLDPurchased': isLDPurchased,
      'isPolyPurchased': isPolyPurchased,
      'isMetalPurchased': isMetalPurchased,
      'userId': userId,
      'stage': stage,
      'orderHistories': orderHistories,
    };
  }
}
