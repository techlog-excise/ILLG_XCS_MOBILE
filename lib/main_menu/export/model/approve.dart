import 'package:prototype_app_pang/main_menu/export/model/donate.dart';
import 'package:prototype_app_pang/main_menu/export/model/government.dart';
class ItemsExportApprove {
  String ApproveNumber;
  String OfferDate;
  String OfferTime;
  String Person;
  String Department;
  String PersonConsider;
  String ConsiderDepartment;
  String ConsiderDate ;
  String ConsiderTime;
  String Stock ;
  String ExportComment;
  int ExportType;
  ItemsGovernment Governments;
  ItemsDonate Donates;


  ItemsExportApprove(
      this.ApproveNumber,
      this.OfferDate,
      this.OfferTime,
      this.Person,
      this.Department,
      this.PersonConsider,
      this.ConsiderDepartment,
      this.ConsiderDate,
      this.ConsiderTime,
      this.Stock,
      this.ExportComment,
      this.ExportType,
      this.Governments,
      this.Donates,);
}