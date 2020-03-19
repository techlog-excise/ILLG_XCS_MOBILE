import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_office.dart';

class ItemsArrestResponseGetOffice {
  final List<ItemsListOffice> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsArrestResponseGetOffice({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsArrestResponseGetOffice.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseGetOffice(
      RESPONSE_DATA: List<ItemsListOffice>.from(json['RESPONSE_DATA'].map((m) => ItemsListOffice.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}