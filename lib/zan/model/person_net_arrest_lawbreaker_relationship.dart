
class ItemsListPersonNetLawbreakerRelationShip {
  final int LAWBREAKER_ID;
  final int PERSON_ID;
  final String PHOTO;
  final String ARREST_LAWBREAKER_NAME;
  final String ARREST_CODE;
  final String OCCURRENCE_DATE;
  final String SECTION_NAME;
  final String GUILTBASE_NAME;
  final String PRODUCT_GROUP_NAME;
  final int DOCUMENT_ID;
  final String FILE_PATH;
  int REF_CODE;

  ItemsListPersonNetLawbreakerRelationShip({
    this.LAWBREAKER_ID,
    this.PERSON_ID,
    this.PHOTO,
    this.ARREST_LAWBREAKER_NAME,
    this.ARREST_CODE,
    this.OCCURRENCE_DATE,
    this.SECTION_NAME,
    this.GUILTBASE_NAME,
    this.PRODUCT_GROUP_NAME,
    this.DOCUMENT_ID,
    this.FILE_PATH,
    this.REF_CODE,
  });

  factory ItemsListPersonNetLawbreakerRelationShip.fromJson(
      Map<String, dynamic> js) {
    return ItemsListPersonNetLawbreakerRelationShip(
      LAWBREAKER_ID: js['LAWBREAKER_ID'],
      PERSON_ID: js['PERSON_ID'],
      PHOTO: js['PHOTO'],
      ARREST_LAWBREAKER_NAME: js['ARREST_LAWBREAKER_NAME'],
      ARREST_CODE: js['ARREST_CODE'],
      OCCURRENCE_DATE: js['OCCURRENCE_DATE'],
      SECTION_NAME: js['SECTION_NAME'],
      GUILTBASE_NAME: js['GUILTBASE_NAME'],
      PRODUCT_GROUP_NAME: js['PRODUCT_GROUP_NAME'],
      DOCUMENT_ID: js['DOCUMENT_ID'],
      FILE_PATH: js['FILE_PATH'],
      REF_CODE: js['REF_CODE'],
    );
  }
}