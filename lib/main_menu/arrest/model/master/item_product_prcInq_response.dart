import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_list_prcInq.dart';

class ItemsPrcInqResponse {
  final String ResponseCode;
  final String ResponseMessage;
  ItemsProductList ResponseData;

  ItemsPrcInqResponse({
    this.ResponseCode,
    this.ResponseMessage,
    this.ResponseData,
  });
  factory ItemsPrcInqResponse.fromJson(Map<String, dynamic> js) {
    return ItemsPrcInqResponse(
      ResponseCode: js['ResponseCode'],
      ResponseMessage: js['ResponseMessage'],
      ResponseData: js['ResponseMessage'].toString().trim().endsWith("ไม่พบข้อมูลตามเงื่อนไขที่ระบุ") ? null : ItemsProductList.fromJson(js['ResponseData']),
    );
  }
}

class ItemsProductList {
  List<ItemsListPrcInq> ProductList;

  ItemsProductList({
    this.ProductList,
  });
  factory ItemsProductList.fromJson(Map<String, dynamic> js) {
    return ItemsProductList(
      ProductList: List<ItemsListPrcInq>.from(js['ProductList'].map((m) => ItemsListPrcInq.fromJson(m))),
    );
  }
}
