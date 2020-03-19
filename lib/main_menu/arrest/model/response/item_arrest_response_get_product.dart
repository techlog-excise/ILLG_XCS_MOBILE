import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';

class ItemsArrestResponseProductBrand {
  final List<ItemsListArrestPerson> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsArrestResponseProductBrand({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsArrestResponseProductBrand.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseProductBrand(
      RESPONSE_DATA: List<ItemsListArrestPerson>.from(json['RESPONSE_DATA'].map((m) => ItemsListArrestPerson.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}