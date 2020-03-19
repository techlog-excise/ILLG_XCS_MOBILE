class ItemsListArrestStaff {
  final int STAFF_ID;
  final int STAFF_TYPE;
  final String STAFF_CODE;
  final int STAFF_REF_ID;
  final String ID_CARD;
  final int TITLE_ID;
  final String TITLE_NAME_TH;
  final String TITLE_SHORT_NAME_TH;
  final String FIRST_NAME;
  final String LAST_NAME;
  final String OPREATION_POS_NAME;
  final String OPREATION_POS_LAVEL_NAME;
  final String OPERATION_OFFICE_CODE;
  final String OPERATION_OFFICE_NAME;
  final String OPERATION_OFFICE_SHORT_NAME;
  final String MANAGEMENT_POS_NAME;
  //added 20-09-2019
  final String BIRTH_DATE;
  final String OPERATION_POS_CODE;
  final String OPREATION_POS_LEVEL;
  final String OPERATION_POS_LEVEL_NAME;
  final String OPERATION_DEPT_CODE;
  final String OPERATION_DEPT_NAME;
  final int OPERATION_DEPT_LEVEL;
  final String OPERATION_UNDER_DEPT_CODE;
  final String OPERATION_UNDER_DEPT_NAME;
  final int OPERATION_UNDER_DEPT_LEVEL;
  final String OPERATION_WORK_DEPT_CODE;
  final String OPERATION_WORK_DEPT_NAME;
  int OPERATION_WORK_DEPT_LEVEL;

  int CONTRIBUTOR_ID;
  bool IsCheck;
  String ArrestType;
  bool IsCreated;
  List<String> ArrestTypeItems;

  ItemsListArrestStaff({
    this.STAFF_ID,
    this.STAFF_TYPE,
    this.STAFF_CODE,
    this.STAFF_REF_ID,
    this.ID_CARD,
    this.TITLE_ID,
    this.TITLE_NAME_TH,
    this.TITLE_SHORT_NAME_TH,
    this.FIRST_NAME,
    this.LAST_NAME,
    this.OPREATION_POS_NAME,
    this.OPREATION_POS_LAVEL_NAME,
    this.OPERATION_OFFICE_CODE,
    this.OPERATION_OFFICE_NAME,
    this.OPERATION_OFFICE_SHORT_NAME,
    this.MANAGEMENT_POS_NAME,
    this.BIRTH_DATE,
    this.OPERATION_POS_CODE,
    this.OPREATION_POS_LEVEL,
    this.OPERATION_POS_LEVEL_NAME,
    this.OPERATION_DEPT_CODE,
    this.OPERATION_DEPT_NAME,
    this.OPERATION_DEPT_LEVEL,
    this.OPERATION_UNDER_DEPT_CODE,
    this.OPERATION_UNDER_DEPT_NAME,
    this.OPERATION_UNDER_DEPT_LEVEL,
    this.OPERATION_WORK_DEPT_CODE,
    this.OPERATION_WORK_DEPT_NAME,
    this.OPERATION_WORK_DEPT_LEVEL,
    this.CONTRIBUTOR_ID,
    this.IsCheck,
    this.ArrestType,
    this.IsCreated,
    this.ArrestTypeItems,
  });

  factory ItemsListArrestStaff.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestStaff(
        STAFF_ID: js['STAFF_ID'],
        STAFF_TYPE: js['STAFF_TYPE'],
        STAFF_CODE: js['STAFF_CODE'],
        STAFF_REF_ID: js['STAFF_REF_ID'],
        ID_CARD: js['ID_CARD'],
        TITLE_ID: js['TITLE_ID'],
        TITLE_NAME_TH: js['TITLE_NAME_TH'] == null ? "" : js['TITLE_NAME_TH'],
        TITLE_SHORT_NAME_TH: js['TITLE_SHORT_NAME_TH'] == null ? js['TITLE_NAME_TH'] : js['TITLE_SHORT_NAME_TH'],
        FIRST_NAME: js['FIRST_NAME'] == null ? "" : js['FIRST_NAME'],
        LAST_NAME: js['LAST_NAME'] == null ? "" : js['LAST_NAME'],
        OPREATION_POS_NAME: js['OPREATION_POS_NAME'] == null ? "" : js['OPREATION_POS_NAME'],
        OPREATION_POS_LAVEL_NAME: js['MANAGEMENT_POS_LEVEL_NAME'] == null ? "" : js['MANAGEMENT_POS_LEVEL_NAME'],
        OPERATION_OFFICE_CODE: js['OPERATION_OFFICE_CODE'] == null ? "" : js['OPERATION_OFFICE_CODE'],
        OPERATION_OFFICE_NAME: js['OPERATION_OFFICE_NAME'] == null ? "" : js['OPERATION_OFFICE_NAME'],
        OPERATION_OFFICE_SHORT_NAME: js['OPERATION_OFFICE_SHORT_NAME'] == null ? "" : js['OPERATION_OFFICE_SHORT_NAME'],
        MANAGEMENT_POS_NAME: js['MANAGEMENT_POS_NAME'] == null ? "" : js['MANAGEMENT_POS_NAME'],
        BIRTH_DATE: js['BIRTH_DATE'],
        OPERATION_POS_CODE: js['OPERATION_POS_CODE'],
        OPREATION_POS_LEVEL: js['OPREATION_POS_LEVEL'],
        OPERATION_POS_LEVEL_NAME: js['OPERATION_POS_LEVEL_NAME'],
        OPERATION_DEPT_CODE: js['OPERATION_DEPT_CODE'],
        OPERATION_DEPT_NAME: js['OPERATION_DEPT_NAME'],
        OPERATION_DEPT_LEVEL: js['OPERATION_DEPT_LEVEL'],
        OPERATION_UNDER_DEPT_CODE: js['OPERATION_UNDER_DEPT_CODE'],
        OPERATION_UNDER_DEPT_NAME: js['OPERATION_UNDER_DEPT_NAME'],
        OPERATION_UNDER_DEPT_LEVEL: js['OPERATION_UNDER_DEPT_LEVEL'],
        OPERATION_WORK_DEPT_CODE: js['OPERATION_WORK_DEPT_CODE'],
        OPERATION_WORK_DEPT_NAME: js['OPERATION_WORK_DEPT_NAME'],
        OPERATION_WORK_DEPT_LEVEL: js['OPERATION_WORK_DEPT_LEVEL'],
        CONTRIBUTOR_ID: js['CONTRIBUTOR_ID'],
        IsCheck: false,
        ArrestType: js['CONTRIBUTOR_ID'] == 14 ? "ผู้จับกุม" : (js['CONTRIBUTOR_ID'] == 10 ? "ผู้สั่งการ" : "ผู้ร่วมจับกุม"),
        ArrestTypeItems: ["ผู้จับกุม", "ผู้ร่วมจับกุม", "ผู้สั่งการ"],
        IsCreated: false);
  }
}
