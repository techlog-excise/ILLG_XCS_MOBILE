import 'item_notice_informer.dart';
import 'item_notice_locale.dart';
import 'item_notice_product.dart';
import 'item_notice_staff.dart';
import 'item_notice_suspect.dart';

class ItemsNoticeMain {
  final int NOTICE_ID;
  final int ARREST_ID;
  final int OFFICE_ID;
  final String NOTICE_CODE;
  final String OFFICE_CODE;
  final String OFFICE_NAME;
  final String NOTICE_DATE;
  final int NOTICE_DUE;
  final String NOTICE_DUE_DATE;
  final int COMMUNICATION_CHANNEL;
  final int IS_ARREST;
  final int IS_AUTHORITY;
  final int IS_ACTIVE;
  final int IS_MATCH;
  String CREATE_DATE;
  int CREATE_USER_ACCOUNT_ID;
  String UPDATE_DATE;
  int UPDATE_USER_ACCOUNT_ID;
  List<ItemsNoticeInformer> NoticeInformer;
  List<ItemsNoticeStaff> NoticeStaff;
  List<ItemsNoticeLocale> NoticeLocale;
  List NoticeProduct;
  List NoticeSuspect;

  ItemsNoticeMain({
    this.NOTICE_ID,
    this.ARREST_ID,
    this.OFFICE_ID,
    this.NOTICE_CODE,
    this.OFFICE_CODE,
    this.OFFICE_NAME,
    this.NOTICE_DATE,
    this.NOTICE_DUE,
    this.NOTICE_DUE_DATE,
    this.COMMUNICATION_CHANNEL,
    this.IS_ARREST,
    this.IS_AUTHORITY,
    this.IS_ACTIVE,
    this.IS_MATCH,
    this.CREATE_DATE,
    this.CREATE_USER_ACCOUNT_ID,
    this.UPDATE_DATE,
    this.UPDATE_USER_ACCOUNT_ID,
    this.NoticeInformer,
    this.NoticeStaff,
    this.NoticeLocale,
    this.NoticeProduct,
    this.NoticeSuspect
  });

  factory ItemsNoticeMain.fromJson(Map<String, dynamic> json) {
    return ItemsNoticeMain(
      NOTICE_ID: json['NOTICE_ID'],
      ARREST_ID: json['ARREST_ID'],
      OFFICE_ID: json['OFFICE_ID'],
      NOTICE_CODE: json['NOTICE_CODE'],
      OFFICE_CODE: json['OFFICE_CODE'],
      OFFICE_NAME: json['OFFICE_NAME'],
      NOTICE_DATE: json['NOTICE_DATE'],
      NOTICE_DUE: json['NOTICE_DUE'],
      NOTICE_DUE_DATE: json['NOTICE_DUE_DATE'],
      COMMUNICATION_CHANNEL: json['COMMUNICATION_CHANNEL'],
      IS_ARREST: json['IS_ARREST'],
      IS_AUTHORITY: json['IS_AUTHORITY'],
      IS_ACTIVE: json['IS_ACTIVE'],
      IS_MATCH: json['IS_MATCH'],
      CREATE_DATE: json['CREATE_DATE'],
      CREATE_USER_ACCOUNT_ID: json['CREATE_USER_ACCOUNT_ID'],
      UPDATE_DATE: json['UPDATE_DATE'],
      UPDATE_USER_ACCOUNT_ID: json['UPDATE_USER_ACCOUNT_ID'],
      NoticeInformer: List<ItemsNoticeInformer>.from(json['NoticeInformer'].map((m) => ItemsNoticeInformer.fromJson(m))),
      NoticeStaff: List<ItemsNoticeStaff>.from(json['NoticeStaff'].map((m) => ItemsNoticeStaff.fromJson(m))),
      NoticeLocale: List<ItemsNoticeLocale>.from(json['NoticeLocale'].map((m) => ItemsNoticeLocale.fromJson(m))),
      NoticeProduct: List.from(json['NoticeProduct'].map((m) => ItemsListNoticeProduct.fromJson(m))),
      NoticeSuspect: List.from(json['NoticeSuspect'].map((m) => ItemsNoticeSuspect.fromJson(m))),
    );
  }
}