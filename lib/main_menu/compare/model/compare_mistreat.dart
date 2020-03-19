import 'package:prototype_app_pang/main_menu/compare/model/compare_detail_fine.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_detail_payment.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_payment.dart';

class ItemsCompareMistreat {
  final int MISTREAT;

  ItemsCompareMistreat({
    this.MISTREAT,
  });

  factory ItemsCompareMistreat.fromJson(Map<String, dynamic> json) {
    return ItemsCompareMistreat(
      MISTREAT: json['MISTREAT'],
    );
  }
}