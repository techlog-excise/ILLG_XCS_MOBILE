
import 'package:prototype_app_pang/main_menu/stock/model/balance_detail.dart';

class ItemsStockBalanceType{
  String Name;
  String Number_Name;
  String Date;
  List<ItemsStockBalanceDetail> BalanceDetails;
  int Type;
  ItemsStockBalanceType(
      this.Name,
      this.Number_Name,
      this.Date,
      this.BalanceDetails,
      this.Type,);
}