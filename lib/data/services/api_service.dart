import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shiva_poly_pack/data/controller/local_storage.dart';
import 'package:shiva_poly_pack/data/model/crm_list.dart';
import 'package:shiva_poly_pack/data/model/cus_pending_order.dart';
import 'package:shiva_poly_pack/data/model/final_customer.dart';
import 'package:shiva_poly_pack/data/model/follow_up.dart';
import 'package:shiva_poly_pack/data/model/ledger.dart';
import 'package:shiva_poly_pack/data/model/login.dart';
import 'package:http/http.dart' as http;
import 'package:shiva_poly_pack/data/model/new_customer.dart';
import 'package:shiva_poly_pack/data/model/new_leads.dart';
import 'package:shiva_poly_pack/data/model/pending_files.dart';
import 'package:shiva_poly_pack/data/model/tacker.dart';
import 'package:shiva_poly_pack/data/model/tag_list.dart';
import 'package:shiva_poly_pack/material/color_pallets.dart';
import 'package:shiva_poly_pack/material/indicator.dart';

String getToken() {
  String? token = LocalStorageManager.readData('token');
  return token ?? '';
}

class ApiService {
  String _baseUrl = 'https://api.spolypack.com';
  // String _baseUrl = 'https://pouchworld.in';
  static const String _loginEndpoint = "/api/Account/login";
  static const String _refreshEndpoint = "/api/Account/refresh-token";
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
  static const String _customerPendingOrder =
      "/api/Customer/GetPendingOrders?CrmId=";
  static const String _customerOrderDetailID =
      "/api/Customer/GetOrderById?OrderId=";
  static const String _customerLedgerReport =
      "/api/Customer/GetLedgerReport?CrmId=";
  static const String _customerProfleEndPoint =
      "/api/Customer/GetCustomerProfile?CrmId=";
  static const String _customerAllOrder = "/api/Customer/GetAllOrders?crmId=";
  static const String _submitComplaintEndpoint =
      "/api/Customer/CreateComplaint";
  static const String _editCustomerProfile =
      "/api/Customer/UpdateCustomerProfile";

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

