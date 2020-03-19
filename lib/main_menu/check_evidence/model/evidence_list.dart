import 'evidence_staff.dart';

class ItemsEvidenceList {
  /*final int EVIDENCE_IN_ID;
  final int PROVE_ID;
  final String EVIDENCE_IN_CODE;
  final String EVIDENCE_IN_DATE;
  final String RETURN_DATE;
  final int IS_RECEIVE;
  final String DELIVERY_NO;
  final String DELIVERY_DATE;
  final int EVIDENCE_IN_TYPE;
  final String REMARK;
  final int IS_ACTIVE;
  final int IS_EDIT;
  final List<ItemsEvidenceStaff> EvidenceInStaff;*/

  int EVIDENCE_IN_ID;
  int PROVE_ID;

  String PROVE_NO;
  String PROVE_NO_YEAR;
  int PROVE_IS_OUTSIDE;

  String EVIDENCE_IN_CODE;
  String EVIDENCE_IN_DATE;
  String RETURN_DATE;
  int IS_RECEIVE;
  String DELIVERY_NO;
  String DELIVERY_DATE;
  int EVIDENCE_IN_TYPE;
  String REMARK;
  int IS_ACTIVE;
  int IS_EDIT;
  List<ItemsEvidenceStaff> EvidenceInStaff;

  ItemsEvidenceList({
    this.EVIDENCE_IN_ID,
    this.PROVE_ID,
    this.PROVE_NO,
    this.PROVE_NO_YEAR,
    this.PROVE_IS_OUTSIDE,
    this.EVIDENCE_IN_CODE,
    this.EVIDENCE_IN_DATE,
    this.RETURN_DATE,
    this.IS_RECEIVE,
    this.DELIVERY_NO,
    this.DELIVERY_DATE,
    this.EVIDENCE_IN_TYPE,
    this.REMARK,
    this.IS_ACTIVE,
    this.IS_EDIT,
    this.EvidenceInStaff,
  });

  factory ItemsEvidenceList.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceList(
      EVIDENCE_IN_ID: json['EVIDENCE_IN_ID'],
      PROVE_ID: json['PROVE_ID'],
      PROVE_NO: json['PROVE_NO'],
      PROVE_NO_YEAR: json['PROVE_NO_YEAR'],
      PROVE_IS_OUTSIDE: json['PROVE_IS_OUTSIDE'],
      EVIDENCE_IN_CODE: json['EVIDENCE_IN_CODE'],
      EVIDENCE_IN_DATE: json['EVIDENCE_IN_DATE'],
      RETURN_DATE: json['RETURN_DATE'],
      IS_RECEIVE: json['IS_RECEIVE'],
      DELIVERY_NO: json['DELIVERY_NO'],
      DELIVERY_DATE: json['DELIVERY_DATE'],
      EVIDENCE_IN_TYPE: json['EVIDENCE_IN_TYPE'],
      REMARK: json['REMARK'],
      IS_ACTIVE: json['IS_ACTIVE'],
      IS_EDIT: json['IS_EDIT'],
      EvidenceInStaff: List.from(json['EvidenceInStaff'].map((m) => ItemsEvidenceStaff.fromJson(m))),
    );
  }
}
