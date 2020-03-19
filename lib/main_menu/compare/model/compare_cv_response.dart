import 'package:prototype_app_pang/main_menu/compare/model/ItemCompareCV.dart';

class CompareCVResponse {
  String MSG;
  String CODE;
  String STATUS;
  ItemsCompareCV ItemCV;

  CompareCVResponse({
    this.MSG,
    this.CODE,
    this.STATUS,
    this.ItemCV,
  });

  factory CompareCVResponse.fromJson(Map<String, dynamic> json) {
    return CompareCVResponse(
      MSG: json['msg'],
      CODE: json['code'],
      STATUS: json['status'],
      ItemCV: json['data'] != null ? new ItemsCompareCV.fromJson(json['data']) : null,
    );
  }
}
