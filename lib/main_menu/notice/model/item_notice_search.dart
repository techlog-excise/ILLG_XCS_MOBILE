import 'package:prototype_app_pang/main_menu/notice/model/item_notice_staff.dart';

class ItemsNoticeSearch {
  final int NOTICE_ID;
  final String NOTICE_CODE;
  final String NOTICE_DATE;
  final int IS_ARREST;
  List<ItemsNoticeStaff> NoticeStaff;
  bool IsCheck;

  ItemsNoticeSearch({
    this.NOTICE_ID,
    this.NOTICE_CODE,
    this.NOTICE_DATE,
    this.IS_ARREST,
    this.NoticeStaff,
    this.IsCheck,
  });

  factory ItemsNoticeSearch.fromJson(Map<String, dynamic> json) {
    return ItemsNoticeSearch(
      NOTICE_ID: json['NOTICE_ID'],
      NOTICE_CODE: json['NOTICE_CODE'],
      NOTICE_DATE: json['NOTICE_DATE'],
      IS_ARREST: json['IS_ARREST'],
      NoticeStaff: List<ItemsNoticeStaff>.from(json['NoticeStaff'].map((m) => ItemsNoticeStaff.fromJson(m))),
      IsCheck: false,
    );
  }
}
