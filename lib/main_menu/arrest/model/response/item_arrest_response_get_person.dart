import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';

class ItemsArrestResponseGetPerson {
  //final List<ItemsListArrestPerson> RESPONSE_DATA;
  final List<ItemsListArrestPerson> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsArrestResponseGetPerson({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsArrestResponseGetPerson.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseGetPerson(
      RESPONSE_DATA: List<ItemsListArrestPerson>.from(json['RESPONSE_DATA'].map((m) => ItemsListArrestPerson.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}