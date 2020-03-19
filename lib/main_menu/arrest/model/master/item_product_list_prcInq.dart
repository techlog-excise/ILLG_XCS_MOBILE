import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_info_prcInq.dart';

class ItemsListPrcInq {
  List<ItemsInfoPrcInq> ProductInfo;

  ItemsListPrcInq({
    this.ProductInfo,
  });
  factory ItemsListPrcInq.fromJson(Map<String, dynamic> js) {
    return ItemsListPrcInq(
      ProductInfo: List<ItemsInfoPrcInq>.from(js['ProductInfo'].map((m) => ItemsInfoPrcInq.fromJson(m))),
    );
  }
}
