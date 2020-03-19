import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictmentdetail.dart';

class ItemsArrestIndictmentEdit {
  int INDICTMENT_ID;
  int GUILTBASE_ID;
  List<ItemsArrestIndictmentDetailEdit> ArrestIndictmentDetail;

  ItemsArrestIndictmentEdit({
    this.INDICTMENT_ID,
    this.GUILTBASE_ID,
    this.ArrestIndictmentDetail,
  });

  factory ItemsArrestIndictmentEdit.fromJson(Map<String, dynamic> json) {
    return ItemsArrestIndictmentEdit(
      INDICTMENT_ID: json['INDICTMENT_ID'],
      GUILTBASE_ID: json['GUILTBASE_ID'],
      ArrestIndictmentDetail: json['ArrestIndictmentDetail'][0]['ArrestIndictmentProduct'] != null ? List<ItemsArrestIndictmentDetailEdit>.from(json['ArrestIndictmentDetail'].map((m) => ItemsArrestIndictmentDetailEdit.fromJson(m))) : [],
    );
  }
}
