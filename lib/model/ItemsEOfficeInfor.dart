import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';

class ItemsEOfficeInfor {
  String Status;
  String ErrorCode;
  String ErrorMessage;
  ItemsPersonInformation PersonInformation;
  ItemsEOfficeInfor({
    this.Status,
    this.ErrorCode,
    this.ErrorMessage,
    this.PersonInformation,
  });
  factory ItemsEOfficeInfor.fromJson(Map<String, dynamic> json) {
    return ItemsEOfficeInfor(
      Status: json['Status'],
      ErrorCode: json['ErrorCode'],
      ErrorMessage: json['ErrorMessage'],
      PersonInformation: ItemsPersonInformation.fromJson(json['PersonInformation']),
    );
  }
}