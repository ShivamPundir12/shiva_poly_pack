import 'dart:convert';

class CRMListModel {
  String name;
  int id;
  String phoneNumber;
  List<dynamic> tags;
  List<dynamic> colour;
  List<dynamic> fontColour;
  String location;
  List<dynamic> businessTags;
  String lastComment;
  String partyName;

  CRMListModel({
    required this.name,
    required this.id,
    required this.phoneNumber,
    required this.tags,
    required this.location,
    required this.businessTags,
    required this.lastComment,
    required this.partyName,
    required this.colour,
    required this.fontColour,
  });

  // Convert JSON data to CRMListModel object
  factory CRMListModel.fromJson(Map<String, dynamic> json) {
    return CRMListModel(
      name: json['name'],
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      tags: json['tags'], // Decode tags JSON string
      location: json['location'],
      businessTags: json['businessTags'], // Decode businessTags JSON string
      lastComment: json['lastComment'],
      partyName: json['partyName'],
      colour: json['colour'],
      fontColour: json['fontColour'],
    );
  }

  // Convert CRMListModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'tags': jsonEncode(tags), // Encode tags list to JSON string
      'location': location,
      'businessTags':
          jsonEncode(businessTags), // Encode businessTags list to JSON string
      'lastComment': lastComment,
      'partyName': partyName,
    };
  }
}
