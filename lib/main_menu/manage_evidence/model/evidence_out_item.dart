import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

class ItemsEvidenceOutItem {
  int EVIDENCE_OUT_ITEM_ID;
  int EVIDENCE_OUT_ID;
  int STOCK_ID;
  double BALANCE_QTY;
  double QTY;
  String QTY_UNIT;
  double PRODUCT_SIZE;
  String PRODUCT_SIZE_UNIT;
  double NET_VOLUMN;
  String NET_VOLUMN_UNIT;
  int IS_RETURN;
  int IS_ACTIVE;
  int IS_DOMESTIC;

  String PRODUCT_DESC;
  String EVIDENCE_IN_ITEM_CODE;
  int EVIDENCE_IN_ID;

  List<ItemsEvidenceStockBalance> EvidenceOutStockBalance;
  ItemsCheckEvidenceDetailController ItemsController;
  bool IsCkecked;

  ItemsEvidenceOutItem({this.EVIDENCE_OUT_ITEM_ID, this.EVIDENCE_OUT_ID, this.STOCK_ID, this.BALANCE_QTY, this.QTY, this.QTY_UNIT, this.PRODUCT_SIZE, this.PRODUCT_SIZE_UNIT, this.NET_VOLUMN, this.NET_VOLUMN_UNIT, this.IS_RETURN, this.IS_DOMESTIC, this.IS_ACTIVE, this.PRODUCT_DESC, this.EVIDENCE_IN_ID, this.EVIDENCE_IN_ITEM_CODE, this.EvidenceOutStockBalance, this.ItemsController, this.IsCkecked});

  factory ItemsEvidenceOutItem.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceOutItem(
        EVIDENCE_OUT_ITEM_ID: json['EVIDENCE_OUT_ITEM_ID'],
        EVIDENCE_OUT_ID: json['EVIDENCE_OUT_ID'],
        STOCK_ID: json['STOCK_ID'],
        BALANCE_QTY: json['BALANCE_QTY'],
        QTY: json['QTY'],
        QTY_UNIT: json['QTY_UNIT'],
        PRODUCT_SIZE: json['PRODUCT_SIZE'],
        PRODUCT_SIZE_UNIT: json['PRODUCT_SIZE_UNIT'],
        NET_VOLUMN: json['NET_VOLUMN'],
        NET_VOLUMN_UNIT: json['NET_VOLUMN_UNIT'],
        IS_RETURN: json['IS_RETURN'],
        IS_DOMESTIC: json['IS_DOMESTIC'],
        IS_ACTIVE: json['IS_ACTIVE'],
        ItemsController: new ItemsCheckEvidenceDetailController(new ExpandableController(), new FocusNode(), new FocusNode(), new FocusNode(), new FocusNode(), new FocusNode(), new FocusNode(), new FocusNode(), new FocusNode(), new FocusNode(), new FocusNode(), new FocusNode(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), null, null, null, null),
        EvidenceOutStockBalance: List<ItemsEvidenceStockBalance>.from(json['EvidenceOutStockBalance'].map((m) => ItemsEvidenceStockBalance.fromJson(m))),
        IsCkecked: false);
  }
}
