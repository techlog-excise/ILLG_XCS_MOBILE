
import 'evidence_staff.dart';

class ItemsEvidenceStaffResponse {

  final String IsSuccess;
  final String Msg;
  final List EvidenceInStaff;

  ItemsEvidenceStaffResponse({
    this.IsSuccess,
    this.Msg,
    this.EvidenceInStaff
  });

  factory ItemsEvidenceStaffResponse.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceStaffResponse(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      EvidenceInStaff: List<ItemsEvidenceStaff>.from(json['EvidenceInStaff'].map((m) => ItemsEvidenceStaff.fromJson(m))),
    );
  }
}