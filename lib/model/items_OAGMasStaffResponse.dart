import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';

class ItemsOAGMasStaffResponse {
  bool SUCCESS;
  List<ItemsOAGMasStaff> RESPONSE_DATA;

  ItemsOAGMasStaffResponse({
    this.SUCCESS,
    this.RESPONSE_DATA,
  });

  factory ItemsOAGMasStaffResponse.fromJson(Map<String, dynamic> json) {
    return ItemsOAGMasStaffResponse(
      SUCCESS: json['SUCCESS'],
      RESPONSE_DATA: List<ItemsOAGMasStaff>.from(json['RESPONSE_DATA'].map((m) => ItemsOAGMasStaff.fromJson(m))),
    );
  }
}
