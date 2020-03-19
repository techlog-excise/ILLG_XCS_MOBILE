import 'dart:convert';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_2.dart';
import 'package:prototype_app_pang/main_menu/notice/model/item_notice_main.dart';
import 'package:prototype_app_pang/main_menu/notice/model/item_notice_search.dart';
import 'package:prototype_app_pang/main_menu/notice/model/item_response_notice.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;
import 'dart:io';

class NoticeFuture {
  NoticeFuture() : super();

  //============================== Get List ==============================
  Future<List<ItemsNoticeSearch>> apiRequestNoticeListgetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/NoticeListgetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsNoticeSearch.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //============================== insert start ==========================

  Future<ItemsResponseNotice> apiRequestNoticeinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsResponseNotice> apiRequestNoticeStaffinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeStaffinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsResponseNotice> apiRequestNoticeProductinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeProductinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsResponseNotice> apiRequestNoticeSupectinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeSupectinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  //============================== insert end ============================

  //============================== update start ==========================
  Future<ItemsResponseNotice> apiRequestNoticeupdByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeupdByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsResponseNotice> apiRequestNoticeStaffupdByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeStaffupdByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsResponseNotice> apiRequestNoticeProductupdByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeProductupdByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
  //============================== update end ============================

  //============================== delete start ==========================
  Future<ItemsResponseNotice> apiRequestNoticeupdDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeupdDelete",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsResponseNotice> apiRequestNoticeStaffupdDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeStaffupdDelete",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsResponseNotice> apiRequestNoticeProductupdDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeProductupdDelete",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsResponseNotice> apiRequestNoticeSuspectupdDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticeSuspectupdDelete",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemsResponseNotice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
  //============================== delete end ============================

  //============================== get start ==========================
  Future<ItemsNoticeMain> apiRequestNoticegetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/NoticegetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsNoticeMain.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
  //============================== get end ============================
}
