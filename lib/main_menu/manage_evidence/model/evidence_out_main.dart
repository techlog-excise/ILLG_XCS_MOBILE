import 'evidence_out_in_item.dart';
import 'evidence_out_item.dart';
import 'evidence_out_staff.dart';

class ItemsEvidenceOutMain {
  final int EVIDENCE_OUT_ID;
  final int EVIDENCE_IN_ID;
  final int WAREHOUSE_ID;
  final int OFFICE_CODE;
  final String EVIDENCE_OUT_CODE;
  final String EVIDENCE_OUT_DATE;
  final int EVIDENCE_OUT_TYPE;
  final String EVIDENCE_OUT_NO;
  final String EVIDENCE_OUT_NO_DATE;
  final String BOOK_NO;
  final String RECEIPT_NO;
  final String PAY_DATE;
  final String APPROVE_DATE;
  final String RETURN_DATE;
  final String REMARK;
  final String APPROVE_NO;
  final int IS_ACTIVE;
  final List<ItemsEvidenceOutItem> EvidenceOutItem;
  final List<ItemsEvidenceOutStaff> EvidenceOutStaff;
  final ItemsEvidenceOutInItem EvidenceOutIn;

  ItemsEvidenceOutMain({
    this.EVIDENCE_OUT_ID,
    this.EVIDENCE_IN_ID,
    this.WAREHOUSE_ID,
    this.OFFICE_CODE,
    this.EVIDENCE_OUT_CODE,
    this.EVIDENCE_OUT_DATE,
    this.EVIDENCE_OUT_TYPE,
    this.EVIDENCE_OUT_NO,
    this.EVIDENCE_OUT_NO_DATE,
    this.BOOK_NO,
    this.RECEIPT_NO,
    this.PAY_DATE,
    this.APPROVE_DATE,
    this.RETURN_DATE,
    this.REMARK,
    this.APPROVE_NO,
    this.IS_ACTIVE,
    this.EvidenceOutItem,
    this.EvidenceOutStaff,
    this.EvidenceOutIn,
  });

  factory ItemsEvidenceOutMain.fromJson(Map<String, dynamic> js) {
    return ItemsEvidenceOutMain(
      EVIDENCE_OUT_ID: js['EVIDENCE_OUT_ID'],
      EVIDENCE_IN_ID: js['EVIDENCE_IN_ID'],
      WAREHOUSE_ID: js['WAREHOUSE_ID'],
      OFFICE_CODE: js['OFFICE_CODE'],
      EVIDENCE_OUT_CODE: js['EVIDENCE_OUT_CODE'],
      EVIDENCE_OUT_DATE: js['EVIDENCE_OUT_DATE'],
      EVIDENCE_OUT_TYPE: js['EVIDENCE_OUT_TYPE'],
      EVIDENCE_OUT_NO: js['EVIDENCE_OUT_NO'],
      EVIDENCE_OUT_NO_DATE: js['EVIDENCE_OUT_NO_DATE'],
      BOOK_NO: js['BOOK_NO'],
      RECEIPT_NO: js['RECEIPT_NO'],
      PAY_DATE: js['PAY_DATE'],
      APPROVE_DATE: js['APPROVE_DATE'],
      RETURN_DATE: js['RETURN_DATE'],
      REMARK: js['REMARK'],
      APPROVE_NO: js['APPROVE_NO'],
      IS_ACTIVE: js['IS_ACTIVE'],
      EvidenceOutItem: List<ItemsEvidenceOutItem>.from(js['EvidenceOutItem'].map((m) => ItemsEvidenceOutItem.fromJson(m))),
      EvidenceOutStaff: List<ItemsEvidenceOutStaff>.from(js['EvidenceOutStaff'].map((m) => ItemsEvidenceOutStaff.fromJson(m))),
      EvidenceOutIn: ItemsEvidenceOutInItem.fromJson(js['EvidenceOutIn']),

      /*EvidenceOutInStaff: List<ItemsEvidenceStaff>.from(json['EvidenceOutInStaff'].map((m) => ItemsEvidenceStaff.fromJson(m))),
      EvidenceOutProve: List<ItemsEvidenceOutProve>.from(json['EvidenceOutProve'].map((m) => ItemsEvidenceOutProve.fromJson(m))),*/
    );
  }
}