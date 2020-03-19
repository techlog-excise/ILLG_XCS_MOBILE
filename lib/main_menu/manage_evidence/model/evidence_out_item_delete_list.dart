import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

class EvidenceOutItemDeleteList {
  int EVIDENCE_OUT_ITEM_ID;
  int STOCK_ID;
  double BALANCE_QTY;

  EvidenceOutItemDeleteList({
    this.EVIDENCE_OUT_ITEM_ID,
    this.STOCK_ID,
    this.BALANCE_QTY,
  });
}