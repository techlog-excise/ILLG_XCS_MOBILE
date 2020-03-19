import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';

class ItemsExport {
  String ExportNumber;
  String ExportDate;
  String ExportTime;
  String ExportPerson;
  String ExportDepartment;
  List<ItemsDestroyEvidence> Evidences;

  ItemsExport(
      this.ExportNumber,
      this.ExportDate,
      this.ExportTime,
      this.ExportPerson,
      this.ExportDepartment,
      this.Evidences,
      );
}