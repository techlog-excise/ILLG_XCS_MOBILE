class ItemsCompareList {
  int COMPARE_ID;
  int LAWSUIT_ID;
  int INDICTMENT_ID;
  String COMPARE_NO;
  String COMPARE_NO_YEAR;
  //String COMPARE_TITLE_NAME_TH;
  //String COMPARE_TITLE_SHORT_NAME_TH;
  //String COMPARE_FIRST_NAME;
  //String COMPARE_LAST_NAME;
  //dynamic LAWSUIT_NO;
  String LAWSUIT_NO;
  String LAWSUIT_NO_YEAR;
  //String LAWSUIT_TITLE_NAME_TH;
  //String LAWSUIT_TITLE_SHORT_NAME_TH;
  //String LAWSUIT_FIRST_NAME;
  //String LAWSUIT_LAST_NAME;
  int COMPARE_IS_OUTSIDE;
  int IS_PROVE;
  int IS_COMPARE;
  String PROVE_NO;
  String PROVE_NO_YEAR;

  ItemsCompareList({
    this.COMPARE_ID,
    this.LAWSUIT_ID,
    this.INDICTMENT_ID,
    this.COMPARE_NO,
    this.COMPARE_NO_YEAR,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    //this.COMPARE_TITLE_NAME_TH,
    //this.COMPARE_TITLE_SHORT_NAME_TH,
    //this.COMPARE_FIRST_NAME,
    //this.COMPARE_LAST_NAME,
    //this.LAWSUIT_TITLE_NAME_TH,
    //this.LAWSUIT_TITLE_SHORT_NAME_TH,
    //this.LAWSUIT_FIRST_NAME,
    //this.LAWSUIT_LAST_NAME,
    this.COMPARE_IS_OUTSIDE,
    this.IS_PROVE,
    this.IS_COMPARE,
    this.PROVE_NO,
    this.PROVE_NO_YEAR,
  });

  factory ItemsCompareList.fromJson(Map<String, dynamic> json) {
    return ItemsCompareList(
      COMPARE_ID: json['COMPARE_ID'],
      LAWSUIT_ID: json['LAWSUIT_ID'],
      INDICTMENT_ID: json['INDICTMENT_ID'],
      COMPARE_NO: json['COMPARE_NO'],
      COMPARE_NO_YEAR: json['COMPARE_NO_YEAR'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],
      //COMPARE_TITLE_NAME_TH: json['COMPARE_TITLE_NAME_TH'],
      //COMPARE_TITLE_SHORT_NAME_TH: json['COMPARE_TITLE_SHORT_NAME_TH'],
      //COMPARE_FIRST_NAME: json['COMPARE_FIRST_NAME'],
      //COMPARE_LAST_NAME: json['COMPARE_LAST_NAME'],
      //LAWSUIT_TITLE_NAME_TH: json['LAWSUIT_TITLE_NAME_TH'],
      //LAWSUIT_TITLE_SHORT_NAME_TH: json['LAWSUIT_TITLE_SHORT_NAME_TH'],
      //LAWSUIT_FIRST_NAME: json['LAWSUIT_FIRST_NAME'],
      //LAWSUIT_LAST_NAME: json['LAWSUIT_LAST_NAME'],
      COMPARE_IS_OUTSIDE: json['COMPARE_IS_OUTSIDE'],
      IS_PROVE: json['IS_PROVE'],
      IS_COMPARE: json['IS_COMPARE'],
      PROVE_NO: json['PROVE_NO'],
      PROVE_NO_YEAR: json['PROVE_NO_YEAR'],
    );
  }
}
