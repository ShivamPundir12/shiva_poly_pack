import 'dart:convert';

import 'package:shiva_poly_pack/data/controller/follow_up.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:http/http.dart' as http;
import 'package:shiva_poly_pack/data/model/new_customer.dart';
import 'package:shiva_poly_pack/data/model/new_leads.dart';
import 'package:shiva_poly_pack/data/model/pending_files.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';

String getToken() {
  String? token = LocalStorageManager.readData('token');
  return token ?? '';
}

class ApiService {
  String _baseUrl = 'http://api.spolypack.com';
  static const String _loginEndpoint = "/api/Account/login";
  static const String _leadsEndpoint = "/api/CRM/NewLeads";
  static const String _followUpEndpoint = "/api/CRM/GetTodayFollowUps?userId=";
  static const String _postedfollowUpEndpoint = "/api/CRM/FollowUp?id=";
  static const String _crtfollowUpEndpoint = "/api/CRM/CreateFollowUp";
  static const String _pendingFilesEndpoint =
      "/api/CRM/GetPendingFiles?userId=";
  static const String _tagListEndPoint = "/api/CRM/GetTagList";
  static const String _businesstagListEndPoint =
      "/api/CRM/GetBusinessTypeTagList";
  static const String _createNewCusEndPoint = "/api/CRM/CreateCustomer";
  static const String _getcusbyIdEndPoint = "/api/CRM/GetCustomerById?id=";

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
    print('Token: $token');

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
      print('Exception: $e');
      // Handle exceptions
      throw Exception("Error occurred while fetching leads: $e");
    }
  }

  Future<PendingFilesResponse> fetchPendingFiles(
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
        final jsondata = json.decode(response.body);
        return PendingFilesResponse.fromJson(jsondata);
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

  Future<FollowUpResponse> fetchFollowUp(
    String token,
  ) async {
    final url = Uri.parse(
        _baseUrl + _followUpEndpoint + LocalStorageManager.getUserId());

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        // final data = jsondata['data'];
        return FollowUpResponse.fromJson(jsondata);
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

  Future<List<dynamic>> fetchPostedFollowUp(
    String token,
    String id,
  ) async {
    final url = Uri.parse(_baseUrl + _postedfollowUpEndpoint + id);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        print('DATA: $jsondata');
        // final data = jsondata['data'];
        return jsondata;
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

  Future<FollowUpResponse> createFollowUp(
    CreateFollowupModel request,
  ) async {
    final url = Uri.parse(_baseUrl + _crtfollowUpEndpoint);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        // final data = jsondata['data'];
        return FollowUpResponse.fromJson(jsondata);
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

  Future<TagListResponse> fetchTag(
    String token,
  ) async {
    final url = Uri.parse(_baseUrl + _tagListEndPoint);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        // final data = jsondata['data'];
        return TagListResponse.fromJson(jsondata);
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

  Future<TagListResponse> fetchBussinessTag(
    String token,
  ) async {
    final url = Uri.parse(_baseUrl + _businesstagListEndPoint);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        // final data = jsondata['data'];
        return TagListResponse.fromJson(jsondata);
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

  Future<GetCustomerInfo> createNewCustomer(
      CreateNewCustomer request, String token) async {
    final url = Uri.parse(_baseUrl + _createNewCusEndPoint);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        // final data = jsondata['data'];
        return GetCustomerInfo.fromJson(jsondata);
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

  Future<GetCustomerInfo> getCustomerInfo(String token, String id) async {
    final url = Uri.parse(_baseUrl + _getcusbyIdEndPoint + id);
    print('Token: $token');

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
        return GetCustomerInfo.fromJson(data);
      } else {
        // Handle errors
        throw Exception(
            "Failed to load leads. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Exception: $e');
      // Handle exceptions
      throw Exception("Error occurred while fetching leads: $e");
    }
  }
}
