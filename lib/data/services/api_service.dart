import 'dart:convert';

import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:http/http.dart' as http;
import 'package:shiva_poly_pack/data/model/new_leads.dart';

String getToken() {
  String? token = LocalStorageManager.readData('token');
  return token ?? '';
}

class ApiService {
  String _baseUrl = 'http://api.spolypack.com';
  static const String _loginEndpoint = "/api/Account/login";
  static const String _leadsEndpoint = "/api/CRM/NewLeads";
  static const String _pendingFilesEndpoint =
      "/api/CRM/GetPendingFiles?userId=";

  // Login method
  Future<LoginResponse?> login(LoginRequest request) async {
    final url = Uri.parse(_baseUrl + _loginEndpoint);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return LoginResponse.fromJson(responseData);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception during API call: $e");
      return null;
    }
  }

  Future<LeadsResponse> fetchNewLeads(String token) async {
    final url = Uri.parse(_baseUrl + _leadsEndpoint);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return LeadsResponse.fromJson(data);
      } else {
        // Handle errors
        throw Exception(
            "Failed to load leads. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      throw Exception("Error occurred while fetching leads: $e");
    }
  }

  Future<LeadsResponse> fetchPendingFiles(
    String token,
  ) async {
    final url = Uri.parse(
        _baseUrl + _pendingFilesEndpoint + LocalStorageManager.getUserId());

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return LeadsResponse.fromJson(data);
      } else {
        // Handle errors
        throw Exception(
            "Failed to load leads. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      throw Exception("Error occurred while fetching leads: $e");
    }
  }
}
