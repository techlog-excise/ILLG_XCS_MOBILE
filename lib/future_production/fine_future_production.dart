import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_find_law_response.dart';
import 'package:prototype_app_pang/model/items_OAGLoginResponse.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaffResponse.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;

class FineFutureProduction {
  FineFutureProduction() : super();

  // ============================ api MasLawGroupSubSectionRulegetByConAdv =======================
  Future<List<ItemsFindLawResponse>> apiRequestProductionMasLawGroupSubSectionRulegetByConAdv(String token, Map jsonMap) async {
    //encode Map to JSON
    var bodyMap = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressProduction + "/staff?serviceCode=ILG001",
        headers: {
          'Content-Type': 'application/json',
          'token': "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxOSIsImlhdCI6MTU4NDQ0MTYyNywic3ViIjoiSW50ZWdyYXRlZCBSZXF1ZXN0IFNlcnZpY2UiLCJpc3MiOiJjYXRhbG9nIiwiZXhwIjoxNTg0NDQxNjI3fQ._XPqPQqSSf-wHrb_GCnu9XITZHEBf5v4Umj3dSVeMJE",
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
  Future<List<ItemsListProductGroup>> apiRequestProductionMasProductGroupgetByCon(String token, Map jsonMap) async {
    //encode Map to JSON
    var bodyMap = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressProduction + "/staff?serviceCode=ILG002",
        headers: {
          'Content-Type': 'application/json',
          'token': "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIyMCIsImlhdCI6MTU4NDY3NjMwOCwic3ViIjoiSW50ZWdyYXRlZCBSZXF1ZXN0IFNlcnZpY2UiLCJpc3MiOiJjYXRhbG9nIiwiZXhwIjoxNTg0Njc2MzA4fQ.NhuTpEJDL9oD3I1zde2Ho_UYtqw6fqw2eJLfI1YVi-U",
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
