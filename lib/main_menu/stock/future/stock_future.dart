import 'dart:convert';
import 'package:prototype_app_pang/main_menu/report/model/count_offense.dart';
import 'package:prototype_app_pang/main_menu/report/model/count_offense_area.dart';
import 'package:prototype_app_pang/main_menu/stock/model/evidence_count_balance.dart';
import 'package:prototype_app_pang/main_menu/stock/model/evidence_count_warehouse.dart';
import 'package:prototype_app_pang/main_menu/stock/model/evidence_product_detail_list.dart';
import 'package:prototype_app_pang/main_menu/stock/model/evidence_product_list.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class StockFuture{
  StockFuture() : super();

  Future<ItemsEvidenceCountBalance> apiRequestEvidenceAccountgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterProve + "/EvidenceAccountgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsEvidenceCountBalance.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsEvidenceCountWareHouse> apiRequestEvidenceAccountWarehoustgetByCon(Map jsonMap) async {
    //encode Map to JSON
    print(jsonMap);
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterProve + "/EvidenceAccountWarehoustgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsEvidenceCountWareHouse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsEvidenceProductList>> apiRequestEvidenceAccountProductgetByCon(Map jsonMap) async {
    //encode Map to JSON
    print(jsonMap);
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterProve + "/EvidenceAccountProductgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsEvidenceProductList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  Future<List<ItemsEvidenceProductDetailList>> apiRequestEvidenceAccountProductDetailgetByCon(Map jsonMap) async {
    //encode Map to JSON
    print(jsonMap);
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterProve + "/EvidenceAccountProductDetailgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsEvidenceProductDetailList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}