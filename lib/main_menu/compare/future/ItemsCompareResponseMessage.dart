import 'package:prototype_app_pang/main_menu/compare/model/ItemCompareSignature.dart';

class ItemsCompareResponseMessage {
  final String ResponseCode;
  final String ResponseMessage;
  ItemsCompareImgSignature ImgSignatureItems;

  ItemsCompareResponseMessage({this.ResponseCode, this.ResponseMessage, this.ImgSignatureItems});

  factory ItemsCompareResponseMessage.fromJson(Map<String, dynamic> json) {
    return ItemsCompareResponseMessage(ResponseCode: json['ResponseCode'], ResponseMessage: json['ResponseMessage'], ImgSignatureItems: json['ResponseData'] != null ? new ItemsCompareImgSignature.fromJson(json['ResponseData']) : null);
  }
}
