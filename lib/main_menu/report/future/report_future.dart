import 'dart:convert';
import 'package:prototype_app_pang/main_menu/report/model/count_offense.dart';
import 'package:prototype_app_pang/main_menu/report/model/count_offense_area.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class ReportFuture{
  ReportFuture() : super();

  Future<List<ItemsCountOffense>> apiRequestCountOffenseOfZoneByTime(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterProve + "/CountOffenseOfZoneByTime",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsCountOffense.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<List<ItemsCountOffenseArea>> apiRequestCountOffenseOfAreaByZone(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterProve + "/CountOffenseOfAreaByZone",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsCountOffenseArea.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}