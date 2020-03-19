class ItemsListArrestIndictmentDetail {
  final int INDICTMENT_DETAIL_ID;
  final int INDICTMENT_ID;
  final int LAWBREAKER_ID;
  final String TITLE_SHORT_NAME_TH;
  final String FIRST_NAME;
  final String MIDDLE_NAME;
  final String LAST_NAME;
  final String OTHER_NAME;

  final int PERSON_ID;
  final int PERSON_TYPE;
  final String TITLE_SHORT_NAME_EN;
  final String TITLE_NAME_TH;
  final String TITLE_NAME_EN;
  final String COMPANY_NAME;

  ItemsListArrestIndictmentDetail({
    this.INDICTMENT_DETAIL_ID,
    this.INDICTMENT_ID,
    this.LAWBREAKER_ID,
    this.TITLE_SHORT_NAME_TH,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
    this.PERSON_ID,
    this.PERSON_TYPE,
    this.TITLE_SHORT_NAME_EN,
    this.TITLE_NAME_TH,
    this.TITLE_NAME_EN,
    this.COMPANY_NAME,
  });

  factory ItemsListArrestIndictmentDetail.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestIndictmentDetail(
      INDICTMENT_DETAIL_ID: js['INDICTMENT_DETAIL_ID'],
      INDICTMENT_ID: js['INDICTMENT_ID'],
      LAWBREAKER_ID: js['LAWBREAKER_ID'],
      TITLE_SHORT_NAME_TH: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['TITLE_SHORT_NAME_TH'] == null ? "" : js['ArrestLawbreaker']['TITLE_SHORT_NAME_TH'] : "",
      FIRST_NAME: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['FIRST_NAME'] == null ? "" : js['ArrestLawbreaker']['FIRST_NAME'] : "",
      MIDDLE_NAME: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['MIDDLE_NAME'] : "",
      LAST_NAME: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['LAST_NAME'] == null ? "" : js['ArrestLawbreaker']['LAST_NAME'] : "",
      OTHER_NAME: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['OTHER_NAME'] : "",
      PERSON_ID: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['PERSON_ID'] == null ? "" : js['ArrestLawbreaker']['PERSON_ID'] : null,
      PERSON_TYPE: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['PERSON_TYPE'] == null ? "" : js['ArrestLawbreaker']['PERSON_TYPE'] : null,
      TITLE_SHORT_NAME_EN: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['TITLE_SHORT_NAME_EN'] == null ? "" : js['ArrestLawbreaker']['TITLE_SHORT_NAME_EN'] : "",
      TITLE_NAME_TH: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['TITLE_NAME_TH'] == null ? "" : js['ArrestLawbreaker']['TITLE_NAME_TH'] : "",
      TITLE_NAME_EN: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['TITLE_NAME_EN'] == null ? "" : js['ArrestLawbreaker']['TITLE_NAME_EN'] : "",
      COMPANY_NAME: js['ArrestLawbreaker'] != null ? js['ArrestLawbreaker']['COMPANY_NAME'] == null ? "" : js['ArrestLawbreaker']['COMPANY_NAME'] : "",
    );
  }
}
