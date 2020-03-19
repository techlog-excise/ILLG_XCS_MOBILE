
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';

class ItemsTransfer {
  String TransferNumber;
  String TransferDate;
  String TransferTime;
  String TransferPerson;
  String TransferDepartment;
  List<ItemsDestroyEvidence> Evidences;

  ItemsTransfer(
      this.TransferNumber,
      this.TransferDate,
      this.TransferTime,
      this.TransferPerson,
      this.TransferDepartment,
      this.Evidences,
      );
}