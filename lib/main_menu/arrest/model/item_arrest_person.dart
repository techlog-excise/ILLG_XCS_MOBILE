
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_address.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_photo.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_relationship.dart';

class ItemsListArrestPerson {
  int LAWBREAKER_ID;
  int ARREST_ID;
  int PERSON_ID;

  int NATIONALITY_ID;
  int RACE_ID;

  int PERSON_TYPE;
  int ENTITY_TYPE;
  String ID_CARD;
  String PASSPORT_NO;
  String COMPANY_NAME;
  String EXCISE_REGISTRATION_NO;
  String COMPANY_REGISTRATION_NO;
  int TITLE_ID;
  String TITLE_NAME_TH;
  String TITLE_NAME_EN;
  String TITLE_SHORT_NAME_TH;
  String TITLE_SHORT_NAME_EN;
  String FIRST_NAME;
  String MIDDLE_NAME;
  String LAST_NAME;
  String OTHER_NAME;
  String CAREER;
  int MISTREAT_NO;
  int AGE;
  List<ItemsListArrestAddressPerson> MAS_PERSON_ADDRESS;
  List<ItemsListArrestPersonRelationShip> MAS_PERSON_RELATIONSHIP;
  List<ItemsListArrestPhotoPerson> MAS_PERSON_PHOTO;
  bool IsCheck;
  bool IsCheckOffence;
  bool IsCreate;

  ItemsListArrestPerson({
    this.LAWBREAKER_ID,
    this.ARREST_ID,
    this.PERSON_ID,

    this.NATIONALITY_ID,
    this.RACE_ID,

    this.PERSON_TYPE,
    this.ENTITY_TYPE,
    this.ID_CARD,
    this.PASSPORT_NO,
    this.COMPANY_NAME,
    this.EXCISE_REGISTRATION_NO,
    this.COMPANY_REGISTRATION_NO,
    this.TITLE_ID,
    this.TITLE_NAME_TH,
    this.TITLE_NAME_EN,
    this.TITLE_SHORT_NAME_TH,
    this.TITLE_SHORT_NAME_EN,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
    this.CAREER,
    this.MISTREAT_NO,
    this.AGE,
    this.MAS_PERSON_ADDRESS,
    this.MAS_PERSON_RELATIONSHIP,
    this.MAS_PERSON_PHOTO,
    this.IsCheck,
    this.IsCheckOffence,
    this.IsCreate,});

  factory ItemsListArrestPerson.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestPerson(
      LAWBREAKER_ID: js['LAWBREAKER_ID'],
      ARREST_ID: js['ARREST_ID'],
      PERSON_ID: js['PERSON_ID'],

      NATIONALITY_ID: js['NATIONALITY_ID'],
      RACE_ID: js['RACE_ID'],

      PERSON_TYPE: js['PERSON_TYPE'],
      ENTITY_TYPE: js['ENTITY_TYPE'],
      ID_CARD: js['ID_CARD'],
      PASSPORT_NO: js['PASSPORT_NO'],

      COMPANY_NAME: js['COMPANY_NAME'],
      EXCISE_REGISTRATION_NO: js['EXCISE_REGISTRATION_NO'],

      COMPANY_REGISTRATION_NO: js['COMPANY_REGISTRATION_NO'],
      TITLE_ID: js['TITLE_ID'],
      TITLE_NAME_TH: js['PERSON_TYPE']==0
          ?(js['TITLE_NAME_TH'] == null ? "" : js['TITLE_NAME_TH'])
          :(js['TITLE_NAME_EN'] == null ? "" : js['TITLE_NAME_EN']),
      TITLE_NAME_EN: js['TITLE_NAME_EN'],
      TITLE_SHORT_NAME_TH: js['PERSON_TYPE']==0
          ?(js['TITLE_SHORT_NAME_TH'] == null ? "" : js['TITLE_SHORT_NAME_TH'])
          :(js['TITLE_SHORT_NAME_EN'] == null ? "" : js['TITLE_SHORT_NAME_EN']),
      TITLE_SHORT_NAME_EN: js['TITLE_SHORT_NAME_EN'],
      FIRST_NAME: js['FIRST_NAME'] == null ? "" : js['FIRST_NAME'],
      MIDDLE_NAME: js['MIDDLE_NAME'],
      LAST_NAME: js['LAST_NAME'] == null ? "" : js['LAST_NAME'],
      OTHER_NAME: js['OTHER_NAME'],
      CAREER: js['CAREER'],
      MISTREAT_NO: js['MISTREAT_NO'],
      AGE: js['AGE'],
      MAS_PERSON_ADDRESS: List<ItemsListArrestAddressPerson>.from(
          js['MAS_PERSON_ADDRESS'].map((m) =>
              ItemsListArrestAddressPerson.fromJson(m))),
      MAS_PERSON_RELATIONSHIP: List<ItemsListArrestPersonRelationShip>.from(
          js['MAS_PERSON_RELATIONSHIP'].map((m) =>
              ItemsListArrestPersonRelationShip.fromJson(m))),
      MAS_PERSON_PHOTO: List<ItemsListArrestPhotoPerson>.from(
          js['MAS_PERSON_PHOTO'].map((m) =>
              ItemsListArrestPhotoPerson.fromJson(m))),
      IsCheck: false,
      IsCheckOffence: false,
      IsCreate: false,
    );
  }
}