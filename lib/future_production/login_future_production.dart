import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prototype_app_pang/model/items_OAGLoginResponse.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaffResponse.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;

class LoginFutureProduction {
  LoginFutureProduction() : super();

  // ============================ api OAG ==============================
  Future<String> apiRequestProduction() async {
    //encode Map to JSON
    try {
      // final response = await http.post(
      //   //serv.Server().IPAddressProduction + "/oauth/token",
      //   "http://apigateway.excise.go.th/api/oauth/token",
      // headers: {
      //   'Content-Type': 'application/x-www-form-urlencoded',
      // },
      //   body: bodyMap,
      //   // encoding: Encoding.getByName("utf-8"),
      // );

      String url = 'http://apigateway.excise.go.th/api/oauth/token';
      final response = await http.post(url, body: {
        "grant_type": "password",
        "client_id": "da471738-db76-40cb-baf6-4fdee4140d46",
        "redirect_uri": "some_redirect_uri",
        "code": "some_code_generated_by_salesforce_login",
        "client_secret": "b6cbc79f-a802-4afc-baf4-2e5375cdedba",
        "grant_source": "int_ldap",
        "username": "atthapon",
        "password": "atthapon99",
        "scope": "resource.READ",
      });

      print("codeee: ${response.statusCode}");
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson['access_token'];
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
        return null;
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  // ===================================================================
  // ============================ api Login ============================
  Future<ItemsOAGLoginResponse> apiRequestProductionLogin(String token, Map jsonMap) async {
    //encode Map to JSON
    var bodyMap = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressProduction + "/staff?serviceCode=ILG004",
        headers: {
          'Content-Type': 'application/json',
          'token': "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIyMiIsImlhdCI6MTU4NDY3NjM2OSwic3ViIjoiSW50ZWdyYXRlZCBSZXF1ZXN0IFNlcnZpY2UiLCJpc3MiOiJjYXRhbG9nIiwiZXhwIjoxNTg0Njc2MzY5fQ.ERkrIB5aWJJ8lhqcJosfk7cmjy9e4O9o-4BraAAuO_I",
          'Authorization': 'Bearer $token',
        },
        body: bodyMap,
      );
      if (response.statusCode == 200) {
        return ItemsOAGLoginResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
        return null;
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  // =================================================================
  // ============================ api MasStaff =======================
  Future<ItemsOAGMasStaffResponse> apiRequestProductionMasStaffgetByCon(String token, Map jsonMap) async {
    //encode Map to JSON
    var bodyMap = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressProduction + "/staff?serviceCode=ILG003",
        headers: {
          'Content-Type': 'application/json',
          'token': "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIyMSIsImlhdCI6MTU4NDY3NjMwNCwic3ViIjoiSW50ZWdyYXRlZCBSZXF1ZXN0IFNlcnZpY2UiLCJpc3MiOiJjYXRhbG9nIiwiZXhwIjoxNTg0Njc2MzA0fQ.OHSQCFvmtcxX_zAV6tblo-6CApW5d725o_eJWmDtBwc",
          'Authorization': 'Bearer $token',
        },
        body: bodyMap,
      );

      if (response.statusCode == 200) {
        return ItemsOAGMasStaffResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
        return null;
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  // =============================================================================================
}
