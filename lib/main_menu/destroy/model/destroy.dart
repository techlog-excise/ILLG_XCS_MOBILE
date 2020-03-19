import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';

class ItemsDestroy {
  String DestroyNumber;
  String DestroyDate;
  String DestroyTime;
  String DestroyPerson;
  String DestroyDepartment;
  List<ItemsDestroyEvidence> Evidences;

  ItemsDestroy(
      this.DestroyNumber,
      this.DestroyDate,
      this.DestroyTime,
      this.DestroyPerson,
      this.DestroyDepartment,
      this.Evidences,
      );
}