import 'dart:convert';

import 'package:prototype_app_pang/main_menu/tracking/model/data_api/tracking_list.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;
import 'dart:io';

class TrackingFuture {
  TrackingFuture() : super();

  Future<ItemsTrackingCase> apiCaseStatusListgetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv
            .Server()
            .IPAddressMasterTracking + "/CaseStatusListgetByConAdv",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsTrackingCase.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsTrackingCaseByKeyword> apiCaseStatusListgetByKeyword(
      Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv
            .Server()
            .IPAddressMasterTracking + "/CaseStatusListgetByKeyword",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsTrackingCaseByKeyword.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsTrackingCaseByCon> apiCaseStatusgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv
            .Server()
            .IPAddressMasterTracking + "/CaseStatusgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsTrackingCaseByCon.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
}
