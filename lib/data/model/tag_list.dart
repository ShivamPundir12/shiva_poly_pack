class TagListResponse {
  final String message;
  final List<Tag> data;

  TagListResponse({
    required this.message,
    required this.data,
  });

  // Factory method to create TagListResponse from JSON
  factory TagListResponse.fromJson(Map<String, dynamic> json) {
    return TagListResponse(
      message: json['message'],
      data: (json['data'] as List).map((e) => Tag.fromJson(e)).toList(),
    );
  }

  // Convert TagListResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Tag {
  final int id;
  final String name;
  final String color;
  final bool isBusinessTag;
  final String createdDate;
  final String fontColor;

  Tag({
    required this.id,
    required this.name,
    required this.color,
    required this.isBusinessTag,
    required this.createdDate,
    required this.fontColor,
  });

  // Factory method to create Tag from JSON
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      color: json['color'] ?? '',
      isBusinessTag: json['isBusinessTag'],
      createdDate: json['createdDate'],
      fontColor: json['fontColor'] ?? '',
    );
  }

  // Convert Tag to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'isBusinessTag': isBusinessTag,
      'createdDate': createdDate,
      'fontColor': fontColor,
    };
  }
}
