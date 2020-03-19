import 'dart:convert';

import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main_edit.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_arrest_product_edit.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_staff.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_indicment.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_lawbreaker_edit.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_message.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_save.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_ins_staff.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;
import 'dart:io';

class ArrestFuture {
  ArrestFuture() : super();
  Future<ItemsListArrestMain> apiRequestGet(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        /*var responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListArrestMain.fromJson(m))
          .toList();*/
        return ItemsListArrestMain.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsListArrestMainEdit> apiRequestGetEdit(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsListArrestMainEdit.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsArrestResponse> apiRequestInsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsArrestResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestNoticeupdByCon(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestNoticeupdByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        print(response.body);
        return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    } on NoSuchMethodError catch (_) {
      print('sql error : ' + _.stackTrace.toString());
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestNoticeupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestNoticeupdDelete",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    } on NoSuchMethodError catch (_) {
      print('sql error : ' + _.stackTrace.toString());
    }
  }

  Future<ItemsArrestResponseIndicment> apiRequestInsIndictment(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestIndictmentinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsArrestResponseIndicment.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentProductinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestIndictmentProductinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        print(response.body);
        return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    } on NoSuchMethodError catch (_) {
      print('sql error : ' + _.stackTrace.toString());
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestupdDelete",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  //Create Staff
  Future<ItemsArrestResponseStaffMessage> apiRequestMasStaffinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasStaffinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsArrestResponseStaffMessage.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  //Update Staff
  Future<ItemsArrestResponseStaffMessage> apiRequestMasStaffupdAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasStaffupdAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseStaffMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //Get Staff by Con
  Future<ItemsArrestResponseGetStaff> apiRequestMasStaffgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasStaffgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsArrestResponseGetStaff.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  //Get Staff by ConAdv
  Future<ItemsArrestResponseGetStaff> apiRequestMasStaffgetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasStaffgetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseGetStaff.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //Get Person By ConAdv
  Future<List<ItemsListArrestLawbreaker>> apiRequestMasPersongetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    print("jsonMap: $jsonMap");
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestMasPersongetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListArrestLawbreaker.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //Get Person By Con
  Future<ItemsArrestResponseGetPerson> apiRequestMasPersongetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersongetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseGetPerson.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseStaffMessage> apiRequestMasPersonupdDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      // serv.Server().IPAddressMaster + "/MasPersongetByCon",
      "http://103.233.193.94:2222/XCS60/MasPersonupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseStaffMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseIndicmentDetail> apiRequestArrestIndictmentDetailinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestIndictmentDetailinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseIndicmentDetail.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //****************************UpDelete*****************************
  Future<ItemsArrestResponseMessage> apiRequestArrestLawbreakerupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestLawbreakerupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentDetailupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestIndictmentDetailupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestStaffupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestStaffupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestProductupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestProductupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentProductupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestIndictmentProductupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestIndictmentupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //****************************Update*****************************
  Future<ItemsArrestResponseMessage> apiRequestArrestupdByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestStaffupdByCon(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestStaffupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentupdByCon(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestIndictmentupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestIndictmentProductupdByCon(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestIndictmentProductupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestStaffinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestStaffinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseLawbreakerEdit> apiRequestArrestLawbreakerinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestLawbreakerinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseLawbreakerEdit.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseProductEdit> apiRequestArrestProductinsAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestProductinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseProductEdit.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestArrestProductupdByCon(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestProductupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsListArrest6Section>> apiRequestArrestMasGuiltbasegetByKeyword(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestMasGuiltbasegetByKeyword",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        return responseJson.map((m) => new ItemsListArrest6Section.fromJson(m)).toList();
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
}
