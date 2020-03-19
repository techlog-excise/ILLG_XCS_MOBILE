import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_staff.dart';

class ItemsArrestResponseGetStaff {
  final List<ItemsListArrestStaff> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsArrestResponseGetStaff({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsArrestResponseGetStaff.fromJson(Map<String, dynamic> json) {
    //print(json['RESPONSE_DATA'].toString());
    return ItemsArrestResponseGetStaff(
      RESPONSE_DATA: List<ItemsListArrestStaff>.from(json['RESPONSE_DATA'].map((m) => ItemsListArrestStaff.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}