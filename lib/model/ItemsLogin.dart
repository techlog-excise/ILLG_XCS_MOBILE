import 'package:prototype_app_pang/model/ItemsMessageLogin.dart';

class ItemsLogin {
  String userThaiId;
  String userThaiName;
  String userThaiSurname;
  String userEngName;
  String userEngSurname;
  String title;
  String userId;
  String email;
  String cnName;
  String officeId;
  String accessAttr;
  //ItemsMessageLogin message;
  ItemsLogin(this.userThaiId,
      this.userThaiName,
      this.userThaiSurname,
      this.userEngName,
      this.userEngSurname,
      this.title,
      this.userId,
      this.email,
      this.cnName,
      this.officeId,
      this.accessAttr,);
 /* factory ItemsLogin.fromJson(Map<String, dynamic> json) {
    return ItemsLogin(
      userThaiId: json['Body']['ResponseObj']['userThaiId'],
      userThaiName: json['Body']['ResponseObj']['userThaiName'],
      userThaiSurname: json['Body']['ResponseObj']['userThaiSurname'],
      userEngName: json['Body']['ResponseObj']['userEngName'],
      userEngSurname: json['Body']['ResponseObj']['userEngSurname'],
      title: json['Body']['ResponseObj']['title'],
      userId: json['Body']['ResponseObj']['userId'],
      email: json['Body']['ResponseObj']['email'],
      cnName: json['Body']['ResponseObj']['cnName'],
      officeId: json['Body']['ResponseObj']['officeId'],
      accessAttr: json['Body']['ResponseObj']['accessAttr'],
      //message:  json['message'].map((m) => ItemsMessageLogin.fromJson(m)),
    );
  }*/
}