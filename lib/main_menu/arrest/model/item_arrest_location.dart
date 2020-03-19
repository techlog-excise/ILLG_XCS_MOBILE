import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';

class ItemsListArrestLocation {
  ItemsListProvince PROVINCE;
  ItemsListDistict DISTICT;
  ItemsListSubDistict SUB_DISTICT;
  /*String PROVINCE;
  String DISTICT;
  String SUB_DISTICT;*/
  String ROAD;
  String LANE;
  String ADDRESS_NO;
  String GPS;
  String ADDRESS_LINE;
  bool IsPlace;
  String Other;

  ItemsListArrestLocation(this.PROVINCE, this.DISTICT, this.SUB_DISTICT, this.ROAD, this.LANE, this.ADDRESS_NO, this.GPS, this.ADDRESS_LINE, this.IsPlace, this.Other);
}
