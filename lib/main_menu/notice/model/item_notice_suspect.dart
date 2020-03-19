import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_address.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_photo.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_relationship.dart';

class ItemsNoticeSuspect {
  final int SUSPECT_ID;
  final int NOTICE_ID;
  final int PERSON_ID;

  final int NATIONALITY_ID;
  final int RACE_ID;

  final int TITLE_ID;
  final int PERSON_TYPE;
  final int ENTITY_TYPE;
  final String TITLE_NAME_TH;
  final String TITLE_NAME_EN;
  final String TITLE_SHORT_NAME_TH;
  final String TITLE_SHORT_NAME_EN;
  final String FIRST_NAME;
  final String MIDDLE_NAME;
  final String LAST_NAME;
  final String OTHER_NAME;
  final String COMPANY_REGISTRATION_NO;
  final String EXCISE_REGISTRATION_NO;
  final String ID_CARD;
  final int AGE;
  final String PASSPORT_NO;
  final String CAREER;
  final String PERSON_DESC;
  final String EMAIL;
  final String TEL_NO;
  final int MISTREAT_NO;
  final int IS_ACTIVE;
  final String COMPANY_NAME;
  List<ItemsListArrestAddressPerson> MAS_PERSON_ADDRESS;
  List<ItemsListArrestPersonRelationShip> MAS_PERSON_RELATIONSHIP;
  List<ItemsListArrestPhotoPerson> MAS_PERSON_PHOTO;
  bool IsCheck;
  bool IsCheckOffence;
  bool IsCreate;

  ItemsNoticeSuspect({
    this.SUSPECT_ID,
    this.NOTICE_ID,
    this.PERSON_ID,
    this.TITLE_ID,

    this.NATIONALITY_ID,
    this.RACE_ID,

    this.PERSON_TYPE,
    this.ENTITY_TYPE,
    this.TITLE_NAME_TH,
    this.TITLE_NAME_EN,
    this.TITLE_SHORT_NAME_TH,
    this.TITLE_SHORT_NAME_EN,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
    this.COMPANY_REGISTRATION_NO,
    this.EXCISE_REGISTRATION_NO,
    this.ID_CARD,
    this.AGE,
    this.PASSPORT_NO,
    this.CAREER,
    this.PERSON_DESC,
    this.EMAIL,
    this.TEL_NO,
    this.MISTREAT_NO,
    this.IS_ACTIVE,
    this.COMPANY_NAME,
    this.MAS_PERSON_ADDRESS,
    this.MAS_PERSON_RELATIONSHIP,
    this.MAS_PERSON_PHOTO,
    this.IsCreate,
    this.IsCheck,
    this.IsCheckOffence,
  });

  factory ItemsNoticeSuspect.fromJson(Map<String, dynamic> js) {
    return ItemsNoticeSuspect(
      SUSPECT_ID: js['SUSPECT_ID'],
      NOTICE_ID: js['NOTICE_ID'],
      PERSON_ID: js['PERSON_ID'],
      TITLE_ID: js['TITLE_ID'],

      NATIONALITY_ID: js['NATIONALITY_ID'],
      RACE_ID: js['RACE_ID'],

      PERSON_TYPE: js['PERSON_TYPE'],
      ENTITY_TYPE: js['ENTITY_TYPE'],
      TITLE_NAME_TH: js['TITLE_NAME_TH'],
      TITLE_NAME_EN: js['TITLE_NAME_EN'],
      TITLE_SHORT_NAME_TH: js['TITLE_SHORT_NAME_TH'],
      TITLE_SHORT_NAME_EN: js['TITLE_SHORT_NAME_EN'],
      FIRST_NAME: js['FIRST_NAME'],
      MIDDLE_NAME: js['MIDDLE_NAME:'],
      LAST_NAME: js['LAST_NAME'],
      OTHER_NAME: js['OTHER_NAME'],
      COMPANY_REGISTRATION_NO: js['COMPANY_REGISTRATION_NO'],
      EXCISE_REGISTRATION_NO: js['EXCISE_REGISTRATION_NO'],
      ID_CARD: js['ID_CARD'],
      AGE: js['AGE'],
      PASSPORT_NO: js['PASSPORT_NO'],
      CAREER: js['CAREER'],
      PERSON_DESC: js['PERSON_DESC'],
      EMAIL: js['EMAIL'],
      TEL_NO: js['TEL_NO'],
      MISTREAT_NO: js['MISTREAT_NO'],
      IS_ACTIVE: js['IS_ACTIVE'],
      COMPANY_NAME: js['COMPANY_NAME'],
      MAS_PERSON_ADDRESS: js['MAS_PERSON_ADDRESS']==null
          ?[]
          :List<ItemsListArrestAddressPerson>.from(js['MAS_PERSON_ADDRESS'].map((m) => ItemsListArrestAddressPerson.fromJson(m))),
      MAS_PERSON_RELATIONSHIP: js['MAS_PERSON_RELATIONSHIP']==null
          ?[]
          :List<ItemsListArrestPersonRelationShip>.from(js['MAS_PERSON_RELATIONSHIP'].map((m) =>
              ItemsListArrestPersonRelationShip.fromJson(m))),
      MAS_PERSON_PHOTO: js['MAS_PERSON_PHOTO']==null
          ?[]
          :List<ItemsListArrestPhotoPerson>.from(js['MAS_PERSON_PHOTO'].map((m) =>
              ItemsListArrestPhotoPerson.fromJson(m))),
      IsCheck: false,
      IsCheckOffence: false,
      IsCreate: false,
    );
  }
}