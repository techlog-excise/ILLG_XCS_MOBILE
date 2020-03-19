
class ItemsListArrestPhotoPerson {
  int PHOTO_ID;
  int PERSON_ID;
  int PERSON_RELATIONSHIP_ID;
  String PHOTO;
  int TYPE;
  int IS_ACTIVE;

  ItemsListArrestPhotoPerson({
    this.PHOTO_ID,
    this.PERSON_ID,
    this.PERSON_RELATIONSHIP_ID,
    this.PHOTO,
    this.TYPE,
    this.IS_ACTIVE,});

  factory ItemsListArrestPhotoPerson.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestPhotoPerson(
        PHOTO_ID: js['PHOTO_ID'],
        PERSON_ID: js['PERSON_ID'],
        PERSON_RELATIONSHIP_ID: js['PERSON_RELATIONSHIP_ID'],
        PHOTO: js['PHOTO'],
        TYPE: js['TYPE'],
        IS_ACTIVE: js['IS_ACTIVE'],
    );
  }
}