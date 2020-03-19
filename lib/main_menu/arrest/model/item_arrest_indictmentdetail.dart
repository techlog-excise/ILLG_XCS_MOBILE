import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment_product_edit.dart';

class ItemsArrestIndictmentDetailEdit {
  int INDICTMENT_DETAIL_ID;
  List<ItemsListArrestIndictmentProductEdit> ArrestIndictmentProduct;

  ItemsArrestIndictmentDetailEdit({
    this.INDICTMENT_DETAIL_ID,
    this.ArrestIndictmentProduct,
  });

  factory ItemsArrestIndictmentDetailEdit.fromJson(Map<String, dynamic> json) {
    return ItemsArrestIndictmentDetailEdit(
      INDICTMENT_DETAIL_ID: json['INDICTMENT_DETAIL_ID'],
      ArrestIndictmentProduct: List<ItemsListArrestIndictmentProductEdit>.from(json['ArrestIndictmentProduct'].map((m) => ItemsListArrestIndictmentProductEdit.fromJson(m))),
    );
  }
}
