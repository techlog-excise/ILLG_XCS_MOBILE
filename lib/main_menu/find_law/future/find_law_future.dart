import 'dart:convert';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;
import 'package:prototype_app_pang/main_menu/find_law/model/item_find_law_response.dart';

class FindLawFuture {
  FindLawFuture() : super();

  Future<List<ItemsFindLawResponse>> apiRequestMasLawGroupSubSectionRulegetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      // serv.Server().IPAddress + "/MasLawGroupSubSectionRulegetByConAdv",
      "http://103.233.193.94:1111/XCS60/MasLawGroupSubSectionRulegetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsFindLawResponse.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}
