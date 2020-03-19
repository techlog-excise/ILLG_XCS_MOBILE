import 'dart:convert';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;
import 'package:prototype_app_pang/zan/model/person_net_arrest_lawbreaker_relationship.dart';
import 'package:prototype_app_pang/zan/model/person_net_arrest_person.dart';
import 'package:prototype_app_pang/zan/model/person_net_main.dart';

class PersonNetFuture{
  PersonNetFuture() : super();

  Future<ItemsListPersonNetMain> apiRequestPersonDetailgetByPersonId(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressPersonNet + "/PersonDetailgetByPersonId",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsListPersonNetMain.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  Future<List<ItemsListPersonNetArrestPerson>> apiRequestArrestgetByPersonId(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressPersonNetAnalysis + "/ArrestgetByPersonId",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListPersonNetArrestPerson.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  Future<List<ItemsListPersonNetLawbreakerRelationShip>> apiRequestLawbreakerRelationshipgetByPersonId(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressPersonNetAnalysis + "/LawbreakerRelationshipgetByPersonId",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListPersonNetLawbreakerRelationShip.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

}