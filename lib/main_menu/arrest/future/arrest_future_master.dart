import 'dart:convert';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category_SRP_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_brand.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_category_RDB.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_groups_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_prcInq_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;
import 'dart:io';

class ArrestFutureMaster {
  ArrestFutureMaster() : super();

  Future<List<ItemsListArrestSearch>> apiRequestArrestListgetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestListgetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListArrestSearch.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsListArrestSearch>> apiRequest(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/ArrestListgetByKeyword",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        return responseJson.map((m) => new ItemsListArrestSearch.fromJson(m)).toList();
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterTitleResponse> apiRequestMasTitlegetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasTitlegetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsMasterTitleResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterCountryResponse> apiRequestMasCountrygetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasCountrygetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterCountryResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterProvinceResponse> apiRequestMasProvincegetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasProvincegetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterProvinceResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterDistictResponse> apiRequestMasDistrictgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasDistrictgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterDistictResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterSubDistictResponse> apiRequestMasSubDistrictgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasSubDistrictgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterSubDistictResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterPersonResponseData> apiRequestMasPersoninsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersoninsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterPersonResponseData.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterPersonResponseData> apiRequestMasPersonupdAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersonupdAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ItemsMasterPersonResponseData.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterPersonResponseData> apiRequestMasPersonRelationshipinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersonRelationshipinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterPersonResponseData.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsMasterPersonResponseEmpty>> apiRequestMasPersonRelationshipupdAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersonRelationshipupdAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsMasterPersonResponseEmpty.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsMasterPersonResponseEmpty>> apiRequestMasPersonRelationshipupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersonRelationshipupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsMasterPersonResponseEmpty.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterPersonResponseEmpty> apiRequestMasPersonAddressinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersonAddressinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterPersonResponseEmpty.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsMasterPersonResponseEmpty>> apiRequestMasPersonAddressupdAll(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersonAddressupdAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsMasterPersonResponseEmpty.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsMasterPersonResponseEmpty>> apiRequestMasPersonAddressupdDelete(List<Map> jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersonAddressupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsMasterPersonResponseEmpty.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterPersonResponseData> apiRequestMasPersonPhotoinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersonPhotoinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterPersonResponseData.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterGetPersonResponse> apiRequestMasPersongetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasPersongetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterGetPersonResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //product
  Future<List<ItemsListProductGroup>> apiRequestMasProductGroupgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/MasProductGroupgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        return responseJson.map((m) => new ItemsListProductGroup.fromJson(m)).toList();
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductCategoryResponse> apiRequestMasProductCategorygetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasProductCategorygetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterProductCategoryResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterProductTypeResponse> apiRequestMasProductTypegetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddressMaster + "/MasProductTypegetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsMasterProductTypeResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsMasterProductSubTypeResponse> apiRequestMasProductSubTypegetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductSubTypegetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsMasterProductSubTypeResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductSubSetTypeResponse> apiRequestMasProductSubSetTypegetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductSubSetTypegetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsMasterProductSubSetTypeResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductBrandResponse> apiRequestMasProductBrandgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductBrandgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsMasterProductBrandResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductSubBrandResponse> apiRequestMasProductSubBrandgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductSubBrandgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsMasterProductSubBrandResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductModelResponse> apiRequestMasProductModelgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductModelgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsMasterProductModelResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsListProductGROUPCategorySRPResponse> apiRequestInquiryDutyGroup(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    // var body = utf8.encode(json.encode(jsonMap));
    try {
      final response = await http.post(
        "http://webtest.excise.go.th/EDRestServicesUAT/rdb/InquiryDutyGroup",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        return ItemsListProductGROUPCategorySRPResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<List<ItemsListArrestProductMapping>> apiRequestMasProductMappinggetByConAdv(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMasterLawsuit + "/MasProductMappinggetByConAdv",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        return responseJson.map((m) => new ItemsListArrestProductMapping.fromJson(m)).toList();
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsPrcInqResponse> apiRequestPrcInqProductByName(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        "http://webtest.excise.go.th/EDRestServicesUAT/prc/PrcInqProductByName",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        if (response.contentLength <= 2) {
          // no data will return contentLength = 2
          return null;
        } else {
          return ItemsPrcInqResponse.fromJson(json.decode(response.body));
        }
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductMappingResponse> apiRequestMasProductMappinggetByKeyword(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMasterLawsuit + "/MasProductMappinggetByKeyword",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasterProductMappingResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductMappingResponse> apiRequestMasProductMappinggetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMasterLawsuit + "/MasProductMappinggetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasterProductMappingResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductResponse> apiRequestMasProductGroupinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductGroupinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasterProductResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductResponse> apiRequestMasProductCategoryinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductCategoryinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasterProductResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductResponse> apiRequestMasProductTypeinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductTypeinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasterProductResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductResponse> apiRequestMasProductBrandinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductBrandinsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasterProductResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterProductResponse> apiRequestMasProductMappinginsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductMappinginsAll",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasterProductResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsArrestResponseGetOffice> apiRequestMasOfficegetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMasterLawsuit + "/MasOfficegetByCon",
        // serv.Server().IPAddressMaster + "/MasOfficegetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsArrestResponseGetOffice.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasterDivisionRateResponse> apiRequestMasDivisionRategetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasDivisionRategetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasterDivisionRateResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasProductSizeResponse> apiRequestMasProductSizegetByKeyword(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductSizegetByKeyword",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        try {
          return ItemsMasProductSizeResponse.fromJson(json.decode(response.body));
        } catch (_) {
          print('parse json error');
        }
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasProductUnitResponse> apiRequestMasProductUnitgetByKeyword(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasProductUnitgetByKeyword",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasProductUnitResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasNationalityResponse> apiRequestMasNationalitygetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasNationalitygetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasNationalityResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasRaceResponse> apiRequestMasRacegetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasRacegetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasRaceResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<ItemsMasWarehouseResponse> apiRequestMasWarehousegetByKeyword(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddressMaster + "/MasWarehousegetByKeyword",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return ItemsMasWarehouseResponse.fromJson(json.decode(response.body));
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  //new product
  Future<List<ItemsListProductGROUPCategory>> apiRequestMasProductGROUPCategoryForLiquorgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/MasProductGROUPCategoryForLiquorgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        return responseJson.map((m) => new ItemsListProductGROUPCategory.fromJson(m)).toList();
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<List<ItemsListProductGroupCategory>> apiRequestMasProductCategoryGroupgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/MasProductCategoryGroupgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        return responseJson.map((m) => new ItemsListProductGroupCategory.fromJson(m)).toList();
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<List<ItemsListProductCategoryRDB>> apiRequestMasProductCategoryRDBgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    try {
      final response = await http.post(
        serv.Server().IPAddress + "/MasProductCategoryRDBgetByCon",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        return responseJson.map((m) => new ItemsListProductCategoryRDB.fromJson(m)).toList();
      } else {
        print('Something went wrong. \nResponse Code : ${response.statusCode}');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
}
