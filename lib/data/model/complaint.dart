class OrderModelResponse {
  final String message;
  final List<OrderNoModel> orderNoModel;

  OrderModelResponse({required this.message, required this.orderNoModel});

  factory OrderModelResponse.fromJson(Map<String, dynamic> json) {
    return OrderModelResponse(
        message: json['message'],
        orderNoModel: (json['data'] as List<dynamic>)
            .map((c) => OrderNoModel.fromJson(c))
            .toList());
  }
}

class OrderNoModel {
  final int id;
  final int uniqueNo;

  OrderNoModel({required this.id, required this.uniqueNo});

  factory OrderNoModel.fromJson(Map<String, dynamic> json) {
    return OrderNoModel(
        id: json['id'] ?? 0, uniqueNo: json['uniqueNumber'] ?? 0);
  }
}
