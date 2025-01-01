import 'package:camera/camera.dart';

class PhotoMetadataResponse {
  final String message;
  final PhotoMetadata data;

  PhotoMetadataResponse({required this.message, required this.data});

  factory PhotoMetadataResponse.fromJson(Map<String, dynamic> json) =>
      PhotoMetadataResponse(
          message: json['message'], data: PhotoMetadata.fromJson(json['data']));
}

class PhotoMetadata {
  XFile? imagePath;
  String useerId;
  double latitude;
  double longitude;
  String locationName;
  DateTime? createdDate;
  String? photoUrl;

  PhotoMetadata({
    this.imagePath,
    required this.useerId,
    required this.latitude,
    required this.longitude,
    required this.locationName,
    this.photoUrl,
    this.createdDate,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'Picture': imagePath,
        'userId': useerId,
        'Latitude': latitude,
        'Longitude': longitude,
        'locationName': locationName
      };

  // Create object from JSON
  factory PhotoMetadata.fromJson(Map<String, dynamic> json) => PhotoMetadata(
        useerId: json['userId'],
        latitude: json['Latitude'] ?? 0,
        longitude: json['Longitude'] ?? 0,
        locationName: json['locationName'] ?? '',
        photoUrl: json['pictureUrl'] ?? '',
        createdDate: DateTime.parse(
            json['createdDate'] ?? DateTime.now().toIso8601String()),
      );
}
