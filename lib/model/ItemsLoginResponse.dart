import 'ItemsPersonInfomation.dart';

class ItemsLoginResp {
  String IsSuccess;
  String Msg;
  ItemsPersonInformation response;

  ItemsLoginResp({
    this.IsSuccess,
    this.Msg,
    this.response,
  });

  factory ItemsLoginResp.fromJson(Map<String, dynamic> json) {
    return ItemsLoginResp(
        IsSuccess: json['IsSuccess'],
        Msg: json['Msg'],
      response: ItemsPersonInformation.fromJson(json['response']),
    );
  }
}