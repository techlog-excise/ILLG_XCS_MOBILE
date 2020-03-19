
import 'lawsuit_indicment_detail.dart';

class ItemsLawsuitList {
  /*String LawsuitNumber;
  String LawsuitYear;
  String LawsuitDate;
  String LawsuitTime;
  String LawsuitPersonName;
  ItemsLawsuitCaseInformation Informations;
  String LawsuitPlace;
  String LawsuitTestimony;
  String LawsuitCompare;
  bool IsCompare;
  //กรณี
  //bool IsProof;

  ItemsLawsuitMainAcceptCase(
      this.LawsuitNumber,
      this.LawsuitYear,
      this.LawsuitDate,
      this.LawsuitTime,
      this.LawsuitPersonName,
      this.Informations,
      this.LawsuitPlace,
      this.LawsuitTestimony,
      this.LawsuitCompare,
      this.IsCompare,
      //this.IsProof,
      );*/
  int LAWSUIT_ID;
  int INDICTMENT_ID;
  String ARREST_CODE;
  String SECTION_NAME;
  String SUBSECTION_NAME;
  int LAWSUIT_NO;
  String LAWSUIT_NO_YEAR;
  int LAWSUIT_IS_OUTSIDE;

  String ACCUSER_TITLE_SHORT_NAME_TH;
  String ACCUSER_FIRST_NAME;
  String ACCUSER_LAST_NAME;
  String LAWSUIT_DATE;
  String LAWSUIT_OFFICE_NAME;
  String LAWSUIT_TITLE_SHORT_NAME_TH;
  String LAWSUIT_FIRST_NAME;
  String LAWSUIT_LAST_NAME;


  int INDICTMENT_IS_LAWSUIT_COMPLETE;
  List<ItemsLawsuitListIndicmentDetail> IndicmentDetail;

  ItemsLawsuitList({
    this.LAWSUIT_IS_OUTSIDE,
    this.LAWSUIT_ID,
    this.INDICTMENT_ID,
    this.ARREST_CODE,
    this.SECTION_NAME,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.LAWSUIT_DATE,

    this.ACCUSER_TITLE_SHORT_NAME_TH,
    this.ACCUSER_FIRST_NAME,
    this.ACCUSER_LAST_NAME,
    this.LAWSUIT_OFFICE_NAME,
    this.SUBSECTION_NAME,
    this.LAWSUIT_TITLE_SHORT_NAME_TH,
    this.LAWSUIT_FIRST_NAME,
    this.LAWSUIT_LAST_NAME,

    this.INDICTMENT_IS_LAWSUIT_COMPLETE,
    this.IndicmentDetail,
  });

  factory ItemsLawsuitList.fromJson(Map<String, dynamic> json) {
    return ItemsLawsuitList(
      LAWSUIT_IS_OUTSIDE: json['LAWSUIT_IS_OUTSIDE'],
      LAWSUIT_ID: json['LAWSUIT_ID'],
      INDICTMENT_ID: json['INDICTMENT_ID'],
      ARREST_CODE: json['ARREST_CODE'],
      SECTION_NAME: json['SECTION_NAME'],
      SUBSECTION_NAME: json['SUBSECTION_NAME'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],

      ACCUSER_TITLE_SHORT_NAME_TH: json['ACCUSER_TITLE_SHORT_NAME_TH'],
      ACCUSER_FIRST_NAME: json['ACCUSER_FIRST_NAME'],
      ACCUSER_LAST_NAME: json['ACCUSER_LAST_NAME'],
      LAWSUIT_DATE: json['LAWSUIT_DATE'],
      LAWSUIT_OFFICE_NAME: json['LAWSUIT_OFFICE_NAME'],
      LAWSUIT_TITLE_SHORT_NAME_TH: json['LAWSUIT_TITLE_SHORT_NAME_TH'],
      LAWSUIT_FIRST_NAME: json['LAWSUIT_FIRST_NAME'],
      LAWSUIT_LAST_NAME: json['LAWSUIT_LAST_NAME'],


      IndicmentDetail: List.from(
          json['LawsuitArrestIndictmentDetail'].map((m) =>
              ItemsLawsuitListIndicmentDetail.fromJson(m))),
      INDICTMENT_IS_LAWSUIT_COMPLETE: json['INDICTMENT_IS_LAWSUIT_COMPLETE'],
    );
  }
}