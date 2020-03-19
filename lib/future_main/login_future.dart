import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_find_law_response.dart';
import 'package:prototype_app_pang/model/items_OAGLoginResponse.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaffResponse.dart';

class LoginFuture {
  LoginFuture() : super();

  // ============================ api OAG ============================
  Future<String> apiRequestOAG(String bodyText) async {
    //encode Map to JSON
    try {
      final response = await http.post(
        "http://oag1.uat.excise.go.th/api/oauth/token",
        headers: {'Content-Type': 'application/x-www-form-urlencoded; charset="UTF-8"'},
        body: bodyText,
      );
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

  // =================================================================
  // ============================ api Login ============================
  Future<ItemsOAGLoginResponse> apiRequestLogin(String token, Map jsonMap) async {
    //encode Map to JSON
    var bodyMap = json.encode(jsonMap);
    try {
      final response = await http.post(
        "http://oag1.uat.excise.go.th/api/staff?serviceCode=ILG004",
        headers: {
          'Content-Type': 'application/json',
          'token': "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxODAiLCJpYXQiOjE1ODI3MTM5MjQsInN1YiI6IkludGVncmF0ZWQgUmVxdWVzdCBTZXJ2aWNlIiwiaXNzIjoiY2F0YWxvZyIsImV4cCI6MTU4MjcxMzkyNH0.abXOgL438EynZKgFkJBcwYRO85VckrafnC1JOEp74Gg",
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
  Future<ItemsOAGMasStaffResponse> apiRequestMasStaffgetByCon(String token, Map jsonMap) async {
    //encode Map to JSON
    var bodyMap = json.encode(jsonMap);
    try {
      final response = await http.post(
        "http://oag1.uat.excise.go.th/api/staff?serviceCode=ILG005",
        headers: {
          'Content-Type': 'application/json',
          'token': "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxODEiLCJpYXQiOjE1ODI3MTM5MjQsInN1YiI6IkludGVncmF0ZWQgUmVxdWVzdCBTZXJ2aWNlIiwiaXNzIjoiY2F0YWxvZyIsImV4cCI6MTU4MjcxMzkyNH0.1OH45odBXmwOVmzV51hT_T42hWDrmslZviWE5XN0NEI",
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
  // ============================ api MasLawGroupSubSectionRulegetByConAdv =======================
  Future<List<ItemsFindLawResponse>> apiRequestMasLawGroupSubSectionRulegetByConAdv(String token, Map jsonMap) async {
    //encode Map to JSON
    var bodyMap = json.encode(jsonMap);
    try {
      final response = await http.post(
        "http://oag1.uat.excise.go.th/api/staff?serviceCode=ILG002",
        headers: {
          'Content-Type': 'application/json',
          'token': "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxNzgiLCJpYXQiOjE1ODI3MTM5MjMsInN1YiI6IkludGVncmF0ZWQgUmVxdWVzdCBTZXJ2aWNlIiwiaXNzIjoiY2F0YWxvZyIsImV4cCI6MTU4MjcxMzkyM30.OagBOBz6KWiDK0zKdUqm7RmEd32tKomwOeD8zlICbzE",
          'Authorization': 'Bearer $token',
        },
        body: bodyMap,
      );
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        return responseJson.map((m) => new ItemsFindLawResponse.fromJson(m)).toList();
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
        return null;
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  // ================================================================================
  // ============================ api MasProductGroupgetByCon =======================
  Future<List<ItemsListProductGroup>> apiRequestMasProductGroupgetByCon(String token, Map jsonMap) async {
    //encode Map to JSON
    var bodyMap = json.encode(jsonMap);
    try {
      final response = await http.post(
        "http://oag1.uat.excise.go.th/api/staff?serviceCode=ILG003",
        headers: {
          'Content-Type': 'application/json',
          'token': "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxNzkiLCJpYXQiOjE1ODI3MTM5MjQsInN1YiI6IkludGVncmF0ZWQgUmVxdWVzdCBTZXJ2aWNlIiwiaXNzIjoiY2F0YWxvZyIsImV4cCI6MTU4MjcxMzkyNH0.AQU4oPsIn-x1mzmROI_1QaXYul6WxLa5FWY9djM4Xp0",
          'Authorization': 'Bearer $token',
        },
        body: bodyMap,
      );
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        return responseJson.map((m) => new ItemsListProductGroup.fromJson(m)).toList();
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
        return null;
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
  // =================================================================
}
