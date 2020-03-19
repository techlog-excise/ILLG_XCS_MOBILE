
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_locale.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_notice.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_staff.dart';
import 'package:prototype_app_pang/zan/model/person_net_address.dart';
import 'package:prototype_app_pang/zan/model/person_net_compare_infor.dart';
import 'package:prototype_app_pang/zan/model/person_net_foreigner_infor.dart';
import 'package:prototype_app_pang/zan/model/person_net_infor.dart';
import 'package:prototype_app_pang/zan/model/person_net_lawbreaker_detail.dart';
import 'package:prototype_app_pang/zan/model/person_net_relationship.dart';

class ItemsListPersonNetMain {
  ItemsListPersonNetInfor PERSON_INFO;
  final List<ItemsListPersonNetRelationship> PERSON_RELATIONSHIPS;
  final List<ItemsListPersonNetAddress> PERSON_ADDRESSES;
  final ItemsListPersonNetForeignerInfor FOREIGNER_INFO;
  final ItemsListPersonNetCompanyInfor COMPANY_INFO;
  List<ItemsListPersonNetLawbreakerDetail> ARREST_LAWBREAKER_DETAILS;

  ItemsListPersonNetMain({
    this.PERSON_INFO,
    this.PERSON_RELATIONSHIPS,
    this.PERSON_ADDRESSES,
    this.FOREIGNER_INFO,
    this.COMPANY_INFO,
    this.ARREST_LAWBREAKER_DETAILS,
  });

  factory ItemsListPersonNetMain.fromJson(Map<String, dynamic> js) {
    return ItemsListPersonNetMain(
      PERSON_INFO:  ItemsListPersonNetInfor.fromJson(js['PERSON_INFO']),
      PERSON_RELATIONSHIPS: List<ItemsListPersonNetRelationship>.from(js['PERSON_RELATIONSHIPS'].map((m) => ItemsListPersonNetRelationship.fromJson(m))),
      PERSON_ADDRESSES: List<ItemsListPersonNetAddress>.from(js['PERSON_ADDRESSES'].map((m) => ItemsListPersonNetAddress.fromJson(m))),
      FOREIGNER_INFO: ItemsListPersonNetForeignerInfor.fromJson(js['FOREIGNER_INFO']),
      COMPANY_INFO: ItemsListPersonNetCompanyInfor.fromJson(js['COMPANY_INFO']),
      ARREST_LAWBREAKER_DETAILS: List<ItemsListPersonNetLawbreakerDetail>.from(js['ARREST_LAWBREAKER_DETAILS'].map((m) => ItemsListPersonNetLawbreakerDetail.fromJson(m))),
    );
  }
}