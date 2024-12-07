class PhotoMetadata {
  String imagePath;
  String date;
  String time;
  String latitude;
  String longitude;

  PhotoMetadata({
    required this.imagePath,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'date': date,
        'time': time,
        'latitude': latitude,
        'longitude': longitude,
      };

  // Create object from JSON
  factory PhotoMetadata.fromJson(Map<String, dynamic> json) => PhotoMetadata(
        imagePath: json['imagePath'],
        date: json['date'],
        time: json['time'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
}
