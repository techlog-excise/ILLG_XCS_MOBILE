class ItemsPersonInformation {
  int STAFF_ID;
  int PersonType;
  int STAFF_TYPE;
  int TITLE_ID;
  String TITLE_NAME_TH;
  String TITLE_SHORT_NAME_TH;
  String FIRST_NAME;
  String LAST_NAME;
  String PersonENTitle;
  String PersonENName;
  String PersonENSurName;
  String UnderOffCode;
  String UnderOffName;
  int UnderDeptCode;
  String UnderDeptName;
  String OPERATION_OFFICE_CODE;
  String OPERATION_OFFICE_NAME;
  String OPERATION_OFFICE_SHORT_NAME;
  int WorkDeptCode;
  String WorkDeptName;
  String LinePositionCode;
  String OPREATION_POS_LAVEL_NAME;
  String OPREATION_POS_NAME;
  String MANAGEMENT_POS_NAME;
  String ExcPositionCode;
  String ExcPosition;
  String ActingExcPositionCode;
  String ActingExcPosition;
  String EmailAddress;
  String DeptPhoneNo;
  String PersonStatus;
  String ArrestType;
  int CONTRIBUTOR_ID;
  List<String> ArrestTypeItems;
  bool IsCreated;
  String ID_CARD;

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

  /*int STAFF_ID;
  String PersonType;
  int STAFF_TYPE;
  String TITLE_SHORT_NAME_TH;
  String FIRST_NAME;
  String LAST_NAME;
  String PersonENTitle;
  String PersonENName;
  String PersonENSurName;
  String UnderOffCode;
  String UnderOffName;
  int UnderDeptCode;
  String UnderDeptName;
  String OPERATION_OFFICE_CODE;
  String OPERATION_OFFICE_NAME;
  String OPERATION_OFFICE_SHORT_NAME;
  int WorkDeptCode;
  String WorkDeptName;
  String LinePositionCode;
  String OPREATION_POS_LAVEL_NAME;
  String OPREATION_POS_NAME;
  int ExcPositionCode;
  String ExcPosition;
  int ActingExcPositionCode;
  String ActingExcPosition;
  String EmailAddress;
  String DeptPhoneNo;
  String PersonStatus;
  String ArrestType;
  int CONTRIBUTOR_ID;
  List<String> ArrestTypeItems;
  bool IsCreated;

  String ID_CARD;*/

  ItemsPersonInformation({
    this.STAFF_ID,
    this.PersonType,
    this.STAFF_TYPE,
    this.TITLE_ID,
    this.TITLE_NAME_TH,
    this.TITLE_SHORT_NAME_TH,
    this.FIRST_NAME,
    this.LAST_NAME,
    this.PersonENTitle,
    this.PersonENName,
    this.PersonENSurName,
    this.UnderOffCode,
    this.UnderOffName,
    this.UnderDeptCode,
    this.UnderDeptName,
    //this.WorkOffCode,
    this.OPERATION_OFFICE_CODE,
    this.OPERATION_OFFICE_NAME,
    this.OPERATION_OFFICE_SHORT_NAME,
    this.WorkDeptCode,
    this.WorkDeptName,
    this.LinePositionCode,
    this.OPREATION_POS_LAVEL_NAME,
    this.OPREATION_POS_NAME,
    this.MANAGEMENT_POS_NAME,
    this.ExcPositionCode,
    this.ExcPosition,
    this.ActingExcPositionCode,
    this.ActingExcPosition,
    this.EmailAddress,
    this.DeptPhoneNo,
    this.PersonStatus,
    this.CONTRIBUTOR_ID,
    this.ArrestType,
    this.ArrestTypeItems,
    this.IsCreated,
    this.ID_CARD,
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
  });

  factory ItemsPersonInformation.fromJson(Map<String, dynamic> json) {
    return ItemsPersonInformation(
      STAFF_ID: json['STAFF_ID'],
      PersonType: json['USER_TYPE'],
      STAFF_TYPE: json['STAFF_TYPE'],
      TITLE_ID: json['TITLE_ID'],
      TITLE_NAME_TH: json['TITLE_NAME_TH'],
      TITLE_SHORT_NAME_TH: json['TITLE_SHORT_NAME_TH'] == null ? json['TITLE_NAME_TH'] : json['TITLE_SHORT_NAME_TH'],
      FIRST_NAME: json['FIRST_NAME'],
      LAST_NAME: json['LAST_NAME'],
      PersonENTitle: "",
      PersonENName: "",
      PersonENSurName: "",
      UnderOffCode: "",
      UnderOffName: "",
      UnderDeptCode: null,
      UnderDeptName: "",
      OPERATION_OFFICE_CODE: json['OPERATION_OFFICE_CODE'],
      OPERATION_OFFICE_NAME: json['OPERATION_OFFICE_NAME'],
      OPERATION_OFFICE_SHORT_NAME: json['OPERATION_OFFICE_SHORT_NAME'],
      WorkDeptCode: null,
      WorkDeptName: "",
      LinePositionCode: null,
      OPREATION_POS_LAVEL_NAME: json['OPERATION_POS_LEVEL_NAME'],
      OPREATION_POS_NAME: json['OPREATION_POS_NAME'],
      MANAGEMENT_POS_NAME: json['MANAGEMENT_POS_NAME'],
      ExcPositionCode: "",
      ExcPosition: "",
      ActingExcPositionCode: "",
      ActingExcPosition: "",
      EmailAddress: "",
      DeptPhoneNo: "",
      PersonStatus: "",
      CONTRIBUTOR_ID: 14,
      ArrestType: "ผู้จับกุม",
      ArrestTypeItems: ["ผู้จับกุม", "ผู้ร่วมจับกุม", "ผู้สั่งการ"],
      IsCreated: false,
      ID_CARD: json['ID_CARD'],
      BIRTH_DATE: json['BIRTH_DATE'],
      OPERATION_POS_CODE: json['OPERATION_POS_CODE'],
      OPREATION_POS_LEVEL: json['OPREATION_POS_LEVEL'],
      OPERATION_POS_LEVEL_NAME: json['OPERATION_POS_LEVEL_NAME'],
      OPERATION_DEPT_CODE: json['OPERATION_DEPT_CODE'],
      OPERATION_DEPT_NAME: json['OPERATION_DEPT_NAME'],
      OPERATION_DEPT_LEVEL: json['OPERATION_DEPT_LEVEL'],
      OPERATION_UNDER_DEPT_CODE: json['OPERATION_UNDER_DEPT_CODE'],
      OPERATION_UNDER_DEPT_NAME: json['OPERATION_UNDER_DEPT_NAME'],
      OPERATION_UNDER_DEPT_LEVEL: json['OPERATION_UNDER_DEPT_LEVEL'],
      OPERATION_WORK_DEPT_CODE: json['OPERATION_WORK_DEPT_CODE'],
      OPERATION_WORK_DEPT_NAME: json['OPERATION_WORK_DEPT_NAME'],
      OPERATION_WORK_DEPT_LEVEL: json['OPERATION_WORK_DEPT_LEVEL'],

      /*STAFF_ID: json['PersonID'],
      PersonType: json['PersonType'],
      STAFF_TYPE: 0,
      TITLE_SHORT_NAME_TH: json['PersonTHTitle'],
      FIRST_NAME: json['PersonTHName'],
      LAST_NAME: json['PersonTHSurName'],
      PersonENTitle: json['PersonENTitle'],
      PersonENName: json['PersonENName'],
      PersonENSurName: json['PersonENSurName'],
      UnderOffCode: json['UnderOffCode'],
      UnderOffName: json['UnderOffName'],
      UnderDeptCode: json['UnderDeptCode'],
      UnderDeptName: json['UnderDeptName'],
      OPERATION_OFFICE_CODE: json['WorkOffCode'],
      OPERATION_OFFICE_NAME: json['WorkOffName'],
      OPERATION_OFFICE_SHORT_NAME: "",
      WorkDeptCode: json['WorkDeptCode'],
      WorkDeptName: json['WorkDeptName'],
      LinePositionCode: json['LinePositionCode'],
      OPREATION_POS_LAVEL_NAME: json['LinePositionLevel'],
      OPREATION_POS_NAME: json['LinePotistion'],
      ExcPositionCode: json['ExcPositionCode'],
      ExcPosition: json['ExcPosition'],
      ActingExcPositionCode: json['ActingExcPositionCode'],
      ActingExcPosition: json['ActingExcPosition'],
      EmailAddress: json['EmailAddress'],
      DeptPhoneNo: json['DeptPhoneNo'],
      PersonStatus: json['PersonStatus'],
        CONTRIBUTOR_ID: 14,
        ArrestType: "ผู้จับกุม",
        ArrestTypeItems: ["ผู้จับกุม", "ผู้ร่วมจับกุม", "ผู้สั่งการ"],
        IsCreated: false,
        ID_CARD: json['ID_CARD'],*/
    );
  }
}
