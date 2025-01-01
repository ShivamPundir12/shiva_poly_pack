import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/model/crm_list.dart';
import 'package:shiva_poly_pack/data/model/final_customer.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:http/http.dart' as http;
import 'package:shiva_poly_pack/data/model/new_customer.dart';
import 'package:shiva_poly_pack/data/model/new_leads.dart';
import 'package:shiva_poly_pack/data/model/pending_files.dart';
import 'package:shiva_poly_pack/data/model/tacker.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/material/indicator.dart';

String getToken() {
  String? token = LocalStorageManager.readData('token');
  return token ?? '';
}

class ApiService {
  String _baseUrl = 'https://api.spolypack.com';
  // String _baseUrl = 'https://pouchworld.in';
  static const String _loginEndpoint = "/api/Account/login";
  static const String _leadsEndpoint = "/api/CRM/NewLeads";
  static const String _followUpEndpoint = "/api/CRM/GetTodayFollowUps?userId=";
  static const String _postedfollowUpEndpoint = "/api/CRM/FollowUp?id=";
  static const String _crtfollowUpEndpoint = "/api/CRM/CreateFollowUp";
  static String _updateTagEndpoint = "/api/CRM/UpdateTag?d=&tagId=";
  static const String _pendingFilesEndpoint =
      "/api/CRM/GetPendingFiles?userId=";
  static const String _tagListEndPoint = "/api/CRM/GetTagList";
  static const String _businesstagListEndPoint =
      "/api/CRM/GetBusinessTypeTagList";
  static const String _agenttagListEndPoint = "/api/CRM/GetAgents";
  static const String _createNewCusEndPoint = "/api/CRM/CreateCustomer";
  static const String _getcusbyIdEndPoint = "/api/CRM/GetCustomerById?id=";
  static const String _getFinalCusEndPoint = "/api/CRM/FinalCustomer?userId=";
  static const String _createMarketEndPoint = "/api/CRM/CreateMarket";
  static const String _crmListEndPoint = "/api/CRM/List?userId=";

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

  Future<FollowUpDecode> createFollowUp(
      CreateFollowupModel request, String token) async {
    final url = Uri.parse(_baseUrl + _crtfollowUpEndpoint);

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

        return FollowUpDecode.fromJson(jsondata);
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

  Future<dynamic> updateTag(String token, String tagId, String id) async {
    final url =
        Uri.parse(_baseUrl + "/api/CRM/UpdateTag?CRMId=$id&tagId=" + tagId);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        String message = jsondata['message'];
        if (message == 'Tag updated successfully!') {
          Get.snackbar(
            "Success",
            message,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(
              milliseconds: 1000,
            ),
          );
        } else {
          Get.snackbar(
            "Error",
            message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(
              milliseconds: 1000,
            ),
          );
        }

        return message;
      } else {
        print('Error :-> ${response.body}');
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

  Future<TagListResponse> fetchAgentTag(
    String token,
  ) async {
    final url = Uri.parse(_baseUrl + _agenttagListEndPoint);

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
    final vardata = jsonEncode(request.toApiFormat());
    print("Jspn Data: $vardata");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toApiFormat()),
      );

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        // final data = jsondata['data'];
        return GetCustomerInfo.fromJson(jsondata);
      } else {
        print("Error:->" + response.body);

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

  Future<FinalCustomerModel> fetchFinalCustomer(
    String token,
  ) async {
    final url = Uri.parse(
        _baseUrl + _getFinalCusEndPoint + LocalStorageManager.getUserId());

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
        return FinalCustomerModel.fromJson(jsondata);
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

  Future<List<CRMListModel>> fetchCRMListCustomer(
    String token,
  ) async {
    final url = Uri.parse(
        _baseUrl + _crmListEndPoint + LocalStorageManager.getUserId());

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
        List<CRMListModel> customers = List<CRMListModel>.from(
            jsondata.map((data) => CRMListModel.fromJson(data)));
        return customers;
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

  Future<PhotoMetadataResponse> createMarket(
      PhotoMetadata request, String token) async {
    final url = Uri.parse(_baseUrl + _createMarketEndPoint);
    LoadingView.show();

    try {
      // Prepare Multipart Request
      var requestMultipart = http.MultipartRequest('POST', url);

      // Add headers (e.g., Authorization)
      requestMultipart.headers['Authorization'] = 'Bearer $token';

      // Add form fields (JSON fields)
      requestMultipart.fields['userId'] = request.useerId;
      requestMultipart.fields['Latitude'] = request.latitude.toString();
      requestMultipart.fields['Longitude'] = request.longitude.toString();
      requestMultipart.fields['locationName'] = request.locationName;

      // Attach the image file
      if (request.imagePath != null) {
        Uint8List imageBytes =
            await request.imagePath!.readAsBytes(); // Read binary
        requestMultipart.files.add(
          http.MultipartFile.fromBytes(
            'Picture', // API key for the image
            imageBytes,
            filename: basename(request.imagePath!.path), // Extract file name
          ),
        );
      }

      // Send the request
      var streamedResponse = await requestMultipart.send();

      // Convert streamed response to `Response`
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        LoadingView.hide();
        final jsondata = json.decode(response.body);
        return PhotoMetadataResponse.fromJson(jsondata);
      } else {
        LoadingView.hide();
        Get.snackbar('Error', response.body);
        print("Error Response: ${response.body}");
        throw Exception(
            "Failed to create market. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      LoadingView.hide();
      Get.snackbar('Error', e.toString());
      print("Error: $e");
      throw Exception("Error occurred while creating market: $e");
    }
  }
}
