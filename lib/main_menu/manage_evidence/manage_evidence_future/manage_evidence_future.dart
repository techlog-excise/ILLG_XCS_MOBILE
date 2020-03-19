import 'dart:convert';
import 'dart:developer';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_message.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_arrest.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_list.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_main.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/response/item_evidence_response_ins.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_list.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_inventory.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_inventory_list.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_list.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_main.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/response/item_evidence_response_ins.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class ManageEvidenceFuture {
  ManageEvidenceFuture() : super();

  /*Future<List<ItemsEvidenceList>> apiRequestEvidenceInListgetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressEvidence + "/EvidenceInListgetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsEvidenceList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsEvidenceList>> apiRequestCompareListgetByKeyword(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressEvidence + "/CompareListgetByKeyword",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsEvidenceList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }*/
  Future<List<ItemsEvidenceOutList>> apiRequestEvidenceOutListgetByConAdv(
      Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut + "/EvidenceOutListgetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson
          .map((m) => new ItemsEvidenceOutList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //Evidence
  Future<ItemsEvidenceOutMain> apiRequestEvidenceOutgetByCon(
      Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut + "/EvidenceOutgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      if (response.body.toString().trim().isNotEmpty) {
        return ItemsEvidenceOutMain.fromJson(json.decode(response.body));
      }
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsResponseEvidenceOut> apiRequestEvidenceOutinsAll(
      Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut + "/EvidenceOutinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsResponseEvidenceOut.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestEvidenceOutupdByCon(
      Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut + "/EvidenceOutupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestEvidenceOutupdDelete(
      Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut + "/EvidenceOutupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestEvidenceOutStockBalanceupdByCon(
      Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut + "/EvidenceOutStockBalanceupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<EvidenceInventoryList>>
      apiRequestEvidenceInventoryListgetByEvidenceInItemCode(
          Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut +
          "/EvidenceInventoryListgetByEvidenceInItemCode",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson
          .map((m) => new EvidenceInventoryList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<EvidenceInventory>> apiRequestEvidenceInventoryListgetByCon(
      Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut + "/EvidenceInventoryListgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson
          .map((m) => new EvidenceInventory.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<EvidenceInventoryList>>
      apiRequestEvidenceInventoryListgetByLawsuitNo(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut +
          "/EvidenceInventoryListgetByLawsuitNo",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson
          .map((m) => new EvidenceInventoryList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestEvidenceOutIteminsAll(
      List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut + "/EvidenceOutIteminsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestEvidenceOutItemupdDelete(
      List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressEvidenceOut + "/EvidenceOutItemupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
}