  Future<LoginResponse?> refreshToken(
      RefreshToken request, BuildContext context) async {
    final url = Uri.parse(_baseUrl + _refreshEndpoint);

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

  Future<PendingFilesResponse> fetchPendingFiles(String token, int pageNumber,
      {String? searchValue}) async {
    final url = searchValue != null
        ? Uri.parse(_baseUrl +
            _pendingFilesEndpoint +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11&SearchQuery=$searchValue')
        : Uri.parse(_baseUrl +
            _pendingFilesEndpoint +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11');

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

  Future<FollowUpResponse> fetchFollowUp(String token, int pageNumber,
      {String? searchValue}) async {
    final url = searchValue != null
        ? Uri.parse(_baseUrl +
            _followUpEndpoint +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11&SearchQuery=$searchValue')
        : Uri.parse(_baseUrl +
            _followUpEndpoint +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11');

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

  Future<PostedFollowUpResponse> fetchPostedFollowUp(
      String token, String id, int pageNumber) async {
    final url = Uri.parse(_baseUrl +
        _postedfollowUpEndpoint +
        id +
        '&pageNumber=$pageNumber&pageSize=10');

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
        return PostedFollowUpResponse.fromJson(jsondata);
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

  Future<FinalCustomerModel> fetchFinalCustomer(String token, int pageNumber,
      {String? searchValue}) async {
    final url = searchValue != null
        ? Uri.parse(_baseUrl +
            _getFinalCusEndPoint +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11&SearchQuery=$searchValue')
        : Uri.parse(_baseUrl +
            _getFinalCusEndPoint +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11');

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

  Future<CrmListModelResponse> fetchCRMListCustomer(
      String token, int pageNumber,
      {String? searchValue}) async {
    final url = searchValue != null
        ? Uri.parse(_baseUrl +
            _crmListEndPoint +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11&SearchQuery=$searchValue')
        : Uri.parse(_baseUrl +
            _crmListEndPoint +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11');

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

        return CrmListModelResponse.fromJson(jsondata);
      } else {
        print('Error: ${response.body}');
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

  ///////Customer Api's//////////////////

  Future<PendingOrderResponse> fetchPendingOrders(String token, int pageNumber,
      {String? searchValue}) async {
    final url = searchValue != null
        ? Uri.parse(_baseUrl + _customerPendingOrder)
        : Uri.parse(_baseUrl +
            _customerPendingOrder +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11');

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
        return PendingOrderResponse.fromJson(jsondata);
      } else {
        // Handle errors
        throw Exception(
            "Failed to load leads. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error : $e');
      // Handle exceptions
      throw Exception("Error occurred while fetching leads: $e");
    }
  }

  Future<PendingOrderResponse> fetchOrderDetail(
      String token, int pageNumber, String orderId,
      {String? searchValue}) async {
    final url = searchValue != null
        ? Uri.parse(_baseUrl + _customerOrderDetailID)
        : Uri.parse(_baseUrl +
            _customerOrderDetailID +
            orderId +
            '&pageNumber=$pageNumber&pageSize=11');
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
        return PendingOrderResponse.fromJson(jsondata);
      } else {
        // Handle errors
        throw Exception(
            "Failed to load leads. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error : $e');
      // Handle exceptions
      throw Exception("Error occurred while fetching leads: $e");
    }
  }

  Future<LedgerModel> fetchLedgerdata(String token, int pageNumber,
      {String? searchValue}) async {
    final url = searchValue != null
        ? Uri.parse(_baseUrl + _customerLedgerReport)
        : Uri.parse(_baseUrl +
            _customerLedgerReport +
            LocalStorageManager.getUserId() +
            '&pageNumber=$pageNumber&pageSize=11');

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
        return LedgerModel.fromJson(jsondata);
      } else {
        // Handle errors
        throw Exception(
            "Failed to load leads. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error : $e');
      // Handle exceptions
      throw Exception("Error occurred while fetching leads: $e");
    }
  }

  Future<ProfileResponse> fetchUserProfile(
    String token,
  ) async {
    final url = Uri.parse(
        _baseUrl + _customerProfleEndPoint + LocalStorageManager.getUserId());

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
        return ProfileResponse.fromJson(jsondata);
      } else {
        // Handle errors
        throw Exception(
            "Failed to load leads. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error : $e');
      // Handle exceptions
      throw Exception("Error occurred while fetching leads: $e");
    }
  }

  Future<PendingOrderResponse> fetchAllOrder(String token, int pageNumber,
      {String? searchValue}) async {
    final url = searchValue != null
        ? Uri.parse(_baseUrl + _customerAllOrder)
        : Uri.parse(
            _baseUrl + _customerAllOrder + LocalStorageManager.getUserId()
            // +
            // '&pageNumber=$pageNumber&pageSize=11'
            );

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
        return PendingOrderResponse.fromJson(jsondata);
      } else {
        // Handle errors
        throw Exception(
            "Failed to load leads. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error : $e');
      // Handle exceptions
      throw Exception("Error occurred while fetching leads: $e");
    }
  }

  Future<String> editProfile(
      {required String token,
      required String phoneNo,
      required String name,
      required String alternateNumber,
      required String location,
      required int crmId,
      File? profile}) async {
    try {
      // Create multipart request
      var request = http.MultipartRequest(
          'POST', Uri.parse(_baseUrl + _editCustomerProfile));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      request.fields['Name'] = name;
      request.fields['PhoneNumber'] = phoneNo;
      request.fields['AlternateNumber'] = alternateNumber;
      request.fields['Location'] = location;
      request.fields['CrmId'] = crmId.toString();

      if (profile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'Image',
          profile.path,
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        String message = jsonData['message'];

        return message;
      } else {
        throw Exception(
            "Failed to submit complaint. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Error occurred while submitting complaint: $e");
    }
  }

  Future<dynamic> submitComplaint(
      {required String token,
      required int orderNo,
      required String complaintReason,
      required String message,
      required int crmId,
      File? attachedFile}) async {
    try {
      // Create multipart request
      var request = http.MultipartRequest(
          'POST', Uri.parse(_baseUrl + _submitComplaintEndpoint));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      request.fields['OrderNo'] = orderNo.toString();
      request.fields['Complaintreason'] = complaintReason;
      request.fields['Message'] = message;
      request.fields['CrmId'] = crmId.toString();

      if (attachedFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'AttachedFile',
          attachedFile.path,
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData;
      } else {
        final jsonData = json.decode(response.body);
        String message = jsonData['message'];
        Get.snackbar('Error', message + '\n' + 'Try again later!',
            colorText: Colors.black);
        throw Exception(
            "Failed to submit complaint. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Error occurred while submitting complaint: $e");
    }
  }
}
