import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category_SRP.dart';

class ItemsListProductGROUPCategorySRPResponse {
  final String ResponseCode;
  final String ResponseMessage;
  List<ItemsListProductGROUPCategorySRP> ResponseData;

  ItemsListProductGROUPCategorySRPResponse({
    this.ResponseCode,
    this.ResponseMessage,
    this.ResponseData,
  });
  factory ItemsListProductGROUPCategorySRPResponse.fromJson(Map<String, dynamic> js) {
    return ItemsListProductGROUPCategorySRPResponse(
      ResponseCode: js['ResponseCode'],
      ResponseMessage: js['ResponseMessage'],
      ResponseData: js['ResponseMessage'].toString().trim().endsWith("ไม่พบข้อมูลตามเงื่อนไขที่ระบุ") ? [] : List<ItemsListProductGROUPCategorySRP>.from(js['ResponseData'].map((m) => ItemsListProductGROUPCategorySRP.fromJson(m))),
    );
  }
}
