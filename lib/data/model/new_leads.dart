class LeadsResponse {
  final String message;
  final List<Lead> leadsWithLargeCustomer;
  final List<Lead> leadsWithSmallCustomer;

  LeadsResponse({
    required this.message,
    required this.leadsWithLargeCustomer,
    required this.leadsWithSmallCustomer,
  });

  // Factory method to parse JSON into LeadsResponse
  factory LeadsResponse.fromJson(Map<String, dynamic> json) {
    return LeadsResponse(
      message: json['message'],
      leadsWithLargeCustomer: (json['leadsWithLargeCustomer'] as List)
          .map((lead) => Lead.fromJson(lead))
          .toList(),
      leadsWithSmallCustomer: (json['leadsWithSmallCustomer'] as List)
          .map((lead) => Lead.fromJson(lead))
          .toList(),
    );
  }
}

class Lead {
  final int id;
  final String name;
  final String phoneNumber;
  final String location;
  final String kindofPouch;
  final String requirePouchSize;
  final String pouchQuantityPerSize;
  final DateTime createdDate;
  final bool isSmallCustomer;

  Lead({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.kindofPouch,
    required this.requirePouchSize,
    required this.pouchQuantityPerSize,
    required this.createdDate,
    required this.isSmallCustomer,
  });

  // Factory method to parse JSON into a Lead object
  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      location: json['location'],
      kindofPouch: json['kindofPouch'],
      requirePouchSize: json['requirePouchSize'],
      pouchQuantityPerSize: json['pouchQuantityPerSize'],
      createdDate: DateTime.parse(json['createdDate']),
      isSmallCustomer: json['isSmallCustomer'],
    );
  }
}
