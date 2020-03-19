import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';

class ItemsStockBalanceDetail{
  String Number;
  String Date;
  int Counts;
  String CountUnit;
  int Volumn;
  String VolumnUnit;
  ItemsDestroyEvidence Evidences;
  int Status;
  ItemsStockBalanceDetail(
      this.Number,
      this.Date,
      this.Evidences,
      this.Counts,
      this.CountUnit,
      this.Volumn,
      this.VolumnUnit,
      this.Status,);
}