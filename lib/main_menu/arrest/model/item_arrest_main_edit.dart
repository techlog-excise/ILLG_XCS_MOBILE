import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment_edit.dart';

class ItemsListArrestMainEdit {
  List<ItemsArrestIndictmentEdit> ArrestIndictment;
  List<ItemsArrestLawbreaker> ArrestLawbreaker;

  ItemsListArrestMainEdit({
    this.ArrestIndictment,
    this.ArrestLawbreaker,
  });

  factory ItemsListArrestMainEdit.fromJson(Map<String, dynamic> json) {
    return ItemsListArrestMainEdit(
      ArrestIndictment: List<ItemsArrestIndictmentEdit>.from(json['ArrestIndictment'].map((m) => ItemsArrestIndictmentEdit.fromJson(m))),
      ArrestLawbreaker: List<ItemsArrestLawbreaker>.from(json['ArrestLawbreaker'].map((m) => ItemsArrestLawbreaker.fromJson(m))),
    );
  }
}

class ItemsArrestLawbreaker {
  int PERSON_ID;

  ItemsArrestLawbreaker({
    this.PERSON_ID,
  });

  factory ItemsArrestLawbreaker.fromJson(Map<String, dynamic> json) {
    return ItemsArrestLawbreaker(
      PERSON_ID: json['PERSON_ID'],
    );
  }
}
