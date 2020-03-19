import 'dart:convert';

import 'package:prototype_app_pang/main_menu/stock/model/stock_list.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class WarehouseFuture {
  WarehouseFuture() : super();

  Future<ItemsWarehouseCase> apiWarehousegetByConAdv(
      Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMasterWarehouse + "/MasWarehousegetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsWarehouseCase.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}
