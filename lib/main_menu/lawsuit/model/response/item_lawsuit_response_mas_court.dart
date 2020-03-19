
import '../lawsuit_mas_court.dart';

class ItemsArrestResponseCourt {
  final List<ItemsLawsuitMasCourt> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsArrestResponseCourt({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsArrestResponseCourt.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseCourt(
      RESPONSE_DATA: List<ItemsLawsuitMasCourt>.from(json['RESPONSE_DATA'].map((m) => ItemsLawsuitMasCourt.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}